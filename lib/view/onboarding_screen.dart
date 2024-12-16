import 'package:flutter/material.dart';

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
      "image": "assets/images/welcome.png",
      "title": "Welcome",
      "description":
          "It's a pleasure to meet you. We are excited that you're here so let's get started."
    },
    {
      "image": "assets/images/welcome2.png",
      "title": "All Your Favourites",
      "description":
          "Get your favourite meals delivered fresh and fast with just a few taps!"
    },
    {
      "image": "assets/images/welcome3.png",
      "title": "Super Fast Delivery",
      "description":
          "Easily find your type of food craving and you will get fast delivery in wide range."
    },
  ];

  void _goToLoginPage() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // PageView Section
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(
                    image: _onboardingData[index]['image']!,
                    title: _onboardingData[index]['title']!,
                    description: _onboardingData[index]['description']!,
                  );
                },
              ),
            ),
            // Progress Dots and Navigation
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Circular background and image
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                shape: BoxShape.circle,
              ),
            ),
            Image.asset(
              image,
              height: 220,
              width: 220,
              fit: BoxFit.contain,
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  // Bottom Section for Progress and Button
  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Progress Indicator Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingData.length,
              (index) => _buildDot(index),
            ),
          ),
          const SizedBox(height: 20),
          // Navigation Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage == _onboardingData.length - 1) {
                  _goToLoginPage();
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                _currentPage == _onboardingData.length - 1
                    ? "Get Started"
                    : "Next",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Skip Button
          TextButton(
            onPressed: _goToLoginPage,
            child: const Text(
              "Skip",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Progress Dots
  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: _currentPage == index ? 20 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.orange : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}