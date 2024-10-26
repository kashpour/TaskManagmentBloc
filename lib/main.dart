import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/auth_repo.dart';
import 'data/repositories/task_repo.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/view/auth_view.dart';

import 'features/home/bloc/task_bloc.dart';

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
    final TaskRepo taskRepo = DevTaskRepo();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepo: authRepo),
        ),
        BlocProvider(
          create: (context) => TaskBloc(authRepo: authRepo, taskRepo: taskRepo),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthView(),
      ),
    );
  }
}
