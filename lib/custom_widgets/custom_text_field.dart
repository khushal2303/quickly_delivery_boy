import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomTextField<T> extends StatelessWidget {
  final String? hint;
  final String formControlName;
  final TextInputType keyboardType;
  final String? errorText;
  final String? titleText;
  final Map<String, String> Function(FormControl<T>)? validationMessages;
  final Function()? onEditingComplete;
  final bool readOnly;
  final Function()? onTap;
  final int maxLength;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextField({
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
    this.maxLength = 50,
    this.inputFormatters,
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
        ReactiveTextField<T>(
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          maxLines: 1,
          readOnly: readOnly,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          formControlName: formControlName,
          validationMessages: validationMessages,
          keyboardType: keyboardType,
          style: TextStyles.semiBold12(AppColors.blackColor),
          cursorColor: Colors.black.withOpacity(0.5),
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
