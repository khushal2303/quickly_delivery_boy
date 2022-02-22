import 'package:flutter/material.dart';
import 'package:quickly_delivery/screens/tasks/view/accept_order_timer.dart';
import 'package:quickly_delivery/screens/tasks/view/task_detail_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class TaskPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TaskPage());
  }

  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        getOrderTaskWidget(),
      ],
    );
  }

  Widget getOrderTaskWidget() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () {
          Navigator.push(context, TaskDetailPage.route());
        },
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Id",
                          style: TextStyles.medium19(AppColors.blackColor),
                        ),
                        Text(
                          "#5554552",
                          style: TextStyles.medium19(AppColors.blackColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "9:45 AM",
                      style: TextStyles.semiBold15(AppColors.lightColor),
                    )
                  ],
                ),
              ),
            ),
            const AcceptOrderTimer(),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
