import 'package:flutter/material.dart';
import 'package:salon_booking_app/core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Nearest"),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 380, // Height for the large cards
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _buildLargeServiceCard(
                            image: "assets/services/facial.jpg",
                            name: "Danica Schaefer",
                            role: "Hairstylist",
                            address: "2828 Newell Street",
                          ),
                          const SizedBox(width: 20),
                          _buildLargeServiceCard(
                            image: "assets/services/haircut.jpg",
                            name: "Daniella Doe",
                            role: "Hair Specialist",
                            address: "2829 Old Street",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildSectionTitle("Popular Services"),
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
                            _buildSmallServiceCard("Facial", "assets/services/facial.jpg"),
                             _buildSmallServiceCard("Manicure", "assets/services/manicure.jpg"),
                              _buildSmallServiceCard("Makeup", "assets/services/makeup.jpg"),
                               _buildSmallServiceCard("Haircut", "assets/services/haircut.jpg"),
                          ],
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.transparent, // Or a dark background if matching reference exactly
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
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Colors.grey[600], // Adjust based on background
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Hello, Alexa",
                  style: AppTheme.lightTheme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Dark text
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_outlined, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        title,
        style: GoogleFonts.playfairDisplay(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildLargeServiceCard({
    required String image,
    required String name,
    required String role,
    required String address,
  }) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        role,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                       const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text(
                            address,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                 Icon(Icons.arrow_forward, color: AppTheme.primaryColor),
              ],
            ),
          ),
        ],
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
