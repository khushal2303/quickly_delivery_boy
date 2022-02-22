import 'package:flutter/material.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

Widget subTitle(String text, Function() onViewAll) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyles.title(AppColors.blackColor),
        ),
        InkWell(
          onTap: onViewAll,
          child: Row(
            children: [
              Text(
                "SEE ALL",
                style: TextStyles.semiBold12(AppColors.primaryColor),
              ),
              const SizedBox(
                width: 2,
              ),
              const CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                radius: 9,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 16,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
