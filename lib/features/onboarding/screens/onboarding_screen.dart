-
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
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
      "title": "Elegance Redefined",
      "description": "Discover a world where beauty meets sophistication.",
    },
    {
      "image": "assets/onboarding/onboarding2.jpg",
      "title": "Expert Care",
      "description": "Our professionals are dedicated to your perfect look.",
    },
    {
      "image": "assets/onboarding/onboarding3.jpg",
      "title": "Your Time to Shine",
      "description": "Book your appointment and let us pamper you.",
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
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomPanel(),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Luxe Salon",
                style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 2),
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SafeArea(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _currentPage == _onboardingData.length - 1 ? 0.0 : 1.0,
                child: IgnorePointer(
                  ignoring: _currentPage == _onboardingData.length - 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
      {required String image, required String title, required String description}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
        ),
        // Gradient Overlay for readability
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.1),
                Colors.transparent,
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.9),
              ],
              stops: const [0.0, 0.4, 0.8, 1.0],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               FadeInUp(
                 duration: const Duration(milliseconds: 600),
                 child: Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 2),
                        blurRadius: 4.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                           ),
               ),
              const SizedBox(height: 15),
               FadeInUp(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 600),
                 child: Text(
                  description,
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                           ),
               ),
              const SizedBox(height: 100), // Space for bottom controls
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomPanel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(
              _onboardingData.length,
              (index) => _buildDot(index: index),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _currentPage == _onboardingData.length - 1 ? 200 : 70,
            height: 70,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage < _onboardingData.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: _currentPage == _onboardingData.length - 1
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      )
                    : const CircleBorder(),
                padding: EdgeInsets.zero, // Let Container control size
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: _currentPage == _onboardingData.length - 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward),
                      ],
                    )
                  : const Icon(
                      Icons.arrow_forward,
                      size: 28,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required int index}) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 8),
        height: 8,
        width: _currentPage == index ? 30 : 8,
        decoration: BoxDecoration(
          color: _currentPage == index
              ? AppTheme.primaryColor
              : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
