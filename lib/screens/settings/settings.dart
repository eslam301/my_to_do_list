import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var provider = Provider.of<MyAppProvider>(context);
    bool isDarkMode = provider.isDarkMode;
    bool isNotifications_on = provider.isNotifications_on;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Settings',
          style: GoogleFonts.ubuntu(
              color: isDarkMode ? Colors.white : theme.primaryColor,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDarkMode ? Colors.white38 : theme.primaryColor.withOpacity(0.8),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Dark Mode',
                  style: GoogleFonts.ubuntu(
                      color: isDarkMode ? theme.primaryColor : Colors.white,
                      fontSize: 20),
                ),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      provider.changeTheme();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                  'Notifications',
                  style: GoogleFonts.ubuntu(
                      color: isDarkMode ? theme.primaryColor : Colors.white,
                      fontSize: 20),
                ),
                trailing: Switch(
                  value: isNotifications_on,
                  onChanged: (value) {
                    setState(() {
                      provider.changeNotifications();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
