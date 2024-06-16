import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyAppProvider extends ChangeNotifier {
  bool isDoneIntroductionScreen = false;
  int index = 0;
  bool isDarkMode = false;
  ThemeMode themeMode = ThemeMode.light;
  double volume = 0.5;
  String language = 'English';

  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<Map<String, dynamic>> tasks = [];
  MyAppProvider() {
    // Load tasks and theme when the provider is initialized
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    await getIntroState();
    await getThemeFromPrefs();
    await getTasksFromPrefs();
  }
  void getLanguage() {
    notifyListeners();
  }
  Future<void> saveTasksToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('index', index);
    prefs.setString('tasks', jsonEncode(tasks));
  }

  Future<void> getTasksFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    index = prefs.getInt('index') ?? 0;
    String? tasksString = prefs.getString('tasks');
    if (tasksString != null && tasksString.isNotEmpty) {
      tasks = List<Map<String, dynamic>>.from(jsonDecode(tasksString));
    } else {
      tasks = [];
    }
    notifyListeners();
  }

  void changePageIndex(int index) {
    this.index = index;
    saveTasksToPrefs();  // Save the index change to prefs
    notifyListeners();
  }

  void addTask(Map<String, dynamic> task) {
    tasks.add(task);
    saveTasksToPrefs();
    listKey.currentState?.insertItem(tasks.length - 1);
    notifyListeners();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    saveTasksToPrefs();
    listKey.currentState?.removeItem(index, (context, animation) {
      return const SizedBox();
    });
    notifyListeners();
  }

  void updateTask(int index, Map<String, dynamic> newTask) {
    tasks[index] = newTask;
    saveTasksToPrefs();
    notifyListeners();
  }

  Future<void> changeTheme() async {
    isDarkMode = !isDarkMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> getThemeFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> endIntro() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDoneIntroductionScreen', true);
    notifyListeners();
  }
  Future<void> getIntroState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDoneIntroductionScreen = prefs.getBool('isDoneIntroductionScreen') ?? false;
    notifyListeners();
  }

}
