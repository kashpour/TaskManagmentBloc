import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managment_bloc/features/home/models/task_model.dart';
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
    context.read<TaskBloc>().add(TaskFetchTasksEvent());

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
          context.read<TaskBloc>().add(TaskFetchTasksEvent());
          customShowDialog(context, true, '');
        } else if (state is TaskUpdateTaskDialogState) {
          context.read<TaskBloc>().add(TaskFetchTasksEvent());
          txtTitle.text = state.task.title;
          txtDescription.text = state.task.description;
          txtDateTime.text = state.task.dateTime;
          customShowDialog(context, false, state.task.id);
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () {
            txtTitle.text = '';
            txtDescription.text = '';
            txtDateTime.text = '';
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
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10.0),
                  const CircleAvatar(child: Icon(Icons.person)),
                  const SizedBox(width: 20.0),
                  BlocBuilder<TaskBloc, TaskState>(
                    builder: (context, state) {
                      String email = '';
                      String userName = '';
                      if (state is TaskLoadedSuccessState) {
                        email = state.email;
                        userName = state.userName;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            email,
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          bottom: PreferredSize(
              preferredSize: const Size(100, 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        context.read<TaskBloc>().add(TaskFetchTasksEvent());
                      },
                      child: const Text('Tasks')),
                  TextButton(
                      onPressed: () {
                        context
                            .read<TaskBloc>()
                            .add(TaskFetchComletedTasksEvent());
                      },
                      child: const Text('Comleted Task')),
                ],
              )),
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TaskLoadedSuccessState) {
              return ListView.builder(
                  itemCount: state.taskModel.length,
                  itemBuilder: (context, index) {
                    return CustomTaskWidget(
                      task: state.taskModel[index],
                    );
                  });
            } else if (state is TaskFailureSate) {
              return Center(
                child: Text(state.failureMessage),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Future<dynamic> customShowDialog(
      BuildContext context, bool isNew, String documentId) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titleTextStyle: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            backgroundColor: mainColor,
            title: Text(isNew ? 'Add New Task' : 'Edit Task'),
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
                    isNew
                        ? context.read<TaskBloc>().add(TaskAddNewTaskEvent(
                              title: txtTitle.text,
                              description: txtDescription.text,
                              dateTime: txtDateTime.text,
                              isCompleted: false,
                            ))
                        : {
                            context.read<TaskBloc>().add(TaskUpdatedTaskEvent(
                                  task: TaskModel(
                                    title: txtTitle.text,
                                    description: txtDescription.text,
                                    dateTime: txtDateTime.text,
                                    isCompleted: false,
                                  ),
                                  documentId: documentId,
                                )),
                            Navigator.pop(context),
                          };
                  },
                  child: Text(
                    isNew ? 'Add' : 'Edit',
                    style: const TextStyle(color: Colors.white),
                  )),
            ],
          );
        });
  }
}
