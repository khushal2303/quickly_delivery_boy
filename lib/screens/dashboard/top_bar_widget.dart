import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class TopBarWidget extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TopBarWidget());
  }

  const TopBarWidget({Key? key}) : super(key: key);

  @override
  _TopBarWidgetState createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return getTopBar();
  }

  Widget getTopBar() {
    return Container(
      color: AppColors.whiteColor,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 150,
                    height: 35,
                    child: Image.asset(
                      ConstantImages.dashboardLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  FlutterSwitch(
                    width: 80.0,
                    height: 35.0,
                    toggleSize: 25.0,
                    value: isOnline,
                    borderRadius: 25.0,
                    padding: 0.5,
                    toggleColor: AppColors.primaryColor,
                    switchBorder: Border.all(
                      color: AppColors.primaryColor,
                      width: 6.0,
                    ),
                    toggleBorder: Border.all(
                      color: isOnline
                          ? AppColors.orderStstusColor
                          : AppColors.whiteColor,
                      width: 5.0,
                    ),
                    activeColor: AppColors.primaryColor,
                    inactiveColor: AppColors.primaryColor,
                    activeText: "Online",
                    activeTextColor: AppColors.whiteColor,
                    inactiveText: "Offline",
                    inactiveTextColor: AppColors.whiteColor,
                    valueFontSize: 10,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        isOnline = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            getBalanceButton(),
          ],
        ),
      ),
    );
  }

  Widget getBalanceButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(
            Icons.account_balance_wallet,
            color: AppColors.whiteColor,
            size: 18,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            "₹100",
            style: TextStyles.semiBold12(AppColors.whiteColor),
          )
        ],
      ),
    );
  }
}
