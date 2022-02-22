import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickly_delivery/constants/strings.dart';
import 'package:quickly_delivery/custom_widgets/custom_text_field.dart';
import 'package:quickly_delivery/custom_widgets/top_bar.dart';
import 'package:quickly_delivery/screens/vehicale_detail_screen/bloc/vehicale_bloc_bloc.dart';
import 'package:quickly_delivery/screens/vehicale_detail_screen/view/driving_license_page.dart';
import 'package:quickly_delivery/screens/vehicale_detail_screen/view/vehicle_photo_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';
import 'package:quickly_delivery/utils/helpers.dart';
import 'package:reactive_forms/reactive_forms.dart';

class VehicleDocumentPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const VehicleDocumentPage());
  }

  const VehicleDocumentPage({Key? key}) : super(key: key);

  @override
  _VehicleDocumentPageState createState() => _VehicleDocumentPageState();
}

class _VehicleDocumentPageState extends State<VehicleDocumentPage> {
  FormGroup buildForm = fb.group(<String, Object>{
    'vehicale_number': FormControl<String>(
      validators: [Validators.required],
    ),
  });
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<VehicaleBloc, VehicaleState>(
        listener: (context, state) {
          if (state is VehicaleStateFailure) {
            Helpers.showSnackbar(context, state.error, true);
          }
        },
        child: BlocBuilder<VehicaleBloc, VehicaleState>(
          builder: (context, state) {
            return PageView(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                getBody(state),
                DrivingLicensePage(
                  onBack: () {
                    removeImage(true);
                    pageController.jumpToPage(0);
                  },
                  image: state.licenseImage,
                  onPickImage: () {
                    selectImage(true);
                  },
                  onRemoveImage: () {
                    removeImage(true);
                  },
                  onSubmit: () {
                    pageController.jumpToPage(0);
                  },
                ),
                VehiclePhotoPage(
                  onBack: () {
                    removeImage(false);
                    pageController.jumpToPage(0);
                  },
                  image: state.vehicaleImage,
                  onPickImage: () {
                    selectImage(false);
                  },
                  onRemoveImage: () {
                    removeImage(false);
                  },
                  onSubmit: () {
                    pageController.jumpToPage(0);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  removeImage(bool isLicense) {
    context.read<VehicaleBloc>().add(RemoveImage(isLicense));
  }

  selectImage(bool isLicense) {
    Helpers.showAlertDialog(
        context, Strings.pick_photo_title, Strings.camera, Strings.gallery, () {
      context
          .read<VehicaleBloc>()
          .add(PickImage(ImageSource.camera, isLicense));
    }, () {
      context
          .read<VehicaleBloc>()
          .add(PickImage(ImageSource.gallery, isLicense));
    });
  }

  Widget getBody(VehicaleState state) {
    return Scaffold(
      appBar: const TopBar(
        title: "Vehicle Documents",
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 24),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // Navigator.push(context, DrivingLicensePage.route());
                pageController.jumpToPage(1);
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
                        "Driving license",
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
              onTap: () {
                // Navigator.push(context, VehiclePhotoPage.route());
                pageController.jumpToPage(2);
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
                        "Vehicle photo",
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
            getVehcaleNumber(state),
          ],
        ),
      ),
    );
  }

  Widget getVehcaleNumber(VehicaleState state) {
    return ReactiveForm(
      formGroup: buildForm,
      child: Column(
        children: [
          CustomTextField<String>(
            formControlName: 'vehicale_number',
            titleText: "Vehicale Number",
            validationMessages: (control) => {
              ValidationMessage.required: "vehicale number can't be empty",
            },
          ),
          const SizedBox(
            height: 24,
          ),
          getSubmitButton(state),
        ],
      ),
    );
  }

  Widget getSubmitButton(VehicaleState state) {
    return ReactiveFormConsumer(
      builder: (formContext, form, child) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: (form.invalid ||
                        (state.licenseImage == null ||
                            state.licenseImage?.isEmpty == true) ||
                        (state.vehicaleImage == null ||
                            state.vehicaleImage?.isEmpty == true))
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: TextStyles.medium17(AppColors.whiteColor),
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        );
      },
    );
  }
}
