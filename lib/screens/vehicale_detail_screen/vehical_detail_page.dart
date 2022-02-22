import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/constants/strings.dart';
import 'package:quickly_delivery/screens/vehicale_detail_screen/bloc/vehicale_bloc_bloc.dart';
import 'package:quickly_delivery/screens/vehicale_detail_screen/view/vehicale_document_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

enum VehcaleTypes { Bike, Cycle }

class VehicleDetailScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const VehicleDetailScreen());
  }

  const VehicleDetailScreen({Key? key}) : super(key: key);

  @override
  _VehicleDetailScreenState createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  VehcaleTypes vehcaleTypes = VehcaleTypes.Bike;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VehicaleBloc, VehicaleState>(
      listener: (context, state) {},
      child: BlocBuilder<VehicaleBloc, VehicaleState>(
        builder: (context, state) {
          return getBody(state);
        },
      ),
    );
  }

  Widget getBody(VehicaleState state) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.entert_vehicle_details,
                style: TextStyles.personalDetailText(AppColors.blackColor),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Vehicle Types",
                style: TextStyles.semiBold12(AppColors.lightColor),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      InkWell(
                        splashColor: AppColors.backgroundColor,
                        highlightColor: AppColors.backgroundColor,
                        onTap: () {
                          setState(() {
                            vehcaleTypes = VehcaleTypes.Bike;
                          });
                        },
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: const DecorationImage(
                              image: AssetImage(ConstantImages.bikeIcon),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: (vehcaleTypes == VehcaleTypes.Bike)
                                  ? AppColors.primaryColor
                                  : AppColors.lightColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Bike / Scooty",
                        style: TextStyles.semiBold10(AppColors.lightColor),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Column(
                    children: [
                      InkWell(
                        splashColor: AppColors.backgroundColor,
                        highlightColor: AppColors.backgroundColor,
                        onTap: () {
                          setState(() {
                            vehcaleTypes = VehcaleTypes.Cycle;
                          });
                        },
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: const DecorationImage(
                              image: AssetImage(ConstantImages.cycleIcon),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: (vehcaleTypes == VehcaleTypes.Cycle)
                                  ? AppColors.primaryColor
                                  : AppColors.lightColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Bicycle",
                        style: TextStyles.semiBold10(AppColors.lightColor),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              if (vehcaleTypes == VehcaleTypes.Bike) ...[
                Text(
                  "Vehicle Details",
                  style: TextStyles.semiBold12(AppColors.lightColor),
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
                      border:
                          Border.all(color: AppColors.lightColor, width: 0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Vehicle documents",
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
            ],
          ),
        ),
      ),
    );
  }

  Widget getSubmitButton(VehicaleState state) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        textStyle: TextStyles.medium17(AppColors.whiteColor),
      ),
      child: Text(
        'Submit',
        style: TextStyles.medium17(AppColors.whiteColor),
      ),
    );
  }
}
