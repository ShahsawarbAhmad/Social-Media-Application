import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator onValidator;

  final TextInputType keyboardType;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;

  const InputTextField({
    super.key,
    required this.myController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.onValidator,
    required this.keyboardType,
    required this.hint,
    required this.obscureText,
    this.enable = true,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmittedValue,
        obscureText: obscureText,
        validator: onValidator,
        keyboardType: keyboardType,
        cursorColor: AppColors.primaryTextTextColor,
        enabled: enable,
        // ignore: deprecated_member_use
        style: Theme.of(context)
            .textTheme
            // ignore: deprecated_member_use
            .bodyText2!
            .copyWith(fontSize: 19, height: 0),
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.all(15),
          // ignore: deprecated_member_use
          hintStyle: Theme.of(context)
              .textTheme
              // ignore: deprecated_member_use
              .bodyText2!
              .copyWith(
                  height: 0,
                  color: AppColors.primaryTextTextColor.withOpacity(0.8)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppColors.textFieldDefaultFocus)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppColors.secondaryColor)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppColors.alertColor)),

          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide:
                  BorderSide(color: AppColors.textFieldDefaultBorderColor)),
        ),
      ),
    );
  }
}
