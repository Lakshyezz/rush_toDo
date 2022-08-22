import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:rush/dataTask/services/storage/repository.dart';

import '../../models/task.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({
    required this.taskRepository,
  });

  //creating a list of <Task> type and using taskRepository reading them
  final formKey = GlobalKey<
      FormState>(); //key for controlling text in textForm Field for Tasks
  final tasks = <Task>[].obs; //observing list of TASKS
  final tabIndex = 0.obs;
  final chipIndex =
      0.obs; //to check the icon index in textFormField from icon List
  final deleting = false.obs;
  final editCtrl = TextEditingController(); //
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    //changes every time user do something or edit something as long as condition remains true
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  void onClose() {
    editCtrl.dispose();
    super.onClose();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo["done"];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    } else
      tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  bool addTodo(String title) {
    var todo = {"title": title, "done": false};
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    var doneTodo = {"title": title, "done": true};
    if (doneTodos
        .any((element) => mapEquals<String, dynamic>(doneTodo, element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([...doingTodos, ...doneTodos]);
    var newTask = task.value!.copyWith(toDos: newTodos);
    var oldIdx = tasks.indexOf(task.value);
    tasks[oldIdx] = newTask;
    tasks.refresh();
  }

  updateTask(Task task, String title) {
    var todos = task.toDos ?? [];
    if (containTodo(todos, title)) {
      return false;
    }
    var todo = {"title": title, "done": false};
    todos.add(todo);
    var newTask = task.copyWith(toDos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  void doneTodo(String title) {
    var doingTodo = {"title": title, "done": false};
    int index = doingTodos.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodo, element));
    doingTodos.removeAt(index);
    var doneTodo = {"title": title, "done": true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }

  bool containTodo(List todos, String title) {
    var doneTod = {};
    return todos.any((element) => element["title"] == title);
  }

  void deleteDoneTodo(dynamic doneTodo) {
    int index = doneTodos
        .indexWhere((element) => mapEquals<String, dynamic>(doneTodo, element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodosEmpty(Task task) {
    return task.toDos == null || task.toDos!.isEmpty;
  }

  int getDoneTodo(Task task) {
    var res = 0;
    for (int i = 0; i < task.toDos!.length; i++) {
      if (task.toDos![i]["done"] == true) {
        res += 1;
      }
    }
    return res;
  }

  int getTotalTask() {
    var res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].toDos != null) {
        res += tasks[i].toDos!.length;
      }
    }
    return res;
  }

  int getTotalDoneTask() {
    var res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].toDos != null) {
        for (int j = 0; j < tasks[i].toDos!.length; j++) {
          if (tasks[i].toDos![j]["done"] == true) {
            res += 1;
          }
        }
      }
    }
    return res;
  }
}
