import 'package:flutter/material.dart';

import '../core/firebase_functions.dart';
import '../models/task_model.dart';

class FavouriteProvider extends ChangeNotifier{
  List<TaskModel> tasks=[];
  getTasks() {
    FireBaseFunctions.getFavouriteTasks().listen((event) {
      tasks=event.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
  }

  Future<void> updateTask(TaskModel task) async {
    await FireBaseFunctions.updateTask(task);
    notifyListeners();
  }
}