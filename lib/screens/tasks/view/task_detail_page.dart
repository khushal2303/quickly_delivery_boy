import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/custom_widgets/draggable_bottom_sheet.dart';
import 'package:quickly_delivery/screens/dashboard/top_bar_widget.dart';
import 'package:quickly_delivery/screens/tasks/view/accept_reject_order_widget.dart';
import 'package:quickly_delivery/screens/tasks/view/order_tracking_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class TaskDetailPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TaskDetailPage());
  }

  const TaskDetailPage({Key? key}) : super(key: key);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  bool isOnline = false;
  bool showPickOrder = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DraggableBottomSheet(
          blurBackground: false,
          backgroundWidget: Stack(
            children: [
              Column(
                children: [
                  const TopBarWidget(),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        if (showPickOrder) ...[
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Drop Zone : D2",
                                style: TextStyles.bold16(AppColors.lightColor),
                              ),
                            ],
                          ),
                        ],
                        getOrderDetail(),
                        const SizedBox(
                          height: 8,
                        ),
                        getBillDetail(),
                      ],
                    ),
                  ),
                ],
              ),
              if (showPickOrder == false)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: getAcceptRejectOrderView(),
                ),
            ],
          ),
          expandedChild:
              showPickOrder ? getOderDetailBottomSheetWidget() : Container(),
          bottomStickWidget: showPickOrder ? pickOrderButton() : Container(),
          minExtent: MediaQuery.of(context).size.height * 0.45,
          maxExtent: MediaQuery.of(context).size.height * 0.85,
        ),
      ),
    );
  }

  Widget pickOrderButton() {
    return Row(children: [
      Expanded(
        child: Container(
          color: AppColors.whiteColor,
          padding:
              const EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 12),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, OrderTRackingPage.route());
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              textStyle: TextStyles.medium17(AppColors.whiteColor),
            ),
            child: Text(
              'Pickup Order',
              style: TextStyles.medium17(AppColors.whiteColor),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget getOderDetailBottomSheetWidget() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: AppColors.primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 18),
            child: Text(
              "7 minutes left to deliver",
              style: TextStyles.medium15(AppColors.whiteColor),
            ),
          ),
          getCustomerMobileWidget(),
          const SizedBox(
            height: 12,
          ),
          Expanded(child: getItesListWidget()),
        ],
      ),
    );
  }

  Widget getCustomerMobileWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, top: 12),
      padding: const EdgeInsets.only(left: 5, right: 8, bottom: 6, top: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: AppColors.whiteColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.whiteColor,
                child: Icon(Icons.person),
              ),
              Text(
                "Aman dav",
                style: TextStyles.medium17(AppColors.blackColor),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(4)),
            child: const Icon(
              Icons.call,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget getItesListWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 14, bottom: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order details",
            style: TextStyles.semiBold17(AppColors.lightColor),
          ),
          Row(
            children: [
              Text(
                "Order id",
                style: TextStyles.semiBold12(AppColors.lightColor),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "#5554552",
                style: TextStyles.semiBold12(AppColors.lightColor),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                getOrderItem(ConstantImages.mangoIcon, "Mango"),
                const SizedBox(
                  height: 8,
                ),
                getOrderItem(ConstantImages.potatoIcon, "Potato"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getOrderItem(String icon, String name) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.whiteColor,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            height: 75,
            child: Image.asset(icon),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
              child: Column(
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyles.cardTitle(AppColors.blackColor),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1kg     x 1",
                    style: TextStyles.cardTitle(AppColors.lightColor),
                  ),
                  Row(
                    children: [
                      Text(
                        "₹149",
                        style: TextStyles.cardTitle(AppColors.blackColor),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        "₹149",
                        style: TextStyles.originalPrice(AppColors.lightColor),
                      )
                    ],
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget getAcceptRejectOrderView() {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12, left: 19),
            child: Text(
              "Customer interaction",
              style: TextStyles.semiBold17(AppColors.blackColor),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 36, bottom: 36),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppColors.whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AcceptRejectOrderWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "9 minutes left to deliver",
                    style: TextStyles.semiBold18(AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 36, right: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getRejectButton(),
                        getAcceptButton(),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget getAcceptButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          showPickOrder = true;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: AppColors.orderStstusColor,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        textStyle: TextStyles.medium17(AppColors.whiteColor),
      ),
      child: Text(
        'Accept',
        style: TextStyles.medium17(AppColors.whiteColor),
      ),
    );
  }

  Widget getRejectButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        primary: AppColors.dangerColor,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        textStyle: TextStyles.medium17(AppColors.whiteColor),
      ),
      child: Text(
        'Reject',
        style: TextStyles.medium17(AppColors.whiteColor),
      ),
    );
  }

  Widget getOrderDetail() {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order details",
            style: TextStyles.bold12(AppColors.lightColor),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Id",
                style: TextStyles.medium15(AppColors.lightColor),
              ),
              Text(
                "#5554552",
                style: TextStyles.medium15(AppColors.lightColor),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Name",
                style: TextStyles.medium15(AppColors.lightColor),
              ),
              Text(
                "Rohit",
                style: TextStyles.medium15(AppColors.lightColor),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total item",
                style: TextStyles.medium15(AppColors.lightColor),
              ),
              Text(
                "2",
                style: TextStyles.medium15(AppColors.lightColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getBillDetail() {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bill details",
            style: TextStyles.bold12(AppColors.lightColor),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Billing Amount",
                style: TextStyles.medium15(AppColors.lightColor),
              ),
              Text(
                "1500",
                style: TextStyles.medium15(AppColors.lightColor),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Collect Amount",
                style: TextStyles.medium15(AppColors.lightColor),
              ),
              Text(
                "290",
                style: TextStyles.medium15(AppColors.lightColor),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "COD",
                style: TextStyles.medium15(AppColors.lightColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
