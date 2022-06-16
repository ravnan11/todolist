import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist_project/app/modules/home/widgets/add_new_assignment_widget.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 32.0,
          ),
          color: Color(0xFFF6F6F6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 500,
                child: ListView.builder(
                    itemCount: controller.listTodoModel.isNotEmpty
                        ? controller.listTodoModel.length
                        : 0,
                    itemBuilder: (_, index) {
                      return Card(
                        elevation: 1,
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                          title: Text(controller.listTodoModel[index].title),
                          subtitle: Container(
                            child: Column(
                              children: [
                                Text(
                                  controller.listTodoModel[index].description,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          trailing: Checkbox(
                            value: controller.listTodoModel[index].check,
                            onChanged: (value) {
                              controller.listTodoModel[index].check = value!;
                            },
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
