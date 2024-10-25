import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managment_bloc/features/auth/view/login/login_view.dart';
import 'package:task_managment_bloc/features/home/bloc/task_bloc.dart';
import 'package:task_managment_bloc/utils/constants/my_colors.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final TextEditingController txtTitle = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDateTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is UserLogOutState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginView()));
        }
        if (state is TaskAddNewTaskDialogState) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  backgroundColor: mainColor,
                  title: const Text('Add New Task'),
                  content: SizedBox(
                    width: 150,
                    height: 190,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              hintText: 'Title'),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              hintText: 'Description'),
                        ),
                        TextField(
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
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
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
      },
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: mainColor,
              onPressed: () {
                context
                    .read<TaskBloc>()
                    .add(TaskAddNewTaskButtonPressedEvent());
              },
              child: const Icon(
                Icons.add,
                size: 28.0,
                color: Colors.white,
              ),
            ),
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      context
                          .read<TaskBloc>()
                          .add(TaskLogOutButtonPressedEvent());
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 32.0,
                      color: Colors.black,
                    ))
              ],
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  color: mainColor,
                ),
                child: const SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 10.0),
                      CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      SizedBox(width: 20.0),
                      Column(
                        children: [
                          Text(
                            'Ibrahim Kashbor',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'ibrahimkashbor@gmail.com',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Container());
      },
    );
  }
}
