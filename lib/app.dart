import 'package:flutter/material.dart';

import './config/theme.dart';
import './presentation/views/home_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: AppTheme.theme,
      home: HomeView(),
    );
  }
}
