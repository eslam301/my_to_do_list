import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:intl/intl.dart';
import '../provider/app_provider.dart';
import 'my_small_button.dart';
import 'my_text_box.dart';

class TaskCard extends StatefulWidget {
  final int index;
  final List<Map<String, dynamic>> tasks;

  const TaskCard({super.key, required this.index, required this.tasks});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    String title = widget.tasks[widget.index]['title'].isEmpty
        ? 'No Title'
        : widget.tasks[widget.index]['title'] ?? '';
    String subtitle = widget.tasks[widget.index]['subtitle'].isEmpty
        ? 'No Subtitle'
        : widget.tasks[widget.index]['subtitle'] ?? '';
    DateFormat dateFormat = DateFormat('MMM/dd hh:mm');
    String date =
        dateFormat.format(DateTime.parse(widget.tasks[widget.index]['date']));
    final provider = Provider.of<MyAppProvider>(context);
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.onPrimary
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.green),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(color: theme.primaryColor),
                  ),
                ),
              ],
            ),
          ),
          Slidable(
            key: ValueKey(widget.index),
            startActionPane: ActionPane(
              dragDismissible: true,
              closeThreshold: 0.5,
              dismissible: DismissiblePane(onDismissed: () {
                provider.deleteTask(widget.index);
              }),
              extentRatio: 0.3,
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  autoClose: true,
                  onPressed: (context) {
                    provider.deleteTask(widget.index);
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.download_done_outlined,
                  label: 'Done',
                ),
              ],
            ),
            endActionPane: ActionPane(
              dragDismissible: true,
              closeThreshold: 0.6,
              dismissible: DismissiblePane(onDismissed: () {
                provider.deleteTask(widget.index);
              }),
              extentRatio: 0.45,
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                onPressed: (context) {
                  openEditBottomSheet(context, widget.index);
                },
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'edit',
              ),
                SlidableAction(
                  onPressed: (context) {
                    provider.deleteTask(widget.index);
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),

              ],
            ),
            child: Card(
              elevation: 3,
              color: theme.colorScheme.onPrimary,
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ListTile(
                  onLongPress: () {
                    openEditBottomSheet(context, widget.index);
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54, size: 18),
                  title: Text(
                    title,
                    style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subtitle,
                        style: GoogleFonts.ubuntu(
                            fontSize: 14, color: Colors.black54),
                      ),
                      Text(
                        date,
                        style: GoogleFonts.ubuntu(
                            fontSize: 14,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openEditBottomSheet(BuildContext context, int index) {
    final provider = Provider.of<MyAppProvider>(context, listen: false);
    final titleController =
        TextEditingController(text: widget.tasks[index]['title']);
    final subtitleController =
        TextEditingController(text: widget.tasks[index]['subtitle']);
    final ThemeData theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      showDragHandle: true,
      elevation: 10,
      backgroundColor: theme.scaffoldBackgroundColor,
      clipBehavior: Clip.antiAlias,
      isDismissible: true,
      useSafeArea: true,
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
                Text(
                  'Edit Task',
                  style: GoogleFonts.ubuntu(
                    color: theme.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                MyTextBox(
                  label: 'Title',
                  controller: titleController,
                ),
                const SizedBox(height: 20),
                MyTextBox(
                  label: 'Subtitle',
                  controller: subtitleController,
                ),
                const SizedBox(height: 20),
                MySmallButton(
                  label: 'Edit',
                  onPressed: () {
                    provider.updateTask(index, {
                      'title': titleController.text,
                      'subtitle': subtitleController.text,
                      'date': DateTime.now().toString(),
                    });
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
