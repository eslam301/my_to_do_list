import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/app_provider.dart';
import '../screens/home/home_screen.dart';
import '../screens/settings/settings.dart';
import '../widgets/my_small_button.dart';
import '../widgets/my_text_box.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = '/home_layout';

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = const [HomeScreen(), SettingsScreen()];
    PageController pageController = PageController();

    var provider = Provider.of<MyAppProvider>(context);
    var theme = Theme.of(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: provider.index == 0
          ? FloatingActionButton(
              elevation: 20,
              shape: const CircleBorder(),
              backgroundColor: theme.primaryColor,
              onPressed: () {
                openAddTaskBottomSheet(context);
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
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
              'My To Do List',
              style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
                onPressed: () {
                  provider.changeTheme();
                },
                icon: Icon(
                    provider.isDarkMode ? Icons.dark_mode : Icons.light_mode)),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    provider.changePageIndex(1);
                    pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                  icon: const Icon(Icons.settings)),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        pageSnapping: true,
        onPageChanged: (index) {
          provider.changePageIndex(index);
        },
        controller: pageController,
        children: screens,
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: BottomAppBar(
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () => pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut),
                    icon: const Icon(
                      Icons.task_alt_rounded,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () => pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut),
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    )),
              ],
            )),
      ),
    );
  }

  void openAddTaskBottomSheet(BuildContext context) {
    final TextEditingController titleTaskController = TextEditingController();
    final TextEditingController subtitleTaskController =
        TextEditingController();
    var provider = Provider.of<MyAppProvider>(context, listen: false);
    var theme = Theme.of(context);
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      showDragHandle: true,
      elevation: 10,
      backgroundColor: theme.scaffoldBackgroundColor,
      clipBehavior: Clip.antiAlias,
      isDismissible: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: FractionallySizedBox(
            heightFactor: 0.6,
            child: ListView(
              children: [
                Text('Add Task',
                    style: GoogleFonts.ubuntu(
                      color: theme.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 20,
                ),
                MyTextBox(label: 'Task title', controller: titleTaskController),
                const SizedBox(
                  height: 20,
                ),
                MyTextBox(
                    label: 'Task subtitle', controller: subtitleTaskController),
                const SizedBox(
                  height: 20,
                ),
                MySmallButton(
                  onPressed: () {
                    provider.addTask({
                      'title': titleTaskController.text,
                      'subtitle': subtitleTaskController.text,
                      'date': DateTime.now().toString()
                    });
                    Navigator.pop(context);
                  },
                  label: 'Add',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
