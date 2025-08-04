import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/onboarding/widgets/custom_card.dart';
import 'package:eventify_app/features/profile/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              currentIndex = index;
              setState(() {});
            },
            children: [
              CustomCard(
                imagePath: 'assets/images/page1.jpg',
                title: 'Discover Amazing Events',
                text:
                    'Easy access to popular concerts, seminars, and parties near you',
              ),
              CustomCard(
                imagePath: 'assets/images/page2.jpg',
                title: 'Stay Notified',
                text:
                    'Receive regular updates and book your favorite events instantly',
              ),
              CustomCard(
                imagePath: 'assets/images/page3.jpg',
                title: 'Navigate with Ease',
                text:
                    'Find your way with built-in maps and get to your events hassle-free',
              ),
            ],
          ),
          Positioned(
            top: size.height * 0.93,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                  child: Text(
                    'Skip', style: TextStyle(color: isDark?ThemeManager.lightPinkColor: ThemeManager.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                      dotColor:isDark?ThemeManager.secondaryColor: ThemeManager.darkPinkColor,
                      activeDotColor: isDark?ThemeManager.darkPinkColor:ThemeManager.secondaryColor
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    backgroundColor: isDark?ThemeManager.secondaryColor.withOpacity(0.8): ThemeManager.primaryColor,

                  ),
                  onPressed: () {
                    currentIndex != 2
                        ? _controller.nextPage(
                      duration: Duration(seconds: 1),
                      curve: Curves.ease,
                    )
                        : Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.login,
                    );
                  },
                  child: Text(currentIndex != 2 ? 'Next' : 'Get Started',
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 20),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
