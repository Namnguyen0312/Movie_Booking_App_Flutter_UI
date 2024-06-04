import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({
    super.key,
    required this.callBack,
  });

  final Function(String) callBack;

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpController = TextEditingController();

    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          6,
          (index) => SizedBox(
            height: 20,
            width: 20,
            child: TextFormField(
              controller: otpController,
              focusNode: index == 0 ? FocusNode() : null,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (index < 5) {
                    FocusScope.of(context).nextFocus();
                  } else {
                    callBack(otpController.text);
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
