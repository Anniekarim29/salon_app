import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:salon_booking_app/core/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:salon_booking_app/features/home/screens/booking_detail_screen.dart';

import 'package:salon_booking_app/features/shop/screens/shop_screen.dart';
import 'package:salon_booking_app/features/chat/screens/chat_screen.dart';
import 'package:salon_booking_app/features/settings/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<String> _categories = ["All", "Hair", "Makeup", "Skin", "Nails"];
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            _buildHomeContent(),
            const ShopScreen(),
            const ChatScreen(),
            const SettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey[400],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_rounded), label: "Shop"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: "Settings"),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Column(
      children: [
        FadeInDown(duration: const Duration(milliseconds: 600), child: _buildHeader()),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  delay: const Duration(milliseconds: 100),
                  child: _buildCategories(),
                ),
                const SizedBox(height: 20),
                FadeInRight(
                  delay: const Duration(milliseconds: 200),
                  child: _buildSectionTitle("Nearest"),
                ),
                SizedBox(
                  height: 400, // Increased height to accommodate shadow
                  child: ListView.builder(
                    itemCount: _consultants.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final consultant = _consultants[index];
                      return FadeInRight(
                        delay: Duration(milliseconds: 200 * (index + 1)),
                        child: _buildLargeServiceCard(
                          context: context, // Passing context
                          image: consultant["image"]!,
                          name: consultant["name"]!,
                          role: consultant["role"]!,
                          address: consultant["address"]!,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                FadeInLeft(
                  delay: const Duration(milliseconds: 800),
                  child: _buildSectionTitle("Popular Services"),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.8,
                    children: [
                      FadeInUp(delay: const Duration(milliseconds: 900), child: _buildSmallServiceCard("Facial", "assets/services/facial.jpg")),
                      FadeInUp(delay: const Duration(milliseconds: 1000), child: _buildSmallServiceCard("Manicure", "assets/services/manicure.jpg")),
                      FadeInUp(delay: const Duration(milliseconds: 1100), child: _buildSmallServiceCard("Makeup", "assets/services/makeup.jpg")),
                      FadeInUp(delay: const Duration(milliseconds: 1200), child: _buildSmallServiceCard("Haircut", "assets/services/haircut.jpg")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.transparent, 
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jan, 31",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey[600],
                    letterSpacing: 1
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Hello, Anmol",
                  style: AppTheme.lightTheme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Dark text
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
               ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("No new notifications", style: GoogleFonts.montserrat()),
                    backgroundColor: Colors.black,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                );
            },
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_outlined, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.grey.shade300,
                ),
              ),
              child: Text(
                _categories[index],
                style: GoogleFonts.montserrat(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        title,
        style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
          color: Colors.black,
        ),
      ),
    );
  }




// ... (in HomeScreen widget)

// ...

  static const List<Map<String, String>> _consultants = [
    {
      "image": "assets/services/facial.jpg",
      "name": "Annie Karim",
      "role": "Skin Specialist", // Fixed role to match Facial image
      "address": "2828 Defence Phase 6",
    },
    {
      "image": "assets/services/haircut.jpg",
      "name": "Ayesha Khan",
      "role": "Hair Specialist",
      "address": "2829 Gulberg III",
    },
    {
      "image": "assets/services/makeup.jpg",
      "name": "Sana Ahmed",
      "role": "Makeup Artist",
      "address": "15 Block Y, DHA",
    },
     {
      "image": "assets/services/manicure.jpg",
      "name": "Zoya Ali",
      "role": "Nail Technician",
      "address": "10 Block C, Model Town",
    },
  ];

  Widget _buildLargeServiceCard({
    required BuildContext context, // Added context for navigation
    required String image,
    required String name,
    required String role,
    required String address,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingDetailScreen(
              image: image,
              name: name,
              role: role,
              address: address,
            ),
          ),
        );
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 20, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.12),
              blurRadius: 25,
              spreadRadius: 2,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero( // Added Hero animation
                tag: image,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22), // Increased padding
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.cormorantGaramond( // Changed to premium serif font
                             fontWeight: FontWeight.w700, // Bold
                             color: Colors.black,
                             fontSize: 22, // Larger size
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          role,
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold, // Bolder
                            letterSpacing: 0.5,
                          ),
                        ),
                         const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded, size: 16, color: Colors.grey[400]),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                   Container(
                     decoration: BoxDecoration(
                       color: AppTheme.backgroundColor,
                       shape: BoxShape.circle,
                     ),
                     padding: const EdgeInsets.all(10), // Larger touch target
                     child: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppTheme.primaryColor)
                   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


   Widget _buildSmallServiceCard(String title, String image) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
