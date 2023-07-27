import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool loading;
  final Color color, textColor;
  const RoundButton(
      {super.key,
      required this.title,
      required this.onPress,
      this.loading = false,
      this.textColor = AppColors.whiteColor,
      this.color = AppColors.primaryButtonCollor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Center(
                // ignore: deprecated_member_use
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      // ignore: deprecated_member_use
                      .headline2!
                      .copyWith(fontSize: 16, color: textColor),
                ),
              ),
      ),
    );
  }
}
