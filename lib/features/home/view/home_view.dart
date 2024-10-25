import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managment_bloc/features/home/view/widgets/custom_task_widget.dart';

import '../../../utils/constants/my_colors.dart';
import '../../auth/view/login/login_view.dart';
import '../bloc/task_bloc.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TextEditingController txtTitle = TextEditingController();

  final TextEditingController txtDescription = TextEditingController();

  final TextEditingController txtDateTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is UserLogOutState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginView()));
        } else if (state is TaskAddNewTaskState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Added New Task')));
          txtTitle.clear();
          txtDescription.clear();
          txtDateTime.clear();
        } else if (state is TaskAddNewTaskDialogState) {
          customShowDialog(context);
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () {
            context.read<TaskBloc>().add(TaskAddNewTaskButtonPressedEvent());
          },
          child: const Icon(Icons.add, size: 28.0, color: Colors.white),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () =>
                  context.read<TaskBloc>().add(TaskLogOutButtonPressedEvent()),
              icon: const Icon(Icons.logout, size: 32.0, color: Colors.black),
            )
          ],
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: mainColor),
            child: const SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10.0),
                  CircleAvatar(child: Icon(Icons.person)),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ibrahim Kashbor',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ibrahimkashbor@gmail.com',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            return const CustomTaskWidget(
              title: 'title',
              description: 'Descrio',
              dateTime: 'DateTime',
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> customShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titleTextStyle: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            backgroundColor: mainColor,
            title: const Text('Add New Task'),
            content: SizedBox(
              width: 150,
              height: 190,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    controller: txtTitle,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: 'Title'),
                  ),
                  TextField(
                    controller: txtDescription,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: 'Description'),
                  ),
                  TextField(
                    controller: txtDateTime,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: 'Date Time'),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    context.read<TaskBloc>().add(TaskAddNewTaskEvent(
                        title: txtTitle.text,
                        body: txtDescription.text,
                        dateTime: txtDateTime.text));
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          );
        });
  }
}
