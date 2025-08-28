import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../services/session_service.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Selamat Datang",
          body: "Aplikasi UKK untuk manajemen user dengan interface yang elegan",
          image: Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Color(0xFF8B4513),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF8B4513).withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(Icons.waving_hand, size: 100, color: Colors.white),
            ),
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3D2914),
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Color(0xFF8B7355),
            ),
            pageColor: Color(0xFFFAF7F4),
          ),
        ),
        PageViewModel(
          title: "Mudah Digunakan",
          body: "Interface yang user-friendly dengan desain yang menarik dan intuitif",
          image: Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Color(0xFFD2B48C),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD2B48C).withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(Icons.touch_app, size: 100, color: Colors.white),
            ),
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3D2914),
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Color(0xFF8B7355),
            ),
            pageColor: Color(0xFFFAF7F4),
          ),
        ),
        PageViewModel(
          title: "Siap Digunakan",
          body: "Mari mulai menggunakan aplikasi ini dan nikmati pengalaman yang luar biasa",
          image: Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8B4513), Color(0xFFD2B48C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF8B4513).withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(Icons.rocket_launch, size: 100, color: Colors.white),
            ),
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3D2914),
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Color(0xFF8B7355),
            ),
            pageColor: Color(0xFFFAF7F4),
          ),
        ),
      ],
      onDone: () async {
        // Mark that onboarding has been seen
        await SessionService.setFirstTimeFalse();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      done: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFF8B4513),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          "Mulai",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      showSkipButton: true,
      skip: Text(
        "Skip",
        style: TextStyle(
          color: Color(0xFF8B4513),
          fontWeight: FontWeight.w500,
        ),
      ),
      onSkip: () async {
        // Mark that onboarding has been seen when skipped
        await SessionService.setFirstTimeFalse();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      next: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF8B4513),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.arrow_forward, color: Colors.white),
      ),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFD2B48C),
        activeSize: Size(22.0, 10.0),
        activeColor: Color(0xFF8B4513),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      globalBackgroundColor: Color(0xFFFAF7F4),
    );
  }
}