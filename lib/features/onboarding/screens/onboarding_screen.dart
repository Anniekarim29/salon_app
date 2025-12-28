import 'package:flutter/material.dart';
import 'package:salon_booking_app/core/theme/app_theme.dart';
import 'package:salon_booking_app/features/auth/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/onboarding/onboarding1.jpg",
      "title": "Welcome to Salon",
      "description": "Experience the best beauty services at your fingertips.",
    },
    {
      "image": "assets/onboarding/onboarding2.jpg",
      "title": "Expert Stylists",
      "description": "Book appointments with top-rated professionals.",
    },
    {
      "image": "assets/onboarding/onboarding3.jpg",
      "title": "Relax & Rejuvenate",
      "description": "Treat yourself to a day of pampering and care.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return _buildPage(
                image: _onboardingData[index]["image"]!,
                title: _onboardingData[index]["title"]!,
                description: _onboardingData[index]["description"]!,
              );
            },
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => _buildDot(index: index),
                  ),
                ),
                const SizedBox(height: 30),
                if (_currentPage == _onboardingData.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
      {required String image, required String title, required String description}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.displayLarge?.copyWith(
              color: Colors.white,
              shadows: [
                const Shadow(
                  offset: Offset(0, 2),
                  blurRadius: 4.0,
                  color: Colors.black45,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              description,
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontSize: 18,
                shadows: [
                  const Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 2.0,
                    color: Colors.black45,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppTheme.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
