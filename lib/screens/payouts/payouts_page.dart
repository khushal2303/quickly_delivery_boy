import 'package:flutter/material.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/custom_widgets/top_bar.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class PayoutsPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PayoutsPage());
  }

  const PayoutsPage({Key? key}) : super(key: key);

  @override
  _PayoutsPageState createState() => _PayoutsPageState();
}

class _PayoutsPageState extends State<PayoutsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const TopBar(
        title: "Payouts",
      ),
      body: ListView(
        children: [
          getPayourList(),
          getPayourList(),
          getPayourList(),
          getPayourList(),
          getPayourList(),
          getPayourList(),
          getPayourList(),
          getPayourList(),
          getPayourList(),
          getPayourList(),
          getPayourList(),
        ],
      ),
    );
  }

  Widget getPayourList() {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.dividerColor, width: 1),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.whiteColor,
      ),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.iconBackColor,
            ),
            child: Image.asset(ConstantImages.payoutListIcon),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transfer to bank",
                  style: TextStyles.semiBold17(AppColors.blackColor),
                ),
                Text(
                  "15-10-2022",
                  style: TextStyles.semiBold10(AppColors.lightColor),
                )
              ],
            ),
          ),
          Text(
            "-₹ 70.00",
            style: TextStyles.semiBold17(AppColors.lightColor),
          ),
        ],
      ),
    );
  }
}
