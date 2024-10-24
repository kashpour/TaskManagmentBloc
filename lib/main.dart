import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managment_bloc/data/repositories/auth_repo.dart';
import 'package:task_managment_bloc/features/auth/bloc/auth_bloc.dart';
import 'package:task_managment_bloc/features/auth/view/auth_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthRepo authRepo = DevAuthRepo();
    return BlocProvider(
      create: (context) => AuthBloc(authRepo: authRepo),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthView(),
      ),
    );
  }
}
