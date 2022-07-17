import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/Provider/addtask_provider.dart';

import '../../Utils/snack_message.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';

class AddToTask extends StatefulWidget {
  const AddToTask({Key? key}) : super(key: key);

  @override
  State<AddToTask> createState() => _AddToTaskState();
}

class _AddToTaskState extends State<AddToTask> {
  final TextEditingController _title = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _title.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Task')),
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
                  Consumer<AddTasKProvider>(
                    builder: (context,addTask,child) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                      if(addTask.getResponse != ''){
                        showMessage(
                          message: addTask.getResponse, context: context
                        );
                        addTask.clear();
                      }
                      });
                      return customButton(
                        status: addTask.getStatus,
                        tap: (){
                          if(_title.text.isEmpty){
                            showMessage(message:  "Fill in title", context: context);
                          }else{
                            addTask.addTask(title:_title.text.trim());

                          }
                      },
                        context: context,
                      );
                    }
                  )


                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
