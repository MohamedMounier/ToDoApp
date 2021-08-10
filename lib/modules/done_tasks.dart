import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Cubit/Cubit.dart';
import 'package:todo_app/Cubit/states.dart';
import 'package:todo_app/reusable_widgets/reusable.dart';
class DoneTasksBody extends StatefulWidget {
  @override
  _DoneTasksBodyState createState() => _DoneTasksBodyState();
}

class _DoneTasksBodyState extends State<DoneTasksBody> {
  @override
  Widget build(BuildContext context) {
    return    BlocConsumer<AppCubit,AppStates>(
      listener: (context,states){},
      builder: (context,states){
        List<Map> tasks2= AppCubit.get(context).doneTasks2;

        return TasksBuilder(tasks2: tasks2);
      },

    );
  }
}
