import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managment_bloc/features/auth/bloc/auth_bloc.dart';
import 'package:task_managment_bloc/features/auth/view/signup/signup_view.dart';
import '../../../utils/constants/my_colors.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignupView()));
        }
      },
      builder: (context, state) {
        if (state is AuthInitialState) {
          return Scaffold(
            backgroundColor: mainColor,
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                    0.5,
                    0.5
                  ],
                      colors: [
                    lessMainColor,
                    mainColor,
                  ])),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      width: 200,
                      height: 150,
                      image: AssetImage('lib/assets/images/intro_image.png'),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Task Managment',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
