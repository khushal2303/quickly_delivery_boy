import 'package:flutter/material.dart';
import 'package:quickly_delivery/custom_widgets/top_bar.dart';
import 'package:quickly_delivery/screens/my_wallet/view/wallet_tile_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class WalletSummaryPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const WalletSummaryPage());
  }

  const WalletSummaryPage({Key? key}) : super(key: key);

  @override
  _WalletSummaryPageState createState() => _WalletSummaryPageState();
}

class _WalletSummaryPageState extends State<WalletSummaryPage> {
  List<String> dropDownVals = ['Today', 'Yesterday', 'This month', 'All'];
  String selectedVal = "Today";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const TopBar(
        title: "Wallet Summary",
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getMonthSelection(),
            const SizedBox(
              width: 32,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 26, right: 26, top: 12, bottom: 12),
              color: AppColors.whiteColor,
              child: Text(
                "All",
                style: TextStyles.semiBold10(AppColors.blackColor),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: const [
              WalletTitlePage(),
              WalletTitlePage(),
              WalletTitlePage(),
              WalletTitlePage(),
              WalletTitlePage(),
              WalletTitlePage(),
              WalletTitlePage(),
              WalletTitlePage(),
              WalletTitlePage(),
              WalletTitlePage(),
            ],
          ),
        ),
      ],
    );
  }

  Widget getMonthSelection() {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.only(left: 12, right: 12),
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        color: AppColors.whiteColor,
      ),
      child: DropdownButton(
        isExpanded: false,
        underline: Container(),
        value: selectedVal,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: dropDownVals.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              style: TextStyles.semiBold12(AppColors.blackColor),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedVal = newValue!;
          });
        },
      ),
    );
  }
}
