import 'package:flutter/material.dart';
import 'package:quickly_delivery/custom_widgets/custom_text_field.dart';
import 'package:quickly_delivery/custom_widgets/top_bar.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';
import 'package:reactive_forms/reactive_forms.dart';

class BankDetailsPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const BankDetailsPage());
  }

  const BankDetailsPage({Key? key}) : super(key: key);
  @override
  _BankDetailsPageState createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  FormGroup buildForm = fb.group(<String, Object>{
    'account_holder_name': FormControl<String>(
      validators: [Validators.required],
    ),
    'account_number': FormControl<String>(
      validators: [Validators.required],
    ),
    'ifsc_code': FormControl<String>(
      validators: [Validators.required],
    ),
  });

  final Widget sizeBox = const SizedBox(
    height: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(
        title: "Bank Details",
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 14),
        child: getBody(),
      ),
    );
  }

  Widget getBody() {
    return ReactiveForm(
      formGroup: buildForm,
      child: Column(
        children: [
          sizeBox,
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                CustomTextField<String>(
                  titleText: "Account holder name",
                  formControlName: 'account_holder_name',
                  validationMessages: (control) => {
                    ValidationMessage.required: "Please enter account number",
                  },
                  hint: "Enter account holder name",
                ),
                sizeBox,
                CustomTextField<String>(
                  titleText: "Account Number",
                  formControlName: 'account_number',
                  validationMessages: (control) => {
                    ValidationMessage.required: "Please enter account number",
                  },
                  hint: "Enter account number",
                ),
                sizeBox,
                CustomTextField<String>(
                  titleText: "IFSC",
                  formControlName: 'ifsc_code',
                  validationMessages: (control) => {
                    ValidationMessage.required: "Please enter ifsc code",
                  },
                  hint: "Enter ifsc code",
                ),
                sizeBox,
                getNextButton(),
                sizeBox,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getNextButton() {
    return ReactiveFormConsumer(
      builder: (formContext, form, child) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: (form.valid == true) ? () {} : null,
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
