import 'package:flutter/material.dart';
import 'package:quickly_delivery/custom_widgets/custom_text_field.dart';
import 'package:quickly_delivery/custom_widgets/top_bar.dart';
import 'package:quickly_delivery/screens/bank_account/update_bank_account_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';
import 'package:reactive_forms/reactive_forms.dart';

class BankAccountPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const BankAccountPage());
  }

  const BankAccountPage({Key? key}) : super(key: key);

  @override
  _BankAccountPageState createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
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
      backgroundColor: AppColors.whiteColor,
      appBar: const TopBar(
        title: "Bank Account",
      ),
      body: ListView(
        children: [
          getUpdateButton(),
          getBody(),
        ],
      ),
    );
  }

  Widget getUpdateButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 14, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, UpdateBankAccountPage.route());
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: const BorderSide(color: AppColors.primaryColor),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.primaryColor),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 24)),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyles.semiBold12(AppColors.whiteColor)),
            ),
            child: const Text('Update'),
          )
        ],
      ),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: ReactiveForm(
        formGroup: buildForm,
        child: Column(
          children: [
            sizeBox,
            CustomTextField<String>(
              titleText: "Account holder name",
              formControlName: 'account_holder_name',
              validationMessages: (control) => {
                ValidationMessage.required: "Please enter account number",
              },
              hint: "Enter account holder name",
              readOnly: true,
            ),
            sizeBox,
            CustomTextField<String>(
              titleText: "Account Number",
              formControlName: 'account_number',
              validationMessages: (control) => {
                ValidationMessage.required: "Please enter account number",
              },
              hint: "Enter account number",
              readOnly: true,
            ),
            sizeBox,
            CustomTextField<String>(
              titleText: "IFSC",
              formControlName: 'ifsc_code',
              validationMessages: (control) => {
                ValidationMessage.required: "Please enter ifsc code",
              },
              hint: "Enter ifsc code",
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
