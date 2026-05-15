import 'dart:async';

import 'package:finance_tracker/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// NAVIGATION TIMER
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              /// APP TITLE
              Text(
                "Finance Tracker",

                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              /// SUBTITLE
              Text(
                "Track. Analyze. Grow.",

                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 70),

              /// FLOATING MONEY IMAGE
              Image.asset("assets/logo.png", height: 220)
                  .animate(
                    onPlay: (controller) {
                      controller.repeat(reverse: true);
                    },
                  )
                  .moveY(
                    begin: -12,

                    end: 12,

                    duration: 1400.ms,

                    curve: Curves.easeInOut,
                  ),

              const SizedBox(height: 60),

              /// LOADER
              const SizedBox(
                height: 34,

                width: 34,

                child: CircularProgressIndicator(strokeWidth: 3),
              ),

              const SizedBox(height: 18),

              /// LOADING TEXT
              Text("Loading...", style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
