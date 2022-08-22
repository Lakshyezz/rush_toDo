import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rush/constants/extensions.dart';
import 'package:rush/detail/widgets/controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doneTodos.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 5.0.wp),
                child: Text(
                  "Completed(${homeCtrl.doneTodos.length})",
                  style: GoogleFonts.poppins(
                      fontSize: 14.0.sp, color: Colors.grey),
                ),
              ),
              ...homeCtrl.doneTodos
                  .map(
                    (element) => Dismissible(
                      key: ObjectKey(element),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => homeCtrl.deleteDoneTodo(element),
                      background: Container(
                        color: Colors.red.withOpacity(0.8),
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.0.wp),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.0.wp, horizontal: 9.0.wp),
                        child: Row(
                          children: [
                            // const SizedBox(
                            //     // height: 20,
                            //     ),
                            Icon(
                              Icons.done,
                              size: 18,
                              color: Colors.amber[900],
                            ),
                            SizedBox(
                              width: 6,
                              height: 30,
                            ),
                            Text(element["title"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey[600],
                                    fontSize: 16))
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()
            ],
          )
        : Container());
  }
}
