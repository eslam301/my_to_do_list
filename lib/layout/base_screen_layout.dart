import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/app_provider.dart';

class BaseScreenLayout extends StatelessWidget {
  static const String routeName = '/baseScreenLayout';
  final String? titleName;
  final Widget? bodyWidget;
  const BaseScreenLayout ({super.key, this.titleName, this.bodyWidget});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: theme.primaryColor,
          ),

          child: AppBar(
            title: Text(
              '${titleName??'Home'}',
              style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: bodyWidget?? Container(),
    );
  }
}
