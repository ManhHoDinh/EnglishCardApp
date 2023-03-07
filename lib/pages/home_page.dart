import 'package:english/values/app_assets.dart';
import 'package:english/values/app_colors.dart';
import 'package:english/values/app_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.second,
      appBar: AppBar(
        backgroundColor: AppColors.second,
        elevation: 0,
        title: Center(
          child: Text(
            'English today',
            style: AppTextStyles.h4.copyWith(color: AppColors.blackText),
          ),
        ),
        leading: InkWell(
          onTap: () => {},
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
            itemCount: 5,
            itemBuilder: (context, index) {
              BorderRadius.circular(24);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 7  ),
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
                            text: 'B',
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
                                  text: 'eautiful',
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
                      '“Think of all the beauty still left around you and be happy.”',
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
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.fromLTRB(10, 15, 0, 0),
          height: 12,
          width: size.width,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return buildIndicator(index == _currentIndex, size);
              }),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Image.asset(AppImages.imgReLoad),
        backgroundColor: AppColors.primary,
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
}
