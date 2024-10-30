import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task_model.dart';
import 'widgets/custom_task_widget.dart';

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
    final TaskBloc taskBloc = context.read<TaskBloc>();
    context
        .read<TaskBloc>()
        .add(TaskFetchTasksEvent(isTaskCompleteEvent: false));

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
          context
              .read<TaskBloc>()
              .add(TaskFetchTasksEvent(isTaskCompleteEvent: false));
          customShowDialog(context, true, '', taskBloc);
        } else if (state is TaskUpdateTaskDialogState) {
          context
              .read<TaskBloc>()
              .add(TaskFetchTasksEvent(isTaskCompleteEvent: false));
          txtTitle.text = state.task.title;
          txtDescription.text = state.task.description;
          txtDateTime.text = state.task.dateTime;
          customShowDialog(context, false, state.task.id, taskBloc);
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () {
            txtTitle.text = '';
            txtDescription.text = '';
            txtDateTime.text = '';
            taskBloc.add(TaskAddNewTaskButtonPressedEvent());
          },
          child: const Icon(Icons.add, size: 28.0, color: Colors.white),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: mainColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 20),
                    const CircleAvatar(child: Icon(Icons.person)),
                    const SizedBox(width: 10),
                    BlocBuilder<TaskBloc, TaskState>(
                      builder: (context, state) {
                        String email = '';
                        String userName = '';
                        if (state is TaskLoadedSuccessState) {
                          email = state.email;
                          userName = state.userName;
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                IconButton(
                  onPressed: () => context
                      .read<TaskBloc>()
                      .add(TaskLogOutButtonPressedEvent()),
                  icon:
                      const Icon(Icons.logout, size: 32.0, color: Colors.black),
                )
              ],
            ),
          ),
          bottom: PreferredSize(
              preferredSize: const Size(60, 60),
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  bool isTaskComplete = false;
                  if (state is TaskLoadedSuccessState) {
                    isTaskComplete = state.isTaskComplete;
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  isTaskComplete ? mainColor : whiteColor,
                              fixedSize: const Size(200, 20)),
                          onPressed: () {
                            taskBloc.add(TaskFetchTasksEvent(
                                isTaskCompleteEvent: false));
                          },
                          child: const Text(
                            'Tasks',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          )),
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  !isTaskComplete ? mainColor : whiteColor,
                              fixedSize: const Size(200, 20)),
                          onPressed: () {
                            taskBloc.add(
                                TaskFetchTasksEvent(isTaskCompleteEvent: true));
                          },
                          child: const Text('Comleted Task',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0))),
                    ],
                  );
                },
              )),
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadedSuccessState) {
              return ListView.builder(
                  itemCount: state.taskModel.length,
                  itemBuilder: (context, index) {
                    return CustomTaskWidget(
                      taskBloc: taskBloc,
                      task: state.taskModel[index],
                      isTaskComplete: state.isTaskComplete,
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
      BuildContext context, bool isNew, String documentId, TaskBloc taskBloc) {
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
                        ? taskBloc.add(TaskAddNewTaskEvent(
                            title: txtTitle.text,
                            description: txtDescription.text,
                            dateTime: txtDateTime.text,
                            isCompleted: false,
                          ))
                        : {
                            taskBloc.add(TaskUpdatedTaskEvent(
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
