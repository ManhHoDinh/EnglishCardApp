import 'package:english/pages/home_page.dart';
import 'package:english/values/app_assets.dart';
import 'package:english/values/app_colors.dart';
import 'package:english/values/app_styles.dart';
import 'package:flutter/material.dart';

class LaudingPage extends StatelessWidget {
  const LaudingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome to',
                    style: AppTextStyles.h3,
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'English',
                        textAlign: TextAlign.left,
                        style: AppTextStyles.h2.copyWith(
                            color: AppColors.blackGrey,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Text(
                          'Qoutes"',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.h4,
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 100),
                    child: RawMaterialButton(
                      fillColor: AppColors.lightBlue,
                      shape: CircleBorder(),
                      onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (a) => HomePage()),
                            (route) => false)
                      },
                      child: Image.asset(AppImages.imgNext),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
