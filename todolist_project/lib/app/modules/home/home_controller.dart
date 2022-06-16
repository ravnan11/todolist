import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:todolist_project/app/modules/cache/local_storage.dart';
import 'package:todolist_project/app/modules/models/todo_model.dart';

class HomeController extends ChangeNotifier {
  TodoModel todoModelClass = TodoModel();

  LocalStorage localStorage;
  HomeController(this.localStorage);

  List<TodoModel> listTodoModel = [];

  List<Map<String, dynamic>> listJson = [];

  Future<void> saveDataModel(
      {required BuildContext context, required TodoModel todoModel}) async {
    print('Caiu aqui');
    try {
      print('Caiu aqui 2');
      print(todoModelClass.title);
      print('VALOR DA DESCRIÇÃO');
      print(todoModelClass.description);

      listJson.add(todoModelClass.mapTodoModel(todoModel));

      await localStorage.setStorageList(
        'todoModel',
        listJson,
      );

      print('Dados salvos com sucesso.');

      getDataModel();
    } catch (e) {
      throw 'Falha ao gravar dados $e';
    }
  }

  getDataModel() async {
    print('Caiu aqui no get');
    dynamic data = await localStorage.getStorageList('todoModel');
    print(data);
    print(data.runtimeType);
    print(data.length);
    if (data.isNotEmpty) {
      print('VALOR DO DATA');

      listTodoModel = [];

      for (var i = 0; i < data.length; i++) {
        listTodoModel.add(TodoModel.fromJson(data[i]));
        notifyListeners();
      }
      return;
    }
  }
}
