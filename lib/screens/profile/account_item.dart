import 'package:flutter/material.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/screens/my_wallet/my_wallet_page.dart';

class AccountItem {
  final String label;
  final String iconPath;
  final Function(BuildContext context)? onTap;

  AccountItem(this.label, this.iconPath, this.onTap);
}
