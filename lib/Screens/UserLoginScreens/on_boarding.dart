import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/MyWidgets/on_boarding_page.dart';
import 'package:eshoppie/Screens/UserLoginScreens/sign_up.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageController = PageController();
  int index = 0;
  List pages = [
    const OnBoardingPageDesign(
      image: 'images/iPhone1.png',
      title: 'Welcome to eShoppie App !',
      body: 'Buy your products with low prices and high quality.',
    ),
    const OnBoardingPageDesign(
      image: 'images/HeadPhone.jpg',
      title: 'Discover more !',
      body: 'Discover more new and luxury products.',
    ),
    const OnBoardingPageDesign(
      image: 'images/iPhone12.jpg',
      title: 'Shop the best !',
      body: 'Shop the best & luxury products from eShoppie.',
    ),
    const OnBoardingPageDesign(
      image: 'images/HeadPhone2.jpg',
      title: 'Sign up now !',
      body: 'Sign up and start your best shopping with the best prices.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                size: 25,
              ),
              MyText(
                text: ' eShoppie',
                size: K_fontSizeL,
                color: K_whiteColor,
              )
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(K_mainPadding),
          child: AnimatedContainer(
            width: index != 3
                ? 60
                : 100, //Will be changed if we reached to the last page
            duration: const Duration(milliseconds: 200),
            child: FloatingActionButton(
              onPressed: () async {
                if (index < pages.length - 1) {
                  pageController.animateToPage(index + 1,
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastLinearToSlowEaseIn);
                } else {
                  await saveOnBoardingInShared();
                  navigateToWithReplace(context, SignUp());
                }
              },
              backgroundColor: K_whiteColor,
              //Will be changed if we reached to the last page
              child: index != 3
                  ? const Icon(
                      CupertinoIcons.arrow_right,
                      color: K_blackColor,
                    )
                  : MyText(
                      text: 'Sign up',
                      size: K_fontSizeL - 2,
                      fontWeight: FontWeight.normal,
                    ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(K_radius)),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(
          children: [
            PageView.builder(
              onPageChanged: (pageIdx) {
                index = pageIdx; //To update index value
                //To make set state only when we reach to the final page this will improve the performance
                if (index == pages.length - 1 || index == pages.length - 2) {
                  setState(() {});
                }
              },
              controller: pageController,
              itemBuilder: (context, index) {
                return pages[index];
              },
              itemCount: pages.length,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight! * 0.62),
              child: Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: pages.length,
                  effect: const SwapEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: K_whiteColor,
                      dotColor: K_greyColor,
                      paintStyle: PaintingStyle.stroke
                      // strokeWidth: 5,
                      ),
                ),
              ),
            ),
            if (index != 3) //Will be hidden if we reached to the last page
              Padding(
                padding: const EdgeInsets.all(K_mainPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await saveOnBoardingInShared();
                        navigateToWithReplace(context, SignUp());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: K_mainPadding,
                        ),
                        child: MyText(
                          text: 'Skip',
                          size: K_fontSizeL,
                          color: K_greyColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ));
  }
}
