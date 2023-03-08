import 'package:english/values/app_assets.dart';
import 'package:english/values/app_styles.dart';
import 'package:english/values/share_reference.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/app_colors.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  late final SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderValue();
  }

  void getSliderValue() async {
    prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareReferenceKeys().Counter) ?? 6;
    setState(() {
      sliderValue = value.toDouble();
    });
  }

  void BackPage() async {
    await prefs.setInt(ShareReferenceKeys().Counter, sliderValue.toInt());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.second,
        elevation: 0,
        title: Center(
          child: Text(
            'Your Control',
            style: AppTextStyles.h3.copyWith(color: AppColors.blackText),
          ),
        ),
        leading: InkWell(
          onTap: BackPage,
          child: Image.asset(AppImages.imgLeft),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: AppColors.second,
        child: Column(children: [
          Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'How much a number word at once?',
                  style: AppTextStyles.h5
                      .copyWith(fontSize: 18, color: AppColors.blackGrey),
                ),
              )),
          Expanded(
              flex: 1,
              child: Text(
                '${sliderValue.toInt()}',
                style: AppTextStyles.h1.copyWith(
                    fontSize: 150,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold),
              )),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Slider(
                    value: sliderValue,
                    min: 5,
                    max: 100,
                    thumbColor: AppColors.primary,
                    activeColor: AppColors.primary,
                    onChanged: (value) => {
                      setState(() {
                        sliderValue = value;
                      })
                    },
                  ),
                  Text(
                    'slide to set',
                    style: AppTextStyles.h4
                        .copyWith(fontSize: 14, color: AppColors.blackText),
                    textAlign: TextAlign.left,
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}
