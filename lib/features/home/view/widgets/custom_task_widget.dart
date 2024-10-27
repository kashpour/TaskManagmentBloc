import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/task_model.dart';

import '../../../../utils/constants/my_colors.dart';
import '../../bloc/task_bloc.dart';

class CustomTaskWidget extends StatelessWidget {
  const CustomTaskWidget({
    super.key,
    required this.task,
    required this.isTaskComplete,
  });
  final TaskModel task;
  final bool isTaskComplete;

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
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                task.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              Text(
                task.dateTime,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    context
                        .read<TaskBloc>()
                        .add(TaskCompletedButtonPressedEvent(task: task));
                  },
                  icon: Icon(
                    Icons.check_circle_rounded,
                    size: 38.0,
                    color: isTaskComplete ? Colors.green : Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(
                        TaskUpdateTaskButtonPressedEvent(
                            task: task, documentId: task.id));
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
