import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyAppProvider extends ChangeNotifier {
  bool isDoneIntroductionScreen = false;
  int activeTasksIndex = 0;
  int doneTasksIndex = 0;
  bool isDarkMode = false;
  bool isNotifications_on = true;
  ThemeMode themeMode = ThemeMode.light;
  double volume = 0.5;
  String language = 'English';

  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  GlobalKey<AnimatedListState> doneListKey = GlobalKey<AnimatedListState>();
  List<Map<String, dynamic>> activeTasks = [];
  List<Map<String, dynamic>> doneTasks = [];
  MyAppProvider() {
    // Load tasks and theme when the provider is initialized
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    await getIntroState();
    await getThemeFromPrefs();
    await getActiveTasksFromPrefs();
    await getDoneTasksFromPrefs();
  }

  Future<void> saveActiveTasksToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('ActiveIndex', activeTasksIndex);
    prefs.setString('activeTasks', jsonEncode(activeTasks));
  }

  Future<void> saveDoneTasksToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('doneIndex', doneTasksIndex);
    prefs.setString('doneTasks', jsonEncode(doneTasks));
  }

  Future<void> getActiveTasksFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    activeTasksIndex = prefs.getInt('ActiveIndex') ?? 0;
    String? tasksString = prefs.getString('activeTasks');
    if (tasksString != null && tasksString.isNotEmpty) {
      activeTasks = List<Map<String, dynamic>>.from(jsonDecode(tasksString));
    } else {
      activeTasks = [];
    }
    notifyListeners();
  }

  Future<void> getDoneTasksFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    doneTasksIndex = prefs.getInt('doneIndex') ?? 0;
    String? tasksString = prefs.getString('doneTasks');
    if (tasksString != null && tasksString.isNotEmpty) {
      doneTasks = List<Map<String, dynamic>>.from(jsonDecode(tasksString));
    } else {
      doneTasks = [];
    }
    notifyListeners();
  }

  void changePageIndex(int index) {
    this.activeTasksIndex = index;
    saveActiveTasksToPrefs(); // Save the index change to prefs
    notifyListeners();
  }

  void addActiveTask(Map<String, dynamic> task) {
    activeTasks.add(task);
    saveActiveTasksToPrefs();
    listKey.currentState?.insertItem(activeTasks.length - 1);
    notifyListeners();
  }

  void addDoneTask(Map<String, dynamic> task) {
    doneTasks.add(task);
    saveDoneTasksToPrefs();
    doneListKey.currentState?.insertItem(doneTasks.length - 1);
    notifyListeners();
  }

  void deleteActiveTask(int index) {
    activeTasks.removeAt(index);
    saveActiveTasksToPrefs();
    listKey.currentState?.removeItem(index, (context, animation) {
      return const SizedBox();
    });
    notifyListeners();
  }

  void deleteDoneTask(int index) {
    doneTasks.removeAt(index);
    saveDoneTasksToPrefs();
    doneListKey.currentState?.removeItem(index, (context, animation) {
      return const SizedBox();
    });
    notifyListeners();
  }

  void done(int index) {
    addDoneTask(activeTasks[index]);
    deleteActiveTask(index);
    saveActiveTasksToPrefs();
    saveDoneTasksToPrefs();
    notifyListeners();
  }

  undone(int index) {
    addActiveTask(doneTasks[index]);
    deleteDoneTask(index);

    saveActiveTasksToPrefs();
    saveDoneTasksToPrefs();
    notifyListeners();
  }

  void updateTask(
      {required int index,
      required Map<String, dynamic> newTask,
      required bool isDone}) {
    isDone ? doneTasks[index] = newTask : activeTasks[index] = newTask;
    saveActiveTasksToPrefs();
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
    isDoneIntroductionScreen =
        prefs.getBool('isDoneIntroductionScreen') ?? false;
    notifyListeners();
  }

  void changeNotifications() {
    isNotifications_on = !isNotifications_on;
    notifyListeners();
  }
}
