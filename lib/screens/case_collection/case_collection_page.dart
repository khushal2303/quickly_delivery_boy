import 'package:flutter/material.dart';
import 'package:quickly_delivery/custom_widgets/top_bar.dart';
import 'package:quickly_delivery/screens/case_collection/case_collection_tile.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class CaseCollectionPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CaseCollectionPage());
  }

  const CaseCollectionPage({Key? key}) : super(key: key);

  @override
  _CaseCollectionPageState createState() => _CaseCollectionPageState();
}

class _CaseCollectionPageState extends State<CaseCollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const TopBar(
        title: "Case Collection",
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Stack(
      children: [
        getCaseCollectionTotal(),
        Align(
          alignment: Alignment.bottomCenter,
          child: getCaseCollectionList(),
        ),
      ],
    );
  }

  Widget getCaseCollectionTotal() {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      width: double.infinity,
      color: AppColors.caseCollectionColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "All Cash Collection",
            style: TextStyles.semiBold20(AppColors.whiteColor),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "₹140",
            style: TextStyles.semiBold25(AppColors.whiteColor),
          ),
          const SizedBox(
            width: 90,
            child: Divider(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget getCaseCollectionList() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 24, bottom: 16),
            child: Row(
              children: [
                Text(
                  "Today collection",
                  style: TextStyles.bold17(AppColors.blackColor),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: const [
                CaseCollectionTile(),
                CaseCollectionTile(),
                CaseCollectionTile(),
                CaseCollectionTile(),
                CaseCollectionTile(),
                CaseCollectionTile(),
                CaseCollectionTile(),
                CaseCollectionTile(),
                CaseCollectionTile(),
                CaseCollectionTile(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
