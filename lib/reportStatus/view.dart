import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rush/constants/colors.dart';
import 'package:rush/constants/extensions.dart';
import 'package:rush/detail/widgets/controller.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var createdTasks = homeCtrl.getTotalTask();
          var completedTasks = homeCtrl.getTotalDoneTask();
          var liveTasks = createdTasks - completedTasks;
          var percent = (completedTasks / createdTasks * 100).toString();
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0.wp),
                child: Text(
                  "My Report",
                  style: GoogleFonts.lato(
                      fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: Text(DateFormat.yMMMMd().format(DateTime.now()),
                    style: GoogleFonts.poppins(
                        fontSize: 14.0.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 4.0.wp),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(Colors.green, liveTasks, "Live Tasks"),
                    _buildStatus(
                        Colors.purple[400]!, completedTasks, "Completed"),
                    _buildStatus(Colors.amber[700]!, createdTasks, "Created"),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0.wp,
              ),
              UnconstrainedBox(
                child: SizedBox(
                  width: 70.0.wp,
                  height: 70.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: createdTasks == 0 ? 1 : createdTasks,
                    currentStep: completedTasks,
                    stepSize: 20,
                    selectedColor: Green,
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    height: 150,
                    width: 150,
                    selectedStepSize: 22,
                    roundedCap: (_, __) => true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${createdTasks == 0 ? 0 : percent} %",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 14.0.sp),
                        ),
                        Text("Efficiency",
                            style: GoogleFonts.poppins(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey))
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Row _buildStatus(Color color, int number, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 0.5.wp,
              color: color,
            ),
          ),
        ),
        SizedBox(
          width: 3.0.wp,
        ),
        Column(
          children: [
            Text(
              "$number",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 16.0.sp),
            ),
            SizedBox(
              height: 2.0.wp,
            ),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 12.0.sp, color: Colors.grey),
            )
          ],
        ),
      ],
    );
  }
}
