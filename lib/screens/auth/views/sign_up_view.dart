import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/constants/constants.dart';
import 'package:pizza/screens/auth/blocs/sign_up_bloc.dart';
import 'package:pizza/widgets/custom_text_field.dart';
import 'package:user_repository/user_repository.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _hidePassword = false;
  bool _signUpRrquired = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailed) {
          log(state.message);
          setState(() {
            _signUpRrquired = true;
          });
        }else if(state is SignUpSuccess){
          setState(() {
            _signUpRrquired = false;
          });
        }else if (state is SignUpLoading){
          setState(() {
            _signUpRrquired = false;
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
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    } else if (value.length > 30) {
                      return 'Name is too long';
                    }
                    return null;
                  },
                  label: 'Full Name',
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  prefixIcon: const Icon(CupertinoIcons.person)),
              space8,
              CustomTextField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                        .hasMatch(value)) {
                      return 'Password should be atleast 8 character long\nShould contain both uppercase and lowercase characters\nShould contain atleast on special character';
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
                  child: _signUpRrquired ? ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          MyUser user = MyUser(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              id: '');
                          context.read<SignUpBloc>().add(SignUpRequired(
                              user, _passwordController.text.trim()));
                        }
                      },
                      child: const Text('Create Account')):const CircularProgressIndicator())
            ],
          )),
    );
  }
}
