import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist_project/app/modules/home/home_controller.dart';

class AddNewAssignmentWidget extends StatefulWidget {
  const AddNewAssignmentWidget({Key? key}) : super(key: key);

  @override
  State<AddNewAssignmentWidget> createState() => _AddNewAssignmentWidgetState();
}

class _AddNewAssignmentWidgetState extends State<AddNewAssignmentWidget> {
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final HomeController _controller = Modular.get();

    return LayoutBuilder(builder: (BuildContext context, constraints) {
      return SafeArea(
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    _controller.todoModelClass.title = value;
                  },
                  cursorWidth: 1,
                  textAlign: TextAlign.center,
                  obscureText: false,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintMaxLines: 1,
                    enabledBorder: InputBorder.none,
                    hintText: 'Digite o titulo da tarefa',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    _controller.todoModelClass.description = value;
                  },
                  cursorWidth: 1,
                  textAlign: TextAlign.center,
                  obscureText: false,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintMaxLines: 1,
                    enabledBorder: InputBorder.none,
                    hintText: 'Digite a descrição da tarefa',
                  ),
                ),
                Container(
                    color: Colors.blue,
                    child: IconButton(
                        onPressed: () {
                          _controller.saveDataModel(
                              context: context,
                              todoModel: _controller.todoModelClass);
                        },
                        icon: Icon(Icons.check)))
              ],
            ),
          ),
        ),
      );
    });
  }
}
