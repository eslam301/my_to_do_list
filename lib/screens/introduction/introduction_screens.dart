import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class MyIntroductionScreens extends StatelessWidget {
  static const String routeName = '/intro';
  const MyIntroductionScreens({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45),
            ),
          ),
          child: AppBar(
            title: const Text('Introduction Screen'),
            centerTitle: true,
          ),
        ),
      ),
      body:IntroductionScreen(
        pages: [
          PageViewModel(
            titleWidget: Text('My To Do List App', style: GoogleFonts.ubuntu(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            )),
            bodyWidget: Text('This is a simple To Do List App', style: GoogleFonts.ubuntu(
              fontSize: 20,
              color: theme.primaryColor,
            )),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          PageViewModel(
            titleWidget: Text('My To Do List App', style: GoogleFonts.ubuntu(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            )),
            bodyWidget: Text('This is a simple To Do List App', style: GoogleFonts.ubuntu(
              fontSize: 20,
              color: theme.primaryColor,
            )),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        done: const Text('Done', style: TextStyle(color: Colors.white)),
        next: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onDone: () {
          provider.endIntro();
          Navigator.pushReplacementNamed(context, '/home_layout');
        },
        skip: const Text('Skip',style: TextStyle(color: Colors.white)),
        showSkipButton: true,
        showNextButton: true,
        showDoneButton: true,
        curve: Curves.fastLinearToSlowEaseIn,
        dotsContainerDecorator: ShapeDecoration(
          color: theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
          ),
        ),
        dotsDecorator: DotsDecorator(
          size: Size(10.0, 10.0),
          color: Colors.white,
          activeColor: Colors.white,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
