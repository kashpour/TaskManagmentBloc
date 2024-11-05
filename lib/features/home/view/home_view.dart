import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managment_bloc/data/repositories/auth_repo/auth_repo.dart';
import 'package:task_managment_bloc/data/repositories/task_repo/task_repo.dart';
import 'package:task_managment_bloc/features/home/bloc/task_bloc.dart';
import 'package:task_managment_bloc/features/home/view/home_page.dart';
import 'package:task_managment_bloc/injectable/configure_dependencies.dart';

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
