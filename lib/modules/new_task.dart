import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Cubit/Cubit.dart';
import 'package:todo_app/Cubit/states.dart';
import 'package:todo_app/layout/home_page.dart';
import 'package:todo_app/reusable_widgets/reusable.dart';
import 'package:todo_app/reusable_widgets/constants.dart';

class NewTasksBody extends StatefulWidget {

  @override
  _NewTasksBodyState createState() => _NewTasksBodyState();
}

class _NewTasksBodyState extends State<NewTasksBody> {

  @override

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,states){},
      builder: (context,states){
        List<Map> tasks2= AppCubit.get(context).newTask;

        return TasksBuilder(tasks2: tasks2);
      },

    );

  }
}

/*
class LandPads extends StatefulWidget {
  const LandPads({Key key}) : super(key: key);

  @override
  _LandPadsState createState() => _LandPadsState();
}

class _LandPadsState extends State<LandPads> {
  Database database;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: FutureBuilder<List<Map>>(
          future: tasksDone(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              //Clean Code to Read Model
              List<Map> listModel = snapshot.data;
              print(listModel);
              return Container(
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Row(
                //       children: [
                //         Text("name:",style: TextStyle(fontSize: 16),),
                //         Text(  listModel[0].name ),
                //       ],
                //     ),
                //     Text(listModel[0].status),
                //     Text(listModel[0].type),
                //
                //   ],
                // ),
                child: ListView.builder(
                  itemCount:listModel.length ,
                  itemBuilder: (context, index) {
                    print(index);
                    return ListTile(
                      title: Text(listModel[index]['title']),
                      subtitle: Text(listModel[index]['date']),
                      leading: CircleAvatar(child: Text(listModel[index]['time'].substring(0,1)),backgroundColor:Colors.blue, ),

                    );
                  },),

              );
            } else {
              return Text("Try Again");
            }
          },
        ),
      ),
    );

  }
  Future <List<Map>> tasksDone()async{
    List<Map> finalTasks=await tasks;
    return finalTasks;

  }

}

 */
