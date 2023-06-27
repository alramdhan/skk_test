import 'package:flutter/material.dart';

import 'package:skk_test/src/custom_route.dart';
import 'package:skk_test/src/view.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({
    Key? key
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatePage();
  }

  _navigatePage() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Navigator.of(context).push(
        CustomRoute().createRoute(const LoginPage(title: "SKK Test"))
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset("assets/images/1640584327-Logo-Provider.png",
                    width: 200.0,
                    height: 200.0
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset("assets/images/wikrama.png", width: 200.0, height: 150.0),
              ),
            )
          ],
        ),
      )
    )
  );
}