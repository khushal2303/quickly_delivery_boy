import 'package:flutter/material.dart';
import 'package:quickly_delivery/custom_widgets/top_bar.dart';
import 'package:quickly_delivery/screens/upload_documents/upload_document_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';
import 'package:dotted_border/dotted_border.dart';

class AadharCardPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const AadharCardPage());
  }

  const AadharCardPage({Key? key}) : super(key: key);
  @override
  _AadharCardPageState createState() => _AadharCardPageState();
}

class _AadharCardPageState extends State<AadharCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(
        title: "Aadhar card",
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 24),
        child: Column(
          children: [
            getFrontPhotoView(),
            const SizedBox(
              height: 24,
            ),
            getBackPhotoView(),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, UploadDocumentPgae.route());
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

  Widget getFrontPhotoView() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(2),
      padding: const EdgeInsets.all(6),
      color: AppColors.lightColor,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 38,
                ),
                Text(
                  "Upload a clear image",
                  style: TextStyles.semiBold14(AppColors.lightColor),
                ),
                Text(
                  "(Fron Side)",
                  style: TextStyles.semiBold14(AppColors.lightColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                    textStyle: TextStyles.medium17(AppColors.whiteColor),
                  ),
                  child: Text(
                    'Upload Photo',
                    style: TextStyles.medium7(AppColors.whiteColor),
                  ),
                ),
                const SizedBox(
                  height: 38,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBackPhotoView() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(2),
      padding: const EdgeInsets.all(6),
      color: AppColors.lightColor,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 38,
                ),
                Text(
                  "Upload a clear image",
                  style: TextStyles.semiBold14(AppColors.lightColor),
                ),
                Text(
                  "(Back Side)",
                  style: TextStyles.semiBold14(AppColors.lightColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                    textStyle: TextStyles.medium17(AppColors.whiteColor),
                  ),
                  child: Text(
                    'Upload Photo',
                    style: TextStyles.medium7(AppColors.whiteColor),
                  ),
                ),
                const SizedBox(
                  height: 38,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
