import 'package:flutter/material.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/screens/bank_account/bank_account_page.dart';
import 'package:quickly_delivery/screens/case_collection/case_collection_page.dart';
import 'package:quickly_delivery/screens/my_wallet/my_wallet_page.dart';
import 'package:quickly_delivery/screens/payouts/payouts_page.dart';
import 'package:quickly_delivery/screens/profile/account_item.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class ProfilePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<AccountItem> accountItems = [
    AccountItem("Collection", ConstantImages.collectionIcon,
        (BuildContext context) {
      Navigator.push(context, CaseCollectionPage.route());
    }),
    AccountItem("Wallet", ConstantImages.walletIcon, (BuildContext context) {
      Navigator.push(context, MyWalletPage.route());
    }),
    AccountItem("Bank Account", ConstantImages.bankAccountIcon,
        (BuildContext context) {
      Navigator.push(context, BankAccountPage.route());
    }),
    AccountItem("Payouts", ConstantImages.payoutsIcon, (BuildContext context) {
      Navigator.push(context, PayoutsPage.route());
    }),
    AccountItem(
        "Support", ConstantImages.payoutsIcon, (BuildContext context) {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getPrifilePickWidget(),
        Align(
          alignment: Alignment.bottomCenter,
          child: getProfileItems(),
        ),
      ],
    );
  }

  Widget getPrifilePickWidget() {
    return Container(
      color: AppColors.profileBackColor,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteColor,
                border: Border.all(color: AppColors.primaryColor, width: 1)),
            child: Icon(Icons.person),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Ankit Mishra",
            style: TextStyles.semiBold12(AppColors.whiteColor),
          ),
        ],
      ),
    );
  }

  Widget getProfileItems() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: AppColors.backgroundColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 14, bottom: 16),
            child: Row(
              children: [
                Text(
                  "My Account",
                  style: TextStyles.semiBold15(AppColors.blackColor),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: accountItems.map((e) => getItemTile(e)).toList(),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 18,
                width: 18,
                child: Image.asset(ConstantImages.logoutIcon),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Log Out",
                style: TextStyles.medium19(AppColors.primaryColor),
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

  Widget getItemTile(AccountItem accountItem) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
      child: InkWell(
        onTap: () {
          if (accountItem.onTap != null) {
            accountItem.onTap!(context);
          }
        },
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.accountIconColor,
              ),
              child: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(accountItem.iconPath),
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            Text(
              accountItem.label,
              style: TextStyles.medium13(AppColors.blackColor),
            ),
          ],
        ),
      ),
    );
  }
}
