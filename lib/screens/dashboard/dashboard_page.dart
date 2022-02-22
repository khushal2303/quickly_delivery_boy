import 'package:flutter/material.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/screens/dashboard/top_bar_widget.dart';
import 'package:quickly_delivery/screens/feed/feed_page.dart';
import 'package:quickly_delivery/screens/profile/profile_page.dart';
import 'package:quickly_delivery/screens/tasks/task_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const DashboardPage());
  }

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isOnline = false;
  num currentIndex = 1;

  Widget getScreens() {
    if (currentIndex == 1) {
      return const TaskPage();
    } else if (currentIndex == 2) {
      return const FeedPage();
    } else if (currentIndex == 3) {
      return const ProfilePage();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TopBarWidget(),
            Expanded(
              child: getScreens(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.only(left: 12, right: 12),
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getBottomWidget(
              1,
              "Task",
              ConstantImages.lightTaskIcon,
              ConstantImages.darkTaskIcon,
            ),
            getBottomWidget(
              2,
              "Feed",
              ConstantImages.lightFeedIcon,
              ConstantImages.darkFeedIcon,
            ),
            getBottomWidget(
              3,
              "Profile",
              ConstantImages.lightProfileIcon,
              ConstantImages.darkProfileIcon,
            ),
          ],
        ),
      ),
    );
  }

  Widget getBottomWidget(
      num index, String title, String unselectedIcon, String selectedIcon) {
    return InkWell(
      highlightColor: AppColors.whiteColor,
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 18,
            width: 18,
            child: Image.asset(
              currentIndex == index ? selectedIcon : unselectedIcon,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: TextStyles.semiBold17((currentIndex == index)
                ? AppColors.primaryColor
                : AppColors.lightColor),
          ),
        ],
      ),
    );
  }
}
