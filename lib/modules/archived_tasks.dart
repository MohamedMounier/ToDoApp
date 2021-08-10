import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Cubit/Cubit.dart';
import 'package:todo_app/Cubit/states.dart';
import 'package:todo_app/layout/home_page.dart';
import 'package:todo_app/reusable_widgets/reusable.dart';
class ArchivedTasksBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,states){},
      builder: (context,states){
        List<Map> tasks2= AppCubit.get(context).archivedTasks2;

        return TasksBuilder(tasks2: tasks2);
      },

    );
  }
}
