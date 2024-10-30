import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injectable/configure_dependencies.dart';
import 'resources/app_bloc_observer.dart';
import 'data/repositories/auth_repo/auth_repo.dart';
import 'data/repositories/task_repo/task_repo.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/view/auth_view.dart';

import 'features/home/bloc/task_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();

  configureDependencies(Env.prod);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepo: getIt<AuthRepo>()),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(
              authRepo: getIt<AuthRepo>(), taskRepo: getIt<TaskRepo>()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthView(),
      ),
    );
  }
}
