import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repo/auth_repo.dart';
import '../../../data/repositories/task_repo/task_repo.dart';
import '../bloc/task_bloc.dart';
import 'home_page.dart';
import '../../../injectable/configure_dependencies.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
        authRepo: getIt<AuthRepo>(),
        taskRepo: getIt<TaskRepo>(),
      ),
      child: HomePage(),
    );
  }
}
