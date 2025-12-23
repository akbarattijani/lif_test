import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lif_test/controllers/dashboard_controller.dart';
import 'package:lif_test/data/models/data.dart';
import '../const/app_colors.dart';
import '../controllers/authentication_controller.dart';

class DashboardActivity extends StatelessWidget {
    final AuthController authController = Get.find<AuthController>();
    final DashboardController dashboardController = Get.put(DashboardController());

    DashboardActivity({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            body: Column(
                children: [
                    Container(
                        padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
                        decoration: const BoxDecoration(
                            color: kPrimaryYellow,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                            ),
                        ),
                        child: Column(
                            children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        const Text(
                                            "My Tasks",
                                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                        IconButton(
                                            onPressed: () => authController.logout(),
                                            icon: const Icon(Icons.logout, color: Colors.white),
                                        )
                                    ],
                                ),
                                const SizedBox(height: 20),
                                // Stats
                                Container(
                                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Obx(() {
                                        int total = dashboardController.taskList.length;
                                        int done = dashboardController.taskList.where((e) => e.isCompleted).length;
                                        return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                                _buildStatItem(Icons.list_alt, "$total Tasks", Colors.orange),
                                                Container(width: 1, height: 20, color: Colors.grey[300]),
                                                _buildStatItem(Icons.check_circle, "$done Completed", Colors.green),
                                            ],
                                        );
                                    }),
                                )
                            ],
                        ),
                    ),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    const SizedBox(height: 10),
                                    const Text("Task List", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 10),
                                    Expanded(
                                        child: Obx(() {
                                            if (dashboardController.isLoading.value) {
                                                return const Center(child: CircularProgressIndicator());
                                            }
                                            if (dashboardController.taskList.isEmpty) {
                                                return Center(child: Text("No tasks yet", style: TextStyle(color: Colors.grey[400])));
                                            }
                                            return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                itemCount: dashboardController.taskList.length,
                                                itemBuilder: (context, index) {
                                                    final task = dashboardController.taskList[index];
                                                    return _buildTaskCard(context, task);
                                                },
                                            );
                                        }),
                                    ),
                                ],
                            ),
                        ),
                    ),
                ],
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: const Color(0xFFFFC107),
                onPressed: () => _showTaskDialog(context, null),
                child: const Icon(Icons.add, color: Colors.white),
            ),
        );
    }

    Widget _buildStatItem(IconData icon, String text, Color color) {
        return Row(
            children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
        );
    }

    Widget _buildTaskCard(BuildContext context, Data task) {
        return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                ],
            ),
            child: Row(
                children: [
                    Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                            activeColor: kPrimaryYellow,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            value: task.isCompleted,
                            onChanged: (val) => dashboardController.toggleStatus(task),
                        ),
                    ),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    task.title,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                        color: task.isCompleted ? Colors.grey : Colors.black87,
                                    ),
                                ),
                                if (task.description.isNotEmpty)
                                    Text(
                                        task.description,
                                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                    ),
                            ],
                        ),
                    ),
                    Row(
                        children: [
                            IconButton(
                                icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey, size: 20),
                                onPressed: () => _showTaskDialog(context, task),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                onPressed: () => _confirmDelete(context, task.id!),
                            ),
                        ],
                    )
                ],
            ),
        );
    }

    void _showTaskDialog(BuildContext context, Data? task) {
        final isEdit = task != null;
        final titleCtrl = TextEditingController(text: isEdit ? task.title : '');
        final descCtrl = TextEditingController(text: isEdit ? task.description : '');

        Get.defaultDialog(
            title: isEdit ? "Edit Task" : "New Task",
            titleStyle: const TextStyle(fontWeight: FontWeight.bold),
            content: Column(
                children: [
                    TextField(
                        controller: titleCtrl,
                        decoration: InputDecoration(
                            labelText: "Title",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                        controller: descCtrl,
                        decoration: InputDecoration(
                            labelText: "Description",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                    ),
                ],
            ),
            textConfirm: isEdit ? "Save Changes" : "Add Task",
            textCancel: "Cancel",
            confirmTextColor: Colors.white,
            buttonColor: kPrimaryYellow,
            onConfirm: () {
                if (titleCtrl.text.isNotEmpty) {
                    if (isEdit) {
                        dashboardController.updateContent(task, titleCtrl.text, descCtrl.text);
                    } else {
                        dashboardController.addTask(titleCtrl.text, descCtrl.text);
                    }
                    Get.back();
                }
            },
        );
    }

    void _confirmDelete(BuildContext context, int id) {
        Get.defaultDialog(
            title: "Delete Task",
            middleText: "Are you sure?",
            textConfirm: "Yes",
            textCancel: "No",
            confirmTextColor: Colors.white,
            buttonColor: Colors.red,
            onConfirm: () {
                dashboardController.deleteTask(id);
                Get.back();
            },
        );
    }
}