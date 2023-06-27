import 'package:flutter/material.dart';
import 'dart:math';

import 'package:skk_test/src/constants.dart';
import 'package:skk_test/src/custom_route.dart';
import 'package:skk_test/src/widgets/custom_input_field.dart';
import 'package:skk_test/src/neon_bg.dart';
import 'package:skk_test/src/service/api_client.dart';
import 'package:skk_test/src/view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
    required this.title
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> with SingleTickerProviderStateMixin {
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
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
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
                              height: size.height * .7,
                              decoration: BoxDecoration(
                                color: darkBlue,
                                boxShadow: [
                                  blackShadow
                                ]
                              ),
                            ),
                            Positioned(
                              top: (size.height * .7) / 2,
                              left: size.width / 2,
                              child: NeonBGContainer(
                                width: size.width,
                                height: size.height,
                                animation: _animation,
                                alignment: Alignment.topLeft,
                                colors: const [
                                  Color(0x1A55FFF9),
                                  neonBlue
                                ]
                              )
                            ),
                            Positioned(
                              bottom: (size.height * .7) / 2,
                              right: size.width / 2,
                              child: NeonBGContainer(
                                width: size.width,
                                height: size.height,
                                animation: _animation,
                                alignment: Alignment.bottomRight,
                                colors: const [
                                  neonBlue,
                                  Color(0x1A55FFF9)
                                ]
                              )
                            ),
                            Container(
                              padding: const EdgeInsets.all(30),
                              width: size.width - 50,
                              height: (size.height * .7) - 10,
                              decoration: const BoxDecoration(
                                color: lightDarkBlue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20)
                                )
                              ),
                              child: SignUpForm(title: widget.title),
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
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
    required this.title
  }) : super(key: key);

  final String title;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ApiClient _apiClient = ApiClient();

  @override
  void dispose() {
    nameController.dispose();
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
            Text('Form Register',
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
        CustomInputField(label: 'Name', controller: nameController),
        CustomInputField(label: 'Email', controller: emailController),
        CustomInputField(
          label: 'Password',
          controller: passwordController,
          showPassword: false,
          enableSuggestion: false,
          autoCorrect: false
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: neonBlue,
            padding: const EdgeInsets.symmetric(horizontal: 30)
          ),
          onPressed: _handleSubmitted,
          child: const Text('Register',
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
            const Text('Already have an account? ',
              style: TextStyle(
                fontSize: 14
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  CustomRoute().createRoute(LoginPage(title: widget.title))
                );
              },
              child: const Text('Sign in',
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

      dynamic _apiResponse = await _apiClient.register(nameController.text, emailController.text, passwordController.text);

      if (_apiResponse["code"] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_apiResponse["message"]))
        );
      } else {
        Navigator.of(context).push(
          CustomRoute().createRoute(const LoginPage(title: "SKK Test"))
        );
      }
    }
  }
}