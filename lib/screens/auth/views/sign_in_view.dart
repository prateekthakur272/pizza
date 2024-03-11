import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/constants/constants.dart';
import 'package:pizza/screens/auth/blocs/sign_in_bloc.dart';
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
  bool _signInRequired = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if(state is SignInFailed){
          log(state.message);
          setState(() {
            _signInRequired = true;
          });
        }else if(state is SignInLoading){
          setState(() {
            _signInRequired = false;
          });
        }else if(state is SignInSuccess){
          setState(() {
            _signInRequired = false;
          });
        }
      },
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email address is required';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'please enter a valid email address';
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
                  child: _signInRequired?ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SignInBloc>().add(SignInRequired(_emailController.text, _passwordController.text));
                        }
                      },
                      child: const Text('SignIn')):const CircularProgressIndicator())
            ],
          )),
    );
  }
}
