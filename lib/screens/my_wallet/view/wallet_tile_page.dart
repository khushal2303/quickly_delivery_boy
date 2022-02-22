import 'package:flutter/material.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class WalletTitlePage extends StatelessWidget {
  const WalletTitlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12),
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.dividerColor, width: 1),
        ),
        color: AppColors.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: 26,
            child: Container(
              color: AppColors.primaryColor,
              width: 25,
              height: 25,
              child: Image.asset(
                ConstantImages.walletListIcon,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "#2152",
                        style: TextStyles.semiBold17(AppColors.blackColor),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 8, right: 8),
                        color: AppColors.orderStstusColor.withOpacity(0.2),
                        child: Text(
                          "+₹ 10.00",
                          style:
                              TextStyles.semiBold17(AppColors.orderStstusColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "15-10-2022",
                style: TextStyles.semiBold10(AppColors.lightColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
