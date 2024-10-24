import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managment_bloc/features/auth/view/login/login_view.dart';

import '../../../../utils/constants/my_colors.dart';
import '../../bloc/auth_bloc.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final bool isObscurePassword = false;

  @override
  Widget build(BuildContext context) {
    txtEmail.text = 'test@gmail.com';
    txtPassword.text = '123456';

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthNavigateToLoginState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginView()));
        } else if (state is AuthSignupState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginView()));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Sigup'),
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                const Text(
                  'Welcome\nBack!',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Text(
                  'Hey! Good to see you again',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            suffixIcon: const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: txtPassword,
                          obscureText: isObscurePassword,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.black),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                              icon: const Icon(Icons.visibility_off_outlined),
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 50)),
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                AuthSignupButtonPressedEvent(
                                    email: txtEmail.text,
                                    password: txtPassword.text));
                          },
                          child: const Text(
                            'Sign up',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "You have an account already!",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            GestureDetector(
                                onTap: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthNavigateToLoginPressedEvent());
                                },
                                child: const Text(
                                  'Login',
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
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
