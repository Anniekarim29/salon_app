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
          FadeInRight(
            duration: const Duration(milliseconds: 500),
            key: ValueKey(_currentPage), // Triggers animation on change
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
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                backgroundColor: AppTheme.primaryColor, 
                foregroundColor: Colors.white,
              ),
              child: Icon(
                 _currentPage == _onboardingData.length - 1 ? Icons.check : Icons.arrow_forward,
                 size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 30 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppTheme.primaryColor : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
