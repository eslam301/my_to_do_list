import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_to_do_list/layout/home_layout.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../introduction/introduction_screens.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      var provider = Provider.of<MyAppProvider>(context, listen: false);
      if (provider.isDoneIntroductionScreen) {
        Navigator.pushReplacementNamed(context, HomeLayout.routeName);
      } else {
        Navigator.pushReplacementNamed(context, MyIntroductionScreens.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 200,
            ),
            const SizedBox(height: 40),
            FadeIn(
              duration: const Duration(milliseconds: 1500),
              delay: const Duration(milliseconds: 500),
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
