import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist_project/app/modules/home/home_controller.dart';
import 'package:todolist_project/app/modules/theme/app_theme.dart';

class AddNewAssignmentWidget extends StatefulWidget {
  final String? title;
  final String? description;
  final int? index;
  const AddNewAssignmentWidget({
    Key? key,
    this.title,
    this.description,
    this.index,
  }) : super(key: key);

  @override
  State<AddNewAssignmentWidget> createState() => _AddNewAssignmentWidgetState();
}

class _AddNewAssignmentWidgetState extends State<AddNewAssignmentWidget> {
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final size = MediaQuery.of(context).size;
    final HomeController _controller = Modular.get();

    return LayoutBuilder(builder: (BuildContext context, constraints) {
      return SafeArea(
        child: Container(
          height: (isKeyboard)
              ? constraints.maxHeight * .84
              : constraints.maxHeight * .5,
          width: constraints.maxWidth,
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
                SizedBox(height: 30),
                Container(
                  width: size.width * .85,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      _controller.todoModelClass.title = value;
                    },
                    controller: _controller.titleController,
                    readOnly: widget.title != null ? true : false,
                    cursorWidth: 1,
                    textAlign: TextAlign.center,
                    obscureText: false,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintMaxLines: 1,
                      enabledBorder: InputBorder.none,
                      hintText: 'Digite o titulo da tarefa',
                      hintStyle: AppTheme.textStyles.hint,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 100,
                  width: size.width * .85,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      _controller.todoModelClass.description = value;
                    },
                    controller: _controller.descriptionController,
                    cursorWidth: 1,
                    textAlign: TextAlign.center,
                    obscureText: false,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      focusedBorder: InputBorder.none,
                      hintMaxLines: 1,
                      enabledBorder: InputBorder.none,
                      hintText: 'Digite a descrição da tarefa',
                      hintStyle: AppTheme.textStyles.hint,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: constraints.maxWidth * .30,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF5CA6EA),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Cancelar ',
                            style: AppTheme.textStyles.inputWhite,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * .30,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF5CA6EA),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Adicionar',
                            style: AppTheme.textStyles.inputWhite,
                          ),
                        ),
                        onPressed: () async {
                          if (_controller.isUpdate) {
                            _controller.updateModelData(index: widget.index!);
                          } else {
                            _controller.saveDataModel(
                              context: context,
                            );
                          }
                          await Future.delayed(
                            const Duration(seconds: 3),
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
