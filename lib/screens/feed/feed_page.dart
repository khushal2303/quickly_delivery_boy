import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:quickly_delivery/screens/dashboard/top_bar_widget.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class FeedPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const FeedPage());
  }

  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Map<String, dynamic>> cardItems = [
    {"title": "Total Order", "color": 0xff6877FF, "total": "25"},
    {"title": "Total Deliverd", "color": 0xffFF6868, "total": "15"},
    {"title": "Reject Order", "color": 0xffFF9F68, "total": "20"},
  ];

  List<String> dropDownVals = ['Today', 'Yesterday', 'This month', 'All'];
  String selectedVal = "Today";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 16,
            ),
            getMonthSelection(),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: cardItems
                    .map(
                      (e) => getDetail(
                        e["title"],
                        e['total'],
                        Color(e['color']),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            getAllCollectionWidget(),
          ],
        ),
      ),
    );
  }

  Widget getDetail(String title, String total, Color color) {
    return Card(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyles.semiBold12(AppColors.whiteColor),
          ),
          Text(
            total,
            style: TextStyles.bold25(AppColors.whiteColor),
          )
        ],
      ),
    );
  }

  Widget getAllCollectionWidget() {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Card(
        color: AppColors.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "All Cash Collection",
              style: TextStyles.semiBold15(AppColors.whiteColor),
            ),
            Text(
              "450",
              style: TextStyles.bold25(AppColors.whiteColor),
            )
          ],
        ),
      ),
    );
  }

  Widget getMonthSelection() {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.only(left: 12, right: 12),
      height: 40,
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.primaryColor)),
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
