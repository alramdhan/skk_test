import 'package:flutter/material.dart';
import 'dart:math';

import 'package:skk_test/src/constants.dart';
import 'package:skk_test/src/custom_route.dart';
import 'package:skk_test/src/model/User.dart';
import 'package:skk_test/src/service/api_client.dart';
import 'package:skk_test/src/widgets/custom_input_field.dart';
import 'package:skk_test/src/neon_bg.dart';
import 'package:skk_test/src/view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    required this.title,
    this.response
  }) : super(key: key);

  final String title;
  final Map<String, dynamic>? response;

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4)
    );
    _animation = Tween<double>(
      begin: 0,
      end: 2 * pi
    ).animate(_controller);

    _controller.repeat();
    _controller.addListener(() => setState(() { }));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Center(
          child: Wrap(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: size.width,
                          height: size.height * .6,
                          decoration: BoxDecoration(
                            color: darkBlue,
                            boxShadow: [
                              blackShadow
                            ]
                          ),
                        ),
                        Positioned(
                          top: (size.height * .6) / 2,
                          left: size.width / 2,
                          child: NeonBGContainer(
                            width: size.width,
                            height: size.height,
                            animation: _animation,
                            alignment: Alignment.topLeft,
                            colors: const [
                              Color(0x1A55FFF9),
                              neonBlue,
                            ]
                          )
                        ),
                        Positioned(
                          bottom: (size.height * .6) / 2,
                          right: size.width / 2,
                          child: NeonBGContainer(
                            width: size.width,
                            height: size.height,
                            animation: _animation,
                            alignment: Alignment.bottomRight,
                            colors: const [
                              neonBlue,
                              Color(0x1A55FFF9),
                            ]
                          )
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          width: size.width - 50,
                          height: (size.height * .6) - 10,
                          decoration: const BoxDecoration(
                            color: lightDarkBlue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20)
                            )
                          ),
                          child: SignInForm(title: widget.title),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
    required this.title
  }) : super(key: key);

  final String title;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiClient _apiClient = ApiClient();
  bool _showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('Form Login',
              style: TextStyle(
                color: neonBlue,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                letterSpacing: 1
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomInputField(label: 'Email', controller: emailController),
        CustomInputField(
          label: 'Password',
          controller: passwordController,
          showPassword: _showPassword,
          enableSuggestion: false,
          autoCorrect: false,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(
                () => _showPassword = !_showPassword
              );
            },
            child: Icon(
              _showPassword
                ? Icons.visibility
                : Icons.visibility_off,
              color: Colors.grey,
            ),
          )
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: neonBlue,
            padding: const EdgeInsets.symmetric(horizontal: 30)
          ),
          onPressed: _handleSubmitted,
          child: const Text('Sign in',
            style: TextStyle(
              color: darkBlue,
              fontSize: 16,
              fontWeight: FontWeight.w500
            )
          )
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Don\'t have an account? ',
              style: TextStyle(
                fontSize: 14
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  CustomRoute().createRoute(RegisterPage(title: widget.title))
                );
              },
              child: const Text('Sign Up',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Future<void> _handleSubmitted() async {
    if(_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Processing Data'),
        backgroundColor: neonBlue,
      ));

      dynamic _response = await _apiClient.login(emailController.text, passwordController.text);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if(_response['code'] == 0) {
        var _model = User.fromJson(_response["data"]);
        String accessToken = _model.token;
        Navigator.of(context).push(
          CustomRoute().createRoute(HomePage(title: "SKK Test", accesstoken: accessToken))
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${_response['message']}'),
          backgroundColor: neonBlue,
        ));
      }
    }
  }
}