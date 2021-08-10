import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/archived_tasks.dart';
import 'package:todo_app/modules/done_tasks.dart';
import 'package:todo_app/modules/new_task.dart';
class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  Database database;
  // error reciever is null bec the  List<Map> tasks2; without initializing it by putting =[]
  List<Map> newTask=[];
  List<Map> doneTasks2=[];
  List<Map> archivedTasks2=[];


  bool isBottomSheetShown=false;
  IconData iconPlay=Icons.edit;
  static AppCubit get(context)=>BlocProvider.of(context);
  List<Widget> screensT=[NewTasksBody(),DoneTasksBody(),ArchivedTasksBody()];
  List<String> titles=['New Tasks','Done Tasks','Archived Tasks'];
  int index=0;

  void ChangeIndex(index7){
    index=index7;
    emit(AppChangeNavBarState());
  }
  void ChangeBottom({bool sheet,IconData icon}){
    isBottomSheetShown=sheet;
    iconPlay=icon;
    emit(AppChangeBottomSheetState());
  }
  void CreateDatabase(){
    openDatabase(
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
        getFromTheDataBase(database);
      }
      ,).then((value)  {
        database=value;
        print('the database after opening it$database');
        emit(CreateDbState());
    });
  }
   insertToDatabase({
    @required String titleDB,
    @required String timeDB,
    @required String dateDB,
  })async{
    await database.transaction((txn) {
      txn.rawInsert('INSERT INTO tasks(title, date, time, status) VALUES("$titleDB","$dateDB","$timeDB","new")').then((value) {
        print(('$value is inserted successfully'));
        emit(InsertDbState());

        getFromTheDataBase(database);
      }).catchError((error){
        print('error is ${error.toString()}');
      });
      return null;

    }
    );
  }
  void UpdateDataBase(
      @required String status,
      @required int id,
      )async{
    await database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
          print('updated value is $value');
          getFromTheDataBase(database);
      emit(UpdateDBState());

    });
  }
  void DeleteFromDataBase(
      @required int id,
      )async{
    await database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      print('Deleted value is $value');
      getFromTheDataBase(database);
      emit(DeleteDbState());

    });
  }

  void getFromTheDataBase(database){
     newTask=[];
    doneTasks2=[];
    archivedTasks2=[];
  //  emit(GetDbLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value){
      print('value in getfromDatabase is $value');
     // tasks2=value;
      value.forEach((element){
        print('element is $element');
        print('the status value is ${element['status']}');
        if(element['status']=='new'){
          newTask.add(element);
          print('value in adding in tasks2 the new tasks screen $newTask');
        }else if(element['status']=='done'){
          doneTasks2.add(element);
          print('value in adding in doneTasks2 the done tasks screen $doneTasks2');

        }else{
          archivedTasks2.add(element);
          print('value in adding in archivedTasks2 the archived tasks screen $archivedTasks2');
        }
      });

/*
      tasks2=value;
      print(tasks2);
      print(value);
      print(value[1]);
      print(value[1]["title"]);
      */
      emit(GetDbState());
    });
  }

}