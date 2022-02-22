import 'package:flutter/material.dart';
import 'package:quickly_delivery/constants/strings.dart';
import 'package:quickly_delivery/screens/upload_documents/view/aadhar_card_page.dart';
import 'package:quickly_delivery/screens/upload_documents/view/bank_details_page.dart';
import 'package:quickly_delivery/screens/vehicale_detail_screen/view/vehicale_document_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

enum VehcaleTypes { Bike, Cycle }

class UploadDocumentPgae extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UploadDocumentPgae());
  }

  const UploadDocumentPgae({Key? key}) : super(key: key);

  @override
  _UploadDocumentPgaeState createState() => _UploadDocumentPgaeState();
}

class _UploadDocumentPgaeState extends State<UploadDocumentPgae> {
  VehcaleTypes vehcaleTypes = VehcaleTypes.Bike;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.upload_your_document,
                style: TextStyles.personalDetailText(AppColors.blackColor),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                highlightColor: AppColors.whiteColor,
                onTap: () {
                  Navigator.push(context, AadharCardPage.route());
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      bottom: 14, top: 14, left: 12, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightColor, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Aadhar card",
                          style: TextStyles.semiBold12(AppColors.blackColor),
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.primaryColor,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                highlightColor: AppColors.whiteColor,
                onTap: () {
                  Navigator.push(context, VehicleDocumentPage.route());
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      bottom: 14, top: 14, left: 12, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightColor, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Pan card",
                          style: TextStyles.semiBold12(AppColors.blackColor),
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.primaryColor,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                highlightColor: AppColors.whiteColor,
                onTap: () {
                  Navigator.push(context, BankDetailsPage.route());
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      bottom: 14, top: 14, left: 12, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightColor, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Bank details",
                          style: TextStyles.semiBold12(AppColors.blackColor),
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.primaryColor,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
