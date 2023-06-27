import 'package:flutter/material.dart';

import 'package:skk_test/src/view.dart';

class MyApp extends StatelessWidget {
  static const String title = "SKK Test";

  const MyApp({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MySplashScreen()
    );
  }
}