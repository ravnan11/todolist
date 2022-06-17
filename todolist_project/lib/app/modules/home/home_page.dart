import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist_project/app/modules/home/widgets/add_new_assignment_widget.dart';
import 'package:todolist_project/app/modules/theme/app_theme.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// ignore: deprecated_member_use
class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void initState() {
    controller.getDataModel();
    controller.addListener(() {
      if (this.mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var appBar = AppBar(
      title: Text('Lista de Tarefas'),
    );

    var screenHeight = (size.height - appBar.preferredSize.height) -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Container(
          height: screenHeight,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          color: Color(0xFFF6F6F6),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Color(0xFFF6F6F6),
                  height: screenHeight,
                  child: ListView.builder(
                      itemCount: controller.listTodoModel.isNotEmpty
                          ? controller.listTodoModel.length
                          : 0,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onLongPress: () {
                            if (!controller.listTodoModel[index]['check']) {
                              controller.isUpdate = true;
                              controller.titleController.text =
                                  controller.listTodoModel[index]['title'];
                              controller.descriptionController.text = controller
                                  .listTodoModel[index]['description'];
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => AddNewAssignmentWidget(
                                  title: controller.listTodoModel[index]
                                      ['title'],
                                  description: controller.listTodoModel[index]
                                      ['description'],
                                  index: index,
                                ),
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    topRight: Radius.circular(32),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Card(
                            color: (!controller.listTodoModel[index]['check'])
                                ? Colors.white
                                : Colors.grey[300],
                            elevation: 1,
                            child: ListTile(
                              leading: IconButton(
                                onPressed: () {
                                  controller.removeAssignment(
                                      context: context, index: index);
                                },
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                              ),
                              title: Text(
                                controller.listTodoModel[index]['title'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: controller.listTodoModel[index]
                                          ['check']
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              subtitle: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      controller.listTodoModel[index]
                                          ['description'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black38,
                                        decoration: controller
                                                .listTodoModel[index]['check']
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Checkbox(
                                value: controller.listTodoModel[index]['check'],
                                onChanged: (value) {
                                  if (!controller.listTodoModel[index]
                                      ['check']) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                title: Center(
                                                  child: Text(
                                                    "Você deseja finalizar tarefa?",
                                                    style: TextStyle(
                                                        fontSize: 20.0),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: Text(
                                                      'Cancelar',
                                                      style: AppTheme.textStyles
                                                          .inputBlack,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text(
                                                      'Confirmar',
                                                      style: AppTheme.textStyles
                                                          .inputBlack,
                                                    ),
                                                    onPressed: () async {
                                                      controller
                                                          .changeCheckValue(
                                                              index: index);
                                                      await Future.delayed(
                                                        const Duration(
                                                            seconds: 1),
                                                        () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.isUpdate = false;
          showModalBottomSheet(
            context: context,
            builder: (context) => AddNewAssignmentWidget(),
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
