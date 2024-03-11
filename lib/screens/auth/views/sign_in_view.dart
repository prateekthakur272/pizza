import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza/constants/constants.dart';
import 'package:pizza/widgets/custom_text_field.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                prefixIcon: const Icon(CupertinoIcons.mail)),
            space8,
            CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(_hidePassword
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash),
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                ),
                controller: _passwordController,
                label: 'Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: _hidePassword,
                prefixIcon: const Icon(CupertinoIcons.lock)),
            space8,
            space8,
            space8,
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      (_formKey.currentState!.validate());
                    },
                    child: const Text('SignIn')))
          ],
        ));
  }
}
