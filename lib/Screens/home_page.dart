

import 'package:flutter/material.dart';
import 'package:rest_api/Provider/database_provider.dart';
import 'package:rest_api/Screens/TaskPage/add_task.dart';

import '../Models/task_model.dart';
import '../Provider/getuser_provider.dart';
import '../Styles/colors.dart';
import '../Utils/routers.dart';
import '../Widgets/task_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
              //   DatabaseProvider().logOut(context);
              }),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<TaskModel>(
            future: GetTask().getTask(),
            builder: (context, snapshot) {
              print(snapshot);
              if (snapshot.hasError) {
                return const Center(child: Text('Error Occured'));
              } else if (snapshot.hasData) {
                if (snapshot.data!.tasks == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Todo List is empty',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            // PageNavigator(ctx: context)
                            //     .nextPage(page: const CreateTaskPage());
                          },
                          child: Text(
                            'Create a task',
                            style: TextStyle(fontSize: 18, color: grey),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView(
                    children:
                    List.generate(snapshot.data!.tasks!.length, (index) {
                      final data = snapshot.data!.tasks![index];
                      return TaskField(
                        initial: "${index + 1}",
                        title: data.title,
                        subtitle: data.startTime.toString(),
                        isCompleted: false,
                        taskId: data.id.toString(),
                      );
                    }),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          PageNavigator(ctx: context).nextPage(page: const AddToTask());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
