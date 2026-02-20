import 'package:evently/onboarding/widgets/onboarding_widget.dart';
import 'package:flutter/material.dart';
import '../core/gen/assets.gen.dart';
import 'onboarding_data.dart';


class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    controller.addListener(_pageListener);
  }

  void _pageListener() {
    if (!mounted) return;

    setState(() {
      currentIndex = controller.page?.round() ?? 0;
    });
  }

  @override
  void dispose() {
    controller.removeListener(_pageListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FF),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Assets.images.eventlyLogo.image(scale: 1.25),

            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: OnboardingData.onboardingAllData.length,
                itemBuilder: (context, index) => OnboardingWidget(
                  onboardingData:
                  OnboardingData.onboardingAllData[index],
                  controller: controller,
                  currentIndex: currentIndex,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}