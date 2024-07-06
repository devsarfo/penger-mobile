import 'package:flutter/material.dart';
import 'package:penger/models/slide.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_routes.dart';
import 'package:penger/resources/app_spacing.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/resources/app_styles.dart';
import 'package:penger/views/components/ui/button.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  PageController pageController = PageController();
  List<SlideModel> slides = [
    SlideModel(AppStrings.walkthroughTitle1, AppStrings.walkthroughDescription1,
        "assets/images/walkthrough1.png"),
    SlideModel(AppStrings.walkthroughTitle2, AppStrings.walkthroughDescription2,
        "assets/images/walkthrough2.png"),
    SlideModel(AppStrings.walkthroughTitle3, AppStrings.walkthroughDescription3,
        "assets/images/walkthrough3.png")
  ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.bgColour,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: pages()),
          AppSpacing.vertical(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                indicators(),
                AppSpacing.vertical(),
                buttons(),
                AppSpacing.vertical(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget indicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < slides.length; i++) ...[
          InkWell(
            onTap: () {
              if (i != currentPage) {
                pageController.animateToPage(i,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              }
            },
            child: Icon(Icons.circle,
                size: currentPage == i ? 16 : 8,
                color: currentPage == i
                    ? AppColours.primaryColour
                    : AppColours.primaryColourLight),
          ),
          if (i < slides.length - 1) AppSpacing.horizontal(size: 8),
        ]
      ],
    );
  }

  Widget buttons() {
    return Column(
      children: [
        ButtonComponent(
            label: AppStrings.signUp,
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.signup)
        ),
        AppSpacing.vertical(size: 16),
        ButtonComponent(
            type: ButtonType.secondary,
            label: AppStrings.login,
            onPressed: () => {}
        ),
      ],
    );
  }

  Widget pages() {
    return PageView.builder(
      itemBuilder: (context, index) {
        return ListView(
          padding: const EdgeInsets.all(24),
          shrinkWrap: true,
          children: [
            AppSpacing.vertical(size: 48),
            Center(
              child: Image.asset(slides[index].image,
                  width: MediaQuery.of(context).size.width / 1.5),
            ),
            AppSpacing.vertical(),
            Text(slides[index].title,
                style: AppStyles.title1(), textAlign: TextAlign.center),
            AppSpacing.vertical(size: 16),
            Text(slides[index].description,
                style: AppStyles.regular1(
                    color: AppColours.light20, weight: FontWeight.w500),
                textAlign: TextAlign.center),
          ],
        );
      },
      controller: pageController,
      itemCount: slides.length,
      onPageChanged: (index) => setState(() => currentPage = index),
    );
  }
}
