import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickly_delivery/custom_widgets/draggable_bottom_sheet.dart';
import 'package:quickly_delivery/screens/login/styles/login_styles.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';
import 'package:sms_autofill/sms_autofill.dart';

enum AmountMode { Online, COD }

class OrderTRackingPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const OrderTRackingPage());
  }

  const OrderTRackingPage({Key? key}) : super(key: key);

  @override
  _OrderTRackingPageState createState() => _OrderTRackingPageState();
}

class _OrderTRackingPageState extends State<OrderTRackingPage> {
  GoogleMapController? _controller;
  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(23.05122945, 72.51197561059564),
    zoom: 14.4746,
  );

  String currentCode = "";
  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  AmountMode amountMode = AmountMode.COD;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DraggableBottomSheet(
          blurBackground: false,
          backgroundWidget: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                initialCameraPosition: _kGooglePlex,
                compassEnabled: false,
                zoomControlsEnabled: false,
                onCameraMove: (position) {},
              ),
            ],
          ),
          expandedChild: getOderDetailBottomSheetWidget(),
          bottomStickWidget: Container(),
          minExtent: MediaQuery.of(context).size.height * 0.45,
          maxExtent: MediaQuery.of(context).size.height * 0.85,
        ),
      ),
    );
  }

  Widget getDetailView() {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 14, bottom: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: AppColors.backgroundColor,
      ),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Verification code",
                style: TextStyles.semiBold17(AppColors.blackColor),
              ),
            ],
          ),
          getOtpFields(),
          getSubmitButton(),
          getAmountCollecatWidget(),
          getCancelButton(),
          getOrderDetail(),
        ],
      ),
    );
  }

  Widget getAmountCollecatWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: const Text('COD'),
              leading: Radio(
                value: AmountMode.COD,
                groupValue: amountMode,
                activeColor: AppColors.primaryColor,
                onChanged: (AmountMode? value) {
                  if (value != null) {
                    setState(() {
                      amountMode = value;
                    });
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Text('Online'),
              leading: Radio(
                value: AmountMode.Online,
                activeColor: AppColors.primaryColor,
                groupValue: amountMode,
                onChanged: (AmountMode? value) {
                  if (value != null) {
                    setState(() {
                      amountMode = value;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSubmitButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, top: 12),
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
          'Submit',
          style: TextStyles.medium17(AppColors.whiteColor),
        ),
      ),
    );
  }

  Widget getCancelButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 75, right: 75, top: 12),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, OrderTRackingPage.route());
        },
        style: ElevatedButton.styleFrom(
          primary: AppColors.dangerColor,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          textStyle: TextStyles.medium17(AppColors.whiteColor),
        ),
        child: Text(
          'Cancel Order',
          style: TextStyles.medium17(AppColors.whiteColor),
        ),
      ),
    );
  }

  Widget getOrderDetail() {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 75),
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

  Widget getOtpFields() {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, top: 12),
      child: PinFieldAutoFill(
        textInputAction: TextInputAction.done,
        enableInteractiveSelection: true,
        decoration: BoxLooseDecoration(
          hintTextStyle:
              LoginTextStyles.otpText(AppColors.termColor.withOpacity(0.5)),
          strokeColorBuilder:
              const FixedColorBuilder(AppColors.mobileTextField),
          bgColorBuilder:
              FixedColorBuilder(AppColors.darkGrey.withOpacity(0.5)),
          textStyle: LoginTextStyles.otpText(AppColors.termColor),
          hintText: "----",
        ),
        onCodeSubmitted: (code) {},
        currentCode: currentCode,
        codeLength: 4,
        onCodeChanged: (String? code) {
          if (code != null) {
            setState(() {
              currentCode = code;
            });
          }
          if (code!.length == 4) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
        keyboardType: TextInputType.number,
        cursor: Cursor(
          width: 2,
          color: AppColors.termColor,
          radius: const Radius.circular(1),
          enabled: true,
        ),
      ),
    );
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
          Expanded(
            child: getDetailView(),
          ),
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
}
