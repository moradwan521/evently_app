import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../layout/layout_screen.dart';
import '../onboarding_data.dart';
import 'indicator_widget.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.onboardingData,
    required this.controller,
    required this.currentIndex,
  });

  final OnboardingData onboardingData;
  final PageController controller;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(onboardingData.img),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              OnboardingData.onboardingAllData.length,
                  (index) =>
                  IndicatorWidget(active: index == currentIndex),
            ),
          ),

          Text(
            onboardingData.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff1C1C1C),
            ),
          ),

          Text(
            onboardingData.description,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff686868),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    if (currentIndex ==
                        OnboardingData
                            .onboardingAllData.length -
                            1) {
                      await _finishOnboarding(context);
                    } else {
                      controller.animateToPage(
                        currentIndex + 1,
                        duration:
                        const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0E3A99),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    currentIndex ==
                        OnboardingData
                            .onboardingAllData.length - 1
                        ? "Get started"
                        : "Next",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _finishOnboarding(BuildContext context) async {
    final preferences =
    await SharedPreferences.getInstance();
    await preferences.setBool('firstTime', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LayoutScreen(),
      ),
    );
  }
}