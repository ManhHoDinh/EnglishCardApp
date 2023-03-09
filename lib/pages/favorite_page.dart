import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../models/english_today.dart';
import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';

class FavoriteWordsPage extends StatefulWidget {
  FavoriteWordsPage(List<EnglishToday> Words, {super.key}) {
    words = Words;
  }

  List<EnglishToday> words = [];
  List<EnglishToday> allWords = [];
  @override
  State<FavoriteWordsPage> createState() => _FavoriteWordsPageState();
}

class _FavoriteWordsPageState extends State<FavoriteWordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.second,
          elevation: 0,
          title: Center(
            child: Text(
              'Favorite words',
              style: AppTextStyles.h3.copyWith(color: AppColors.blackText),
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(AppImages.imgLeft),
          ),
        ),
        body: Container(
          color: AppColors.white,
          child: Container(
            child: ListView.builder(
                itemCount: widget.words.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? AppColors.primary
                            : AppColors.second,
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      title: AutoSizeText(
                        widget.words[index].noun ?? '',
                        maxLines: 1,
                        style: AppTextStyles.h4
                            .copyWith(color: AppColors.blackText),
                      ),
                      subtitle: Text(widget.words[index].quote ??
                          '"Think of all the beauty still left around you and be happy"'),
                      leading: InkWell(
                          onTap: () {
                            setState(() {
                              widget.words[index].isFavorite =
                                  !widget.words[index].isFavorite;
                            });
                            if (!widget.words[index].isFavorite) {
                              widget.words.remove(widget.words[index]);
                            }
                          },
                          child: Image.asset(
                            AppImages.imgFavorite,
                            color: widget.words[index].isFavorite
                                ? Colors.red
                                : Colors.white,
                          )),
                    ),
                  );
                }),
          ),
        ));
  }
}
