import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rush/detail/detailTask/view.dart';
import 'package:rush/detail/widgets/add_dialog.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rush/constants/colors.dart';
import 'package:rush/constants/icons.dart';
import 'package:rush/detail/widgets/controller.dart';
import 'package:rush/models/task.dart';

import 'package:rush/constants/extensions.dart';

import '../../reportStatus/view.dart';

class HomePageTask extends GetView<HomeController> {
  final user = FirebaseAuth.instance.currentUser;
  HomePageTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 6.0.wp, vertical: 6.0.wp),
                    child: Text(
                      "My List",
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map((element) => LongPressDraggable(
                                data: element,
                                onDragStarted: () =>
                                    controller.changeDeleting(true),
                                onDraggableCanceled: (_, __) =>
                                    controller.changeDeleting(false),
                                onDragEnd: (_) =>
                                    controller.changeDeleting(false),
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: TaskCard(task: element),
                                ),
                                child: TaskCard(task: element)))
                            .toList(),
                        AddCard(),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black,
                  ),
                  // Text("Something"), //we gonna add $name in this for diff users
                ],
              ),
            ),
            ReportPage(),
          ],
        ),
      ),
      floatingActionButton: DragTarget(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
                backgroundColor:
                    controller.deleting.value ? Colors.red : Colors.amber[600],
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(() => AddDialog(), transition: Transition.downToUp);
                  } else {
                    EasyLoading.showInfo("Please create your task type");
                  }
                },
                child:
                    Icon(controller.deleting.value ? Icons.delete : Icons.add)),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess("Delete Success");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.amber[900],
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: const Icon(Icons.apps),
              ),

              BottomNavigationBarItem(
                label: "Report",
                icon: const Icon(Icons.data_usage),
              ),
              // BottomNavigationBarItem(
              //   label: "Meditate",
              //   icon: const Icon(Icons.air),
              // ),
              // BottomNavigationBarItem(
              // label: "Kal", icon: const Icon(Icons.data_usage))
            ],
          ),
        ),
      ),
    );
  }
}

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 24.0; // add .wp after 12.0
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0.wp),
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(4.0.wp),
        child: InkWell(
          onTap: () async {
            await Get.defaultDialog(
                titlePadding: EdgeInsets.symmetric(vertical: 10),
                title: "Task Type",
                content: Form(
                  key: homeCtrl.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: homeCtrl.editCtrl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Title",
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter your task title";
                            } else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Wrap(
                          spacing: 2.0.wp,
                          children: icons
                              .map(
                                (e) => Obx(() {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(
                                    backgroundColor: Colors.white,
                                    pressElevation: 0,
                                    selectedColor: Colors.amber[50],
                                    label: e,
                                    selected: homeCtrl.chipIndex.value == index,
                                    onSelected: (bool selected) {
                                      homeCtrl.chipIndex.value =
                                          selected ? index : 0;
                                    },
                                  );
                                }),
                              )
                              .toList(),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(150, 40),
                          ),
                          onPressed: () {
                            if (homeCtrl.formKey.currentState!.validate()) {
                              int icon = icons[homeCtrl.chipIndex.value]
                                  .icon!
                                  .codePoint;
                              String color = icons[homeCtrl.chipIndex.value]
                                  .color!
                                  .toHex();
                              var task = Task(
                                title: homeCtrl.editCtrl.text,
                                icon: icon,
                                color: color,
                                // id: '3',
                              );
                              Get.back();
                              homeCtrl.addTask(task)
                                  ? EasyLoading.showSuccess("Create success")
                                  : EasyLoading.showError("Duplicate Task");
                            }
                            ;
                          },
                          child: Text("Confirm",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ));
            homeCtrl.editCtrl.clear();
            homeCtrl.changeChipIndex(0);
          },
          child: DottedBorder(
            color: Colors.grey[400]!,
            dashPattern: [8, 4],
            child: Center(
              child: Icon(
                Icons.add,
                size: 35.0,
                color: Colors.grey,
              ),
            ),
          ),
        ), //add .wp after 3.0
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final squareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: () {
        homeCtrl.changeTask(task);
        homeCtrl.changeTodos(task.toDos ?? []);
        Get.to(() => DetailPage());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 7,
            offset: Offset(0, 7),
          ),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: homeCtrl.isTodosEmpty(task) ? 1 : task.toDos!.length,
              currentStep:
                  homeCtrl.isTodosEmpty(task) ? 0 : homeCtrl.getDoneTodo(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5), color]),
              unselectedGradientColor: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Colors.white, Colors.white],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(task.icon, fontFamily: "MaterialIcons"),
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text("${task.toDos?.length ?? 0} Task",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.grey))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
