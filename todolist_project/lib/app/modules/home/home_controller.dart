import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:todolist_project/app/modules/cache/local_storage.dart';
import 'package:todolist_project/app/modules/modal/modals.dart';
import 'package:todolist_project/app/modules/models/todo_model.dart';

class HomeController extends ChangeNotifier {
  TodoModel todoModelClass = TodoModel();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isUpdate = false;
  LocalStorage localStorage;
  HomeController(this.localStorage);

  List<dynamic> listTodoModel = [];

  Future<void> saveDataModel({required BuildContext context}) async {
    try {
      print('VALOR DO MODEL ENVIADO');
      print(todoModelClass.title);
      print('valor da descrição');
      print(todoModelClass.description);

      if (todoModelClass.title != "" && todoModelClass.description != "") {
        listTodoModel.insert(0, todoModelClass.mapTodoModel(todoModelClass));
        await localStorage.setStorageList(
          'todoModel',
          listTodoModel,
        );
        notifyListeners();
        ShowModal.success(
            context: context, textMsg: 'Tarefa criada com sucesso!');

        cleaningModelData();
        await getDataModel();
        await Future.delayed(
          const Duration(seconds: 3),
          () {
            Navigator.pop(context);
          },
        );
      } else {
        ShowModal.error(
            context: context,
            textMsg: 'Preencha os campos para criar a tarefa');
      }
    } catch (e) {
      notifyListeners();
      ShowModal.error(context: context, textMsg: 'Falha ao criar tarefa!');
      await getDataModel();
      await Future.delayed(
        const Duration(seconds: 3),
        () {
          Navigator.pop(context);
        },
      );
      throw 'Falha ao gravar dados $e';
    }
  }

  getDataModel() async {
    dynamic data = await localStorage.getStorageList('todoModel');
    if (data.isNotEmpty) {
      listTodoModel = data;
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  Future<void> removeAssignment(
      {required BuildContext context, required int index}) async {
    try {
      listTodoModel.removeAt(index);

      listTodoModel = listTodoModel;

      await localStorage.setStorageList('todoModel', listTodoModel);
      cleaningModelData();
      notifyListeners();
      ShowModal.success(
          context: context, textMsg: 'Tarefa excluida com sucesso');
      await Future.delayed(
        const Duration(seconds: 3),
        () {
          Navigator.pop(context);
        },
      );
      await getDataModel();
    } catch (e) {
      notifyListeners();
      ShowModal.error(context: context, textMsg: 'Falha ao excluir tarefa');
      await getDataModel();
      await Future.delayed(
        const Duration(seconds: 3),
        () {
          Navigator.pop(context);
        },
      );
    }
  }

  updateModelData({required int index}) async {
    listTodoModel[index]['description'] = todoModelClass.description;
    await localStorage.setStorageList('todoModel', listTodoModel);
    notifyListeners();
  }

  changeCheckValue({required int index}) async {
    listTodoModel[index]['check'] = !listTodoModel[index]['check'];

    await localStorage.setStorageList('todoModel', listTodoModel);
    notifyListeners();
  }

  cleaningModelData() {
    todoModelClass = TodoModel();
    titleController.text = "";
    descriptionController.text = "";
    notifyListeners();
  }
}
