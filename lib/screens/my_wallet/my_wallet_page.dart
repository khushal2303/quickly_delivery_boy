import 'package:flutter/material.dart';
import 'package:quickly_delivery/custom_widgets/padded.dart';
import 'package:quickly_delivery/custom_widgets/top_bar.dart';
import 'package:quickly_delivery/screens/my_wallet/view/wallet_summary_page.dart';
import 'package:quickly_delivery/screens/my_wallet/view/wallet_tile_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class MyWalletPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MyWalletPage());
  }

  const MyWalletPage({Key? key}) : super(key: key);

  @override
  _MyWalletPageState createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const TopBar(
        title: "My Wallet",
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Stack(
      children: [
        getWalleBalance(),
        Align(
          alignment: Alignment.bottomCenter,
          child: getWalletList(),
        ),
      ],
    );
  }

  Widget getWalleBalance() {
    return Container(
      width: double.infinity,
      color: AppColors.profileBackColor,
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(
            "Your balance",
            style: TextStyles.semiBold20(AppColors.whiteColor),
          ),
          Text(
            "250",
            style: TextStyles.semiBold20(AppColors.whiteColor),
          )
        ],
      ),
    );
  }

  Widget getWalletList() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: double.infinity,
      color: AppColors.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 24,
          ),
          subTitle("This Week", () {
            Navigator.push(context, WalletSummaryPage.route());
          }),
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
      ),
    );
  }
}
