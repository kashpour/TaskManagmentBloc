import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managment_bloc/features/home/models/task_model.dart';

import '../../../../utils/constants/my_colors.dart';
import '../../bloc/task_bloc.dart';

class CustomTaskWidget extends StatelessWidget {
  const CustomTaskWidget({
    super.key, required this.task,
   
  });
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(left: 16.0),
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                task.description,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                task.dateTime,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: IconButton(
                      onPressed: () {
                        context
                            .read<TaskBloc>()
                            .add(TaskCompletedButtonPressedEvent());
                      },
                      icon: const Icon(
                        Icons.done,
                      ))),
              IconButton(
                  onPressed: () {
                    context
                        .read<TaskBloc>()
                        .add(TaskUpdateTaskButtonPressedEvent(task: task, documentId: task.id));
                  },
                  icon: Icon(
                    Icons.edit_document,
                    size: 32.0,
                    color: Colors.blue.shade300,
                  )),
              IconButton(
                  onPressed: () {
                    context
                        .read<TaskBloc>()
                        .add(TaskDeleteTaskButtonPressedEvent(taskID: task.id));
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 32.0,
                    color: Colors.red.shade400,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
