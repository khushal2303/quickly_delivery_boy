import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quickly_delivery/custom_widgets/top_bar.dart';
import 'package:quickly_delivery/screens/upload_documents/upload_document_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';
import 'package:dotted_border/dotted_border.dart';

class VehiclePhotoPage extends StatefulWidget {
  final Function()? onBack;
  final String? image;
  final Function()? onPickImage;
  final Function()? onRemoveImage;
  final Function()? onSubmit;

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const VehiclePhotoPage());
  }

  const VehiclePhotoPage({
    Key? key,
    this.onBack,
    this.image,
    this.onPickImage,
    this.onRemoveImage,
    this.onSubmit,
  }) : super(key: key);
  @override
  _VehiclePhotoPageState createState() => _VehiclePhotoPageState();
}

class _VehiclePhotoPageState extends State<VehiclePhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: "Vehicle Photo",
        handleBack: true,
        handleGoBack: widget.onBack,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 24),
        child: Column(
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(2),
              padding: const EdgeInsets.all(6),
              color: AppColors.lightColor,
              child: Row(
                children: [
                  Expanded(
                    child: (widget.image == null ||
                            widget.image?.isEmpty == true)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 38,
                              ),
                              Text(
                                "Upload a clear image",
                                style:
                                    TextStyles.semiBold14(AppColors.lightColor),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  widget.onPickImage!();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 14),
                                  textStyle:
                                      TextStyles.medium17(AppColors.whiteColor),
                                ),
                                child: Text(
                                  'Upload Photo',
                                  style:
                                      TextStyles.medium7(AppColors.whiteColor),
                                ),
                              ),
                              const SizedBox(
                                height: 38,
                              ),
                            ],
                          )
                        : getImageWidget(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        (widget.image == null || widget.image?.isEmpty == true)
                            ? null
                            : () {
                                widget.onSubmit!();
                              },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 14),
                      textStyle: TextStyles.medium17(AppColors.whiteColor),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyles.medium17(AppColors.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getImageWidget() {
    return Stack(
      children: [
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2),
            child: Image.file(
              File(widget.image!),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: CircleAvatar(
            backgroundColor: AppColors.lightColor.withOpacity(0.5),
            child: IconButton(
              color: AppColors.whiteColor,
              onPressed: () {
                widget.onRemoveImage!();
              },
              icon: const Icon(
                Icons.close,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
