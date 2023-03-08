import 'package:english/values/app_colors.dart';
import 'package:english/values/app_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  String label = 'A';
  VoidCallback onTap = () {};
  AppButton(String Label, VoidCallback OnTap, {super.key}) {
    label = Label;
    onTap = OnTap;
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.white,
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  color: Colors.black26, offset: Offset(3, 6), blurRadius: 6)
            ]),
        child: Text(
          label,
          style: AppTextStyles.h4.copyWith(color: AppColors.black),
        ),
      ),
    );
  }
}
