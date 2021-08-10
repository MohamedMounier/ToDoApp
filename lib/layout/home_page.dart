import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Cubit/Cubit.dart';
import 'package:todo_app/modules/new_task.dart';
import 'package:todo_app/modules/done_tasks.dart';
import 'package:todo_app/modules/archived_tasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/reusable_widgets/reusable.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/reusable_widgets/constants.dart';
import 'package:todo_app/Cubit/Cubit.dart';
import 'package:todo_app/Cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class HomePage extends StatelessWidget {
/*
1-Create Database
2-Open Database
3-Create Table
4-Open table
 */
/*
  Database database;
  void CreateDatabase()async{
    database=await openDatabase(
      'todo.db',
      version: 1,
      onCreate:(database, version) {
        print('database is Created');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value) {
          print('Table is created');
        }).catchError((error){
          print('error while creating the table $error');
        });
      },
      onOpen: (database) {
        print('database is Opened');
        //   getFromDataBase(database);
        getFromTheDataBase(database).then((value){

          tasks2=value;
          print(tasks2);
          print(tasks2[1]);
          print(tasks2[1]["title"]);
        });
      }
      ,);
  }
  Future insertToDatabase({
    @required String titleDB,
    @required String timeDB,
    @required String dateDB,
  })async{
    await database.transaction((txn) {
      txn.rawInsert('INSERT INTO tasks(title, date, time, status) VALUES("$titleDB","$dateDB","$timeDB","new")').then((value) {
        print(('$value is inserted successfully'));
      }).catchError((error){
        print('error is ${error.toString()}');
      });
      return null;

    }
    );
  }


  void getFromDataBase(database)async{
    List<Map> tasks= await database.rawQuery('SELECT * FROM tasks');
    print(tasks);
  }

// second way which can enable putting then while calling the method
  Future<List<Map>> getFromTheDataBase(database)async{

    return await database.rawQuery('SELECT * FROM tasks');
  }
*/





  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey= GlobalKey<FormState>();
  var title= TextEditingController();
  var time= TextEditingController();
  var date=TextEditingController();
/*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CreateDatabase();
    getFromTheDataBase(database);
  }
  */
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context, ) => AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
          if(state is InsertDbState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {

          AppCubit cubit=AppCubit.get(context);
          return  Scaffold(
          key: scaffoldKey,

          floatingActionButton: FloatingActionButton(
          child: Icon(cubit.iconPlay),
          onPressed: (){
          if(cubit.isBottomSheetShown){
          if(formKey.currentState.validate()){
            cubit.insertToDatabase(titleDB: title.text, timeDB: time.text, dateDB: date.text);
            /*
          insertToDatabase(
          titleDB: title.text,
          timeDB: time.text,
          dateDB: date.text
          ).then((value) {
          Navigator.pop(context);
          isBottomSheetShown=false;
          /*
                    setState(() {
                      iconPlay=Icons.edit;
                    });
                    */
          });
          */
          }

          }else{
          scaffoldKey.currentState.showBottomSheet((context) => SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.grey[200],
          child: Form(
          key: formKey,
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          TextFormReusable(
          ctrl:title ,
          type: TextInputType.text,
          prefix: Icon(Icons.title),
          hint: 'Task Title',
          validate: (String value){
          if(value.isEmpty){
          return 'Title must not be empty';
          }else{
          return null;
          }
          },
          onTabbed: (){},
          ),
          SizedBox(height: 15,),
          TextFormReusable(
          ctrl:time ,
          //isClickable: false,
          //type: TextInputType.datetime,
          prefix: Icon(Icons.watch_later_outlined),
          hint: 'Task Time',
          validate: (String value){
          if(value.isEmpty){
          return 'Time must not be empty';
          }else{
          return null;
          }
          },
          onTabbed: ()
          {
          showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value)
          {
          time.text=value.format(context);
          });
          },
          ),
          SizedBox(height: 15,),
          TextFormReusable(
          ctrl:date ,
          // isClickable: false,
          type: TextInputType.datetime,
          prefix: Icon(Icons.calendar_today_outlined),
          hint: 'Task Date',
          validate: (String value){
          if(value.isEmpty){
          return 'Date must not be empty';
          }else{
          return null;
          }
          },
          onTabbed: (){
          showDatePicker(context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.parse('2022-07-05')).then((value) {
          //   print(value.toString());
          date.text=DateFormat.yMMMd().format(value);
          });
          },
          ),


          ],
          ),
          ),
          ),
          )).closed.then((value) {
            cubit.ChangeBottom( sheet: false,icon: Icons.edit);
          //isBottomSheetShown=false;
          /*
                  setState(() {
                    iconPlay=Icons.edit;
                  });
                  */
          });
          cubit.ChangeBottom(sheet:true, icon:Icons.add);

          //isBottomSheetShown=true;
          /*
               setState(() {
                 iconPlay=Icons.add;
               });
               */
          }
          },
          ),
          appBar: AppBar(title:Text(cubit.titles[cubit.index])),
          bottomNavigationBar:BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          currentIndex: AppCubit.get(context).index,
          onTap: (index2){
            AppCubit.get(context).ChangeIndex(index2);
          /*
                setState(() {
                  index=index2;
                });
                */
          },
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu),label:'New' ),
          BottomNavigationBarItem(icon: Icon(Icons.done),label: 'Done'),
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),label: 'Archived')
          ]) ,
          body: //cubit.screensT[cubit.index]

          ConditionalBuilder(
            condition:cubit.newTask!=null ,
            builder: (context)=>cubit.screensT[cubit.index],
            fallback: (context)=>Center(child: CircularProgressIndicator())

          ),


          );
        },

      ),
    );
  }

}



