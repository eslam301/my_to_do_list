import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_to_do_list/layout/home_layout.dart';
import 'package:my_to_do_list/provider/app_provider.dart';
import 'package:my_to_do_list/screens/introduction/introduction_screens.dart';
import 'package:my_to_do_list/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'core/theme/application_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyAppProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
    ]);
    var provider = Provider.of<MyAppProvider>(context);
    ThemeMode? themeMode = provider.themeMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My To Do List',
      theme: ApplicationTheme.lightTheme,
      darkTheme: ApplicationTheme.darkTheme,
      themeMode: themeMode,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeLayout.routeName: (context) => const HomeLayout(),
        MyIntroductionScreens.routeName: (context) => const MyIntroductionScreens(),
      },
    );
  }
}
