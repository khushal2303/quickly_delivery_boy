import 'package:flutter/material.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

class CaseCollectionTile extends StatelessWidget {
  const CaseCollectionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 0),
      child: Card(
        elevation: 0.0,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 18, bottom: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.whiteColor,
            border: Border.all(
              color: AppColors.dividerColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.primaryColor.withOpacity(0.5),
                ),
                child: Image.asset(ConstantImages.caseCollectionIcon),
              ),
              const SizedBox(
                width: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#525245",
                        style: TextStyles.semiBold17(AppColors.blackColor),
                      ),
                      Text(
                        "15-10-2022",
                        style: TextStyles.semiBold10(AppColors.lightColor),
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 8, right: 8),
                    color: AppColors.orderStstusColor.withOpacity(0.2),
                    child: Text(
                      "+₹ 10.00",
                      style: TextStyles.semiBold17(AppColors.orderStstusColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
