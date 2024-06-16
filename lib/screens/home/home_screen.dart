import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyAppProvider>(context, listen: false);
    final tasksList = provider.tasks;
    final key = provider.listKey;
    final theme = Theme.of(context);
    return Scaffold(
      body: tasksList.isEmpty
          ? Center(
        child: Text(
          'No tasks added yet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
      )
          : AnimatedList(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        physics: const BouncingScrollPhysics(),
        primary: true,
        key: key,
        initialItemCount: tasksList.length,
        itemBuilder: (context, index, animation) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          );
          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position:Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
                        ).animate(curvedAnimation),
              child: TaskCard(
                index: index,
                tasks: tasksList,
              ),
            ),
          );
        },
      ),
    );
  }
}
