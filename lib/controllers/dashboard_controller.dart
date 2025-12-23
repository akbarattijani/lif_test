import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lif_test/controllers/authentication_controller.dart';
import 'package:lif_test/data/models/data.dart';
import '../data/providers/database_helper.dart';

class DashboardController extends GetxController {
    var taskList = <Data>[].obs;
    var isLoading = true.obs;

    String get uid => Get.find<AuthController>().currentUserId;

    @override
    void onInit() {
        super.onInit();
        WidgetsBinding.instance.addPostFrameCallback((_) {
            fetchTasks();
        });
    }

    void fetchTasks() async {
        if (uid.isEmpty) return;
        isLoading.value = true;
        try {
            var tasks = await DatabaseHelper.instance.readAllTasks(uid);
            taskList.assignAll(tasks);
        } finally {
            isLoading.value = false;
        }
    }

    void addTask(String title, String desc) async {
        final task = Data(
            uid: uid,
            title: title,
            description: desc,
            isCompleted: false
        );
        await DatabaseHelper.instance.create(task);
        fetchTasks();
    }

    // Update Status (Checklist -> Completed)
    void toggleStatus(Data task) async {
        final newTask = task.copyWith(isCompleted: !task.isCompleted);
        await DatabaseHelper.instance.update(newTask);
        fetchTasks();
    }

    // Update Task
    void updateContent(Data task, String newTitle, String newDesc) async {
        final newTask = task.copyWith(
            title: newTitle,
            description: newDesc
        );
        await DatabaseHelper.instance.update(newTask);
        fetchTasks();
    }

    // Delete Task
    void deleteTask(int id) async {
        await DatabaseHelper.instance.delete(id);
        fetchTasks();
    }
}