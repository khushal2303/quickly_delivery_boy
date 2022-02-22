import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/constants/strings.dart';
import 'package:quickly_delivery/custom_widgets/custom_date_text_field.dart';
import 'package:quickly_delivery/custom_widgets/custom_text_field.dart';
import 'package:quickly_delivery/data/authenticate/models/photos_response.dart';
import 'package:quickly_delivery/data/profile/models/personal_detail_request.dart';
import 'package:quickly_delivery/screens/personal_detail/bloc/profile_bloc.dart';
import 'package:quickly_delivery/screens/personal_detail/views/search_city_page.dart';
import 'package:quickly_delivery/screens/vehicale_detail_screen/vehical_detail_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';
import 'package:quickly_delivery/utils/helpers.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonalDetailPage extends StatefulWidget {
  const PersonalDetailPage({Key? key}) : super(key: key);

  static const routeName = "/personal_detail";

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PersonalDetailPage());
  }

  @override
  _PersonalDetailPageState createState() => _PersonalDetailPageState();
}

class _PersonalDetailPageState extends State<PersonalDetailPage> {
  ProgressDialog? progressDialog;
  FormGroup buildForm = fb.group(<String, Object>{
    'first_name': FormControl<String>(
      validators: [Validators.required],
    ),
    'last_name': FormControl<String>(
      value: "",
    ),
    'date_of_birth': FormControl<DateTime>(
      validators: [Validators.required],
    ),
    'secondary_phone_number': FormControl<String>(
      validators: [Validators.maxLength(10)],
    ),
    'father_name': FormControl<String>(
      validators: [Validators.required],
    ),
    'city': FormControl<String>(
      validators: [Validators.required],
    ),
  });

  final Widget sizeBox = const SizedBox(
    height: 16,
  );

  String? profileImage;
  UserAddress? userAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileStateFailure) {
              Helpers.showSnackbar(context, state.error, true);
              progressDialog?.dismiss();
            }

            if (state is ProfileDetailUpdateSuccess) {
              // Helpers.showSnackbar(context, state.message, false);
              Navigator.pushAndRemoveUntil(
                  context, VehicleDetailScreen.route(), (route) => false);
            }

            if (state is PeronalDetailUpdateBusy) {
              // if (state.isBusy == true) {
              //   progressDialog =
              //       Helpers.progressDialog(context, "Updating Detail");
              //   progressDialog?.show();
              // } else {
              //   progressDialog?.dismiss();
              // }
            }

            if (state is PickProfileImageSuccess) {
              setState(() {
                profileImage = state.imagePath;
              });
            }

            if (state is AddAddressSuccess) {
              setState(() {
                userAddress = state.userAddress;
                buildForm
                    .control("city")
                    .reset(value: state.userAddress.city ?? "");
              });
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 14),
                child: getBody(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    return ReactiveForm(
        formGroup: buildForm,
        child: Column(
          children: [
            Text(
              Strings.entert_personal_details,
              style: TextStyles.personalDetailText(AppColors.blackColor),
            ),
            sizeBox,
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextField<String>(
                          formControlName: 'first_name',
                          titleText: "First Name",
                          validationMessages: (control) => {
                            ValidationMessage.required:
                                "First name can't be empty",
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CustomTextField<String>(
                          titleText: "Last Name",
                          formControlName: 'last_name',
                          validationMessages: (control) => {},
                        ),
                      ),
                    ],
                  ),
                  sizeBox,
                  CustomDateField<DateTime>(
                    titleText: "Date Of Birth",
                    formControlName: 'date_of_birth',
                    validationMessages: (control) => {
                      ValidationMessage.required: "Please select date of birth",
                    },
                    hint: "YYYY-MM-DD",
                  ),
                  sizeBox,
                  CustomTextField<String>(
                    maxLength: 10,
                    titleText: "Secondary Phone Number(Optional)",
                    keyboardType: TextInputType.number,
                    formControlName: 'secondary_phone_number',
                    validationMessages: (control) => {
                      ValidationMessage.maxLength: "Invalid mobile number",
                      if ((control.value?.length ?? 0) > 0)
                        ValidationMessage.minLength:
                            "Please enter valid number",
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  sizeBox,
                  CustomTextField<String>(
                    titleText: "Father Name",
                    formControlName: 'father_name',
                    validationMessages: (control) => {
                      ValidationMessage.required: "Father name can't be empty",
                    },
                  ),
                  sizeBox,
                  CustomTextField<String>(
                    readOnly: true,
                    titleText: "City",
                    formControlName: 'city',
                    validationMessages: (control) => {
                      ValidationMessage.required: "City can't be empty",
                    },
                    onTap: () async {
                      final sessionToken = const Uuid().v4();
                      final resultData = await Navigator.pushNamed(
                          context, CitySearchPage.routeName,
                          arguments: sessionToken);
                      log(resultData.toString());
                    },
                  ),
                  sizeBox,
                  Text(
                    "Your Profile Photo",
                    style: TextStyles.semiBold10(AppColors.lightColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  getProfilePhoto(),
                ],
              ),
            ),
            getNextButton(),
            sizeBox,
          ],
        ));
  }

  Widget getNextButton() {
    return ReactiveFormConsumer(
      builder: (formContext, form, child) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: (form.valid == true && profileImage != null)
                    ? () {
                        log(DateFormat("YYYY-MM-dd")
                            .format(buildForm.control("date_of_birth").value)
                            .toString());
                        PersonalDetailRequest personalDetailRequest =
                            PersonalDetailRequest(
                          dateOfBirth: DateFormat("yyyy-MM-dd")
                              .format(buildForm.control("date_of_birth").value),
                          fatherName: buildForm.control("father_name").value,
                          firstName: buildForm.control("first_name").value,
                          lastName: buildForm.control("last_name").value,
                          isProfileCompletelyFilled: true,
                        );
                        context.read<ProfileBloc>().add(
                              UpdateUserPersonalDetailEvent(
                                personalDetailRequest,
                                Photos(
                                  createdAt: DateTime.now().toString(),
                                  updatedAt: DateTime.now().toString(),
                                  photo: Helpers.base64ImageConvert(
                                      File(profileImage!)),
                                  primary: true,
                                  user: Constants.userId,
                                  userId: Constants.userId,
                                  isDeleted: false,
                                ),
                                userAddress,
                              ),
                            );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: TextStyles.medium17(AppColors.whiteColor),
                ),
                child: const Text('Next'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getProfilePhoto() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.dividerColor, width: 0.5)),
          child: (profileImage == null)
              ? Image.asset(ConstantImages.emptyProfileIcon)
              : Image.file(File(profileImage!)),
        ),
        const SizedBox(
          width: 24,
        ),
        ElevatedButton(
          onPressed: () {
            Helpers.showAlertDialog(context, Strings.pick_photo_title,
                Strings.camera, Strings.gallery, () {
              context
                  .read<ProfileBloc>()
                  .add(const PickImage(ImageSource.camera));
            }, () {
              context
                  .read<ProfileBloc>()
                  .add(const PickImage(ImageSource.gallery));
            });
          },
          style: ElevatedButton.styleFrom(
            primary: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            textStyle: TextStyles.medium10(AppColors.whiteColor),
          ),
          child: const Text('Upload Photo'),
        )
      ],
    );
  }
}
