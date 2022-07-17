import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/Provider/deletetask_provider.dart';
import 'package:rest_api/Utils/snack_message.dart';

import '../../Styles/colors.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';

class TaskDetailsPage extends StatefulWidget {
  final String? taskId;
  final String? title;
  const TaskDetailsPage({Key? key, required this.taskId, required this.title}) : super(key: key);

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _title = TextEditingController();
    @override
    void initState() {
      super.initState();

      setState(() {
        _title.text = widget.title!;
      });
    }

    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      _title.dispose();
    }


    return Scaffold(
      appBar: AppBar(title: const Text('Task Details'),
      actions: [
        Consumer<DeleteTaskProvider>(
        builder: (context,deleteTask,child) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
           if(deleteTask.response != ""){
             return showMessage(message: deleteTask.response,context: context);
           }
          });
          return IconButton(onPressed: deleteTask.status == true ? null :(){
            deleteTask.deleteTask(taskId: widget.taskId);
          },
              icon: Icon(Icons.delete,color: deleteTask.status == true ? grey:white,));
        }
      )],),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  customTextField(
                    title: 'Title',
                    controller: _title,
                    hint: 'What do you want to do?',
                  ),


                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
