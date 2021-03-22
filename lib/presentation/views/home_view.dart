import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/assets.dart';
import '../../providers/providers.dart';

import './question_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    final messager = Provider.of<MessagerProvider>(context);
    if (messager.hasErrorMessage) {
      _scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(messager.errorMessage),
        duration: Duration(milliseconds: 500),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          width: double.maxFinite,
          height: mediaQuery.size.height,
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(
                maxHeight: mediaQuery.size.height - mediaQuery.padding.top,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    HOME_IMAGE_LOCATION,
                    width: 200.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Quiz App!',
                      style: theme.textTheme.headline1,
                    ),
                  ),
                  Consumer<QuestionProvider>(
                    builder: (context, quiz, _) {
                      if (quiz.isLoadingQuestions) {
                        return CircularProgressIndicator();
                      }

                      return ElevatedButton(
                        child: Text(
                          'Let\'s Go!',
                          style: theme.textTheme.button,
                        ),
                        onPressed: () => _findQuestionsAndStart(quiz, context),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _findQuestionsAndStart(QuestionProvider quiz, BuildContext context) async {
    await quiz.loadQuestions();
    if (quiz.isSuccessLoaded) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => QuestionView()));
    } else {
      Provider.of<MessagerProvider>(context, listen: false)
          .sendErrorMessage(quiz.errorMessage);
    }
  }
}
