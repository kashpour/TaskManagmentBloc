import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managment_bloc/injectable/injectable.dart';
import 'package:task_managment_bloc/resources/app_bloc_observer.dart';
import 'data/repositories/auth_repo/auth_repo.dart';
import 'data/repositories/task_repo/task_repo.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/view/auth_view.dart';

import 'features/home/bloc/task_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
  
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepo: getIt<AuthRepo>()),
        ),
        BlocProvider(
          create: (context) => TaskBloc(authRepo:  getIt<AuthRepo>(), taskRepo:  getIt<TaskRepo>()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthView(),
      ),
    );
  }
}
