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
            color: isDarkMode ? Colors.white38 : theme.primaryColor,
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
                  'Language',
                  style: GoogleFonts.ubuntu(
                      color: isDarkMode ? theme.primaryColor : Colors.white,
                      fontSize: 20),
                ),
                subtitle: DropdownButton<String>(
                  value: provider.language,
                  onChanged: (String? newValue) {
                    setState(() {
                      provider.language = newValue!;
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down),
                  dropdownColor: theme.primaryColor,
                  style: GoogleFonts.ubuntu(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 20),
                  borderRadius: BorderRadius.circular(20),
                  underline: Container(),
                  isExpanded: true,
                  alignment: Alignment.center,
                  iconSize: 30,
                  padding: const EdgeInsets.all(10),
                  items: <String>['English', 'Spanish', 'French', 'German']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
