import 'package:flutter/material.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool handleBack;
  final Function()? handleGoBack;
  const TopBar({
    Key? key,
    required this.title,
    this.showBack = true,
    this.handleBack = false,
    this.handleGoBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      backgroundColor: AppColors.backgroundColor,
      automaticallyImplyLeading: false,
      leading: (showBack)
          ? IconButton(
              onPressed: () {
                if (handleBack == true) {
                  handleGoBack!();
                } else {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primaryColor,
              ),
            )
          : null,
      title: Text(
        title,
        style: TextStyles.semiBold15(AppColors.blackColor),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
