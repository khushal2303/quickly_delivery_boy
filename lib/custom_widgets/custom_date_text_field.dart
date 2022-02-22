import 'package:flutter/material.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomDateField<T> extends StatelessWidget {
  final String? hint;
  final String formControlName;
  final TextInputType keyboardType;
  final String? errorText;
  final String? titleText;
  final Map<String, String> Function(FormControl<DateTime>)? validationMessages;
  final Function()? onEditingComplete;
  final bool readOnly;
  final Function()? onTap;
  const CustomDateField({
    Key? key,
    this.hint,
    required this.formControlName,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.titleText,
    this.validationMessages,
    this.onEditingComplete,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titleText != null) ...[
          Text(
            titleText ?? "",
            style: TextStyles.semiBold10(AppColors.lightColor),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
        ReactiveDateTimePicker(
          formControlName: formControlName,
          style: TextStyles.semiBold12(AppColors.blackColor),
          validationMessages: validationMessages,
          firstDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
          lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.dividerColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.dividerColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.dividerColor,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 10),
            hintText: hint,
            hintStyle: TextStyles.semiBold10(AppColors.lightColor),
            counterText: "",
          ),
        ),
      ],
    );
  }
}
