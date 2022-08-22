import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:rush/constants/keysTask.dart';
import 'package:rush/dataTask/services/storage/services.dart';

import '../../models/task.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

//For reference u can dry run entire code in this
//this is how data ll be stored in our local storage

  // {
  // 'tasks' : [{
  // 'title': 'Work',
  // 'color': '0xdsadjas',
  // 'icon' : '0xe123'
  // }]
  // }

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  //convert out task object into json
  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
