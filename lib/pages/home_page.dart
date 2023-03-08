import 'dart:math';

import 'package:english/models/qoute_model.dart';
import 'package:english/models/quote.dart';
import 'package:english/pages/all_words.dart';
import 'package:english/pages/control_page.dart';
import 'package:english/values/app_assets.dart';
import 'package:english/values/app_colors.dart';
import 'package:english/values/app_styles.dart';
import 'package:english/values/share_reference.dart';
import 'package:english/widgets/app_button.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/english_today.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;
  List<EnglishToday> words = [];
  String quote = Quotes().getRandom().content!;

  List<int> fixedListRamdom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  initPrefs() async {}

  getEnglishToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> newList = [];
    int len = prefs.getInt(ShareReferenceKeys().Counter) ?? 5;
    List<int> rans = fixedListRamdom(len: len, max: nouns.length);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });

    setState(() {
      words = newList.map((e) => getQuote(e)).toList();
    });

    print('has data');
  }

  EnglishToday getQuote(String noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(
      noun: noun,
      quote: quote?.content,
      id: quote?.id,
    );
  }

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);

    // TODO: implement initState
    super.initState();
    initPrefs();
    getEnglishToday();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.second,
      appBar: AppBar(
        backgroundColor: AppColors.second,
        elevation: 0,
        title: Center(
          child: Text(
            'English today',
            style: AppTextStyles.h3.copyWith(color: AppColors.blackText),
          ),
        ),
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppImages.imgMenu),
        ),
      ),
      body: Column(children: [
        Container(
          height: size.height * 1 / 10,
          padding: const EdgeInsets.fromLTRB(27, 15, 27, 0),
          child: Text(
            '"It is amazing how complete is the delusion that beauty is goodness."',
            style: AppTextStyles.h5.copyWith(color: AppColors.blackText),
          ),
        ),
        Container(
          height: size.height * 2 / 3,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: words.length > 5 ? 7 : words.length,
            itemBuilder: (context, index) {
              String firstLetter =
                  words[index].noun != null ? words[index].noun! : '';
              firstLetter = firstLetter.substring(0, 1).toUpperCase();

              String leftLetter =
                  words[index].noun != null ? words[index].noun! : '';
              leftLetter = leftLetter.substring(1, leftLetter.length);

              String quoteDefault =
                  "Think of all the beauty still left around you and be happy";

              String quote = words[index].quote != null
                  ? words[index].quote!
                  : quoteDefault;

              BorderRadius.circular(24);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 7),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Column(children: [
                  Container(
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                    child: Image.asset(AppImages.imgFavorite),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(left: 7),
                    child: RichText(
                        maxLines: 1,
                        text: TextSpan(
                            text: firstLetter,
                            style: AppTextStyles.h1.copyWith(
                                fontSize: 96,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  const BoxShadow(
                                      color: Colors.black38,
                                      offset: Offset(3, 6),
                                      blurRadius: 6)
                                ]),
                            children: [
                              TextSpan(
                                  text: leftLetter,
                                  style: AppTextStyles.h3.copyWith(
                                      fontSize: 64,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        const BoxShadow(
                                            color: Colors.black38,
                                            offset: Offset(0, 0),
                                            blurRadius: 0)
                                      ]))
                            ])),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                    child: Text(
                      '“$quote”',
                      style: AppTextStyles.h4.copyWith(
                        fontSize: 28,
                        color: AppColors.blackText,
                        letterSpacing: 1,
                      ),
                    ),
                  )
                ]),
              );
            },
          ),
        ),
        //indicator
        _currentIndex > 5
            ? buildShowMore()
            : Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                height: 12,
                width: size.width,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: words.length > 5 ? 6 : words.length,
                    itemBuilder: (context, index) {
                      return buildIndicator(index == _currentIndex, size);
                    }),
              )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {getEnglishToday()},
        child: Image.asset(AppImages.imgReLoad),
        backgroundColor: AppColors.primary,
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: AppColors.lightBlue,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 22),
              child: Text(
                'Your mind',
                style: AppTextStyles.h3.copyWith(color: AppColors.blackText),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: AppButton(
                'Favorites',
                () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: AppButton(
                'Your Control',
                () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ControlPage()));
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 12,
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.blackGrey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  Widget buildShowMore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      alignment: Alignment.centerLeft,
      child: Material(
        color: AppColors.primary,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AllWorksPage()))
          },
          splashColor: Colors.pink,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Show more',
              style: AppTextStyles.h5.copyWith(color: AppColors.blackText),
            ),
          ),
        ),
      ),
    );
  }
}
