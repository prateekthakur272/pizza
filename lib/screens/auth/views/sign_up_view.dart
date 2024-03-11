import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza/constants/constants.dart';
import 'package:pizza/widgets/custom_text_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _emailController = TextEditingController();
  var _hidePassword = false;
  @override
  Widget build(BuildContext context) {
    return Form(
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
            controller: _emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Name is required';
              }
              return null;
            },
            label: 'Full Name',
            keyboardType: TextInputType.name,
            obscureText: false,
            prefixIcon: const Icon(CupertinoIcons.person)),
        space8,
        CustomTextField(
            controller: _emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email is required';
              }
              return null;
            },
            label: 'Password',
            keyboardType: TextInputType.visiblePassword,
            obscureText: _hidePassword,
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
            prefixIcon: const Icon(CupertinoIcons.lock)),
        space8,
        space8,
        space8,
        Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
                onPressed: () {}, child: const Text('Create Account')))
      ],
    ));
  }
}
