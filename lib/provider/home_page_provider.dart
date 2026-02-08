import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_evntly/core/firebase_functions.dart';

import '../models/task_model.dart';

class HomePageProvider extends ChangeNotifier {
  StreamSubscription? _tasksSubscription;

  List<String> Categories = [
    "All",
    "sport",
    "book_club",
    "meeting",
    "exhibition",
    "birthday",
  ];
  List <TaskModel> tasks = [];


  int selectedCategoriesIndex = 0;

  changeCategories(int index) {
    selectedCategoriesIndex = index;
    getTasksStream();
    notifyListeners();
  }


  // getTasks()async {
  //   QuerySnapshot<TaskModel> data;
  //   if (selectedCategoriesIndex != 0) {
  //     data = await FireBaseFunctions.getTasks(
  //         category: Categories [selectedCategoriesIndex],
  //     );
  //   }else{
  //     data = await FireBaseFunctions.getTasks();
  //   }
  //
  //    tasks = data.docs.map((e) => e.data(),).toList();
  //     notifyListeners();
  //
  // }

  void getTasksStream() {
    _tasksSubscription?.cancel();

    _tasksSubscription = FireBaseFunctions.getTasksStream(
      category: selectedCategoriesIndex == 0
          ? null
          : Categories[selectedCategoriesIndex],
    ).listen((event) {
      tasks = event.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
  }

  Future<void> updateTask(TaskModel task) async {
    await FireBaseFunctions.updateTask(task);
    notifyListeners();
  }

  @override
  void dispose() {
    _tasksSubscription?.cancel();
    super.dispose();
  }
}



