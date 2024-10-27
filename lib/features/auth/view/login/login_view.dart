import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/my_colors.dart';
import '../../../home/view/home_view.dart';
import '../../bloc/auth_bloc.dart';
import '../signup/signup_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthNavigateToSignupState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignupView()));
        } else if (state is AuthLoginState) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeView(),
              ));
        } else if (state is AuthForgetPasswordState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('An Email has been sent to reset your password'),
            duration: Duration(seconds: 1),
          ));
        } else if (state is AuthLoadedFailureSate) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(
                content: Text(state.failureMessage),
                duration: const Duration(seconds: 1),
              ))
              .close;
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(120),
                      )),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 25.0, top: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome\nBack!',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Hey! Good to see you again',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 250,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(120))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 100, 16.0, 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: txtEmail,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Email',
                              hintStyle: const TextStyle(color: Colors.black),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              suffixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              bool isObscurePassword = true;
                              if (state is AuthPasswordRevealState) {
                                isObscurePassword = state.isObscure;
                              }
                              return TextField(
                                controller: txtPassword,
                                obscureText: isObscurePassword,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Password',
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      context.read<AuthBloc>().add(
                                          AuthPasswordRevealIconButtonPressedEvent(
                                              isObscure: isObscurePassword));
                                    },
                                    icon: Icon(isObscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined),
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width, 50)),
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                  AuthLoginButtonPressedEvent(
                                      email: txtEmail.text,
                                      password: txtPassword.text));
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.read<AuthBloc>().add(
                                      AuthForgetPasswordButtonPressedEvent(
                                          email: txtEmail.text));
                                },
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account!",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    context.read<AuthBloc>().add(
                                        AuthNavigateToSignupPressedEvent());
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: mainColor,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
