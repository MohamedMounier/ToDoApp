import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Cubit/Cubit.dart';


class TextFormReusable extends StatelessWidget {
   TextFormReusable({
    @required this.ctrl,
    this.onTabbed,
    this.validate,
    this.hint,
    this.icon,
    this.prefix,
    this.type,
    this.isClickable,
    Key key,
  }) : super(key: key);

final TextEditingController ctrl;
final Function onTabbed;
final Function validate;
final String hint;
final Icon icon;
final Icon prefix;
final TextInputType type;
 bool isClickable;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:ctrl ,
      onTap:onTabbed ,
      validator: validate,
      keyboardType: type,
      enabled:isClickable ,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hint,
        icon: icon,
        prefixIcon: prefix,
      ),
    );
  }
}

class ListTileInfo extends StatelessWidget {
  const ListTileInfo({
  @required  this.model,
    Key key,
  }) : super(key: key);
  final Map model;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red,child: Icon(Icons.delete,color: Colors.white,),),
      key: Key('${model['id']}'),
      onDismissed: (direction){

        AppCubit.get(context).DeleteFromDataBase(model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Expanded(
              flex: 3,
              child: Row(

                children: [
                  CircleAvatar(child:Text(model['time'],style: TextStyle(fontSize: 13),),radius: 40,),
                  SizedBox(width: 20,),
                  Column(
                    children: [
                      Text(model['title'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(model['date']),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.check_box),color: Colors.green,
                      onPressed: (){
                        AppCubit.get(context).UpdateDataBase('done', model['id']);
                      }),
                  IconButton(
                      icon: Icon(Icons.archive),color: Colors.black45,
                      onPressed: (){
                        AppCubit.get(context).UpdateDataBase('archived', model['id']);
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
    /*
        ListTile(
          title: Text(model['title']),
          subtitle: Text(model['date']),
          leading: CircleAvatar(child:Text(model['time'],style: TextStyle(fontSize: 13),),
            radius: 40,
          ),
          trailing: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.check_box),
                  onPressed: (){}),
              IconButton(
                  icon: Icon(Icons.archive),
                  onPressed: (){})
            ],
          ),
        );
*/


  }
}
Widget TasksBuilder({List<Map> tasks2})=>ConditionalBuilder(
  condition: tasks2.length>0,
  builder: (context)=>ListView.separated(
      itemBuilder: (context,index)=>ListTileInfo(model: tasks2[index],),
      separatorBuilder: (context,index)=>Padding(
        padding: const EdgeInsetsDirectional.only(
            start: 20.0
        ),
        child: Container(
          width: double.infinity,
          color: Colors.grey[300],
          height: 1.0,
        ),
      ),
      itemCount: tasks2.length
    //tasks2.length
  ),
  fallback:(context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.menu,size: 100,color: Colors.grey,),
        Text('No Tasks Yet,Start Putting Your Tasks',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            )),
      ],
    ),
  ) ,

);