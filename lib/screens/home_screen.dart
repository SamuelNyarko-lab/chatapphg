import 'package:chatapphg/pages/calls_page.dart';
import 'package:chatapphg/pages/contacts_page.dart';
import 'package:chatapphg/pages/messages_page.dart';
import 'package:chatapphg/pages/notifications_page.dart';
import 'package:chatapphg/theme.dart';
import 'package:chatapphg/widgets/glowing_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatapphg/widgets/widgets.dart';

import '../helpers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//Creating a list of pages for navbar
  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage()
  ];

  final titles = const ['Messages', 'Notifications', 'Calls', 'Contacts'];

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> titleIndex = ValueNotifier('Messages');
  void _onNavigationItemSelected(index) {
    titleIndex.value = titles[index];
    pageIndex.value = index;
  }

  //This notifies if value changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: titleIndex,
          builder: (context, value, _) {
            return Text(
              titleIndex.value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 24,
            ),
            child: Avatar.small(url: Helpers.randomPictureUrl().toString()),
          ),
        ],
        iconTheme: Theme.of(context).iconTheme,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: () {},
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    // ignore: unused_element
    super.key,
    required this.onItemSelected,
  });
  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  //passing index up to BottomNavigationBar
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      margin: EdgeInsets.all(0),
      elevation: 0,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 16.0,
            bottom: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                label: 'Messages',
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                index: 0,
                isSelected: (selectedIndex == 0), //check if value is selected
                onTap: handleItemSelected,
              ),
              _NavigationBarItem(
                label: 'Notifications',
                icon: CupertinoIcons.bell_solid,
                index: 1,
                isSelected: (selectedIndex == 1),
                onTap: handleItemSelected,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GlowingActionButton(
                  color: AppColors.secondary,
                  icon: CupertinoIcons.add,
                  onPressed: () {
                    print('add');
                  },
                ),
              ),
              _NavigationBarItem(
                label: 'Calls',
                icon: CupertinoIcons.phone_fill,
                index: 2,
                isSelected: (selectedIndex == 2),
                onTap: handleItemSelected,
              ),
              _NavigationBarItem(
                label: 'Contacts',
                icon: CupertinoIcons.person_2_fill,
                index: 3,
                isSelected: (selectedIndex == 3),
                onTap: handleItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    // ignore: unused_element
    super.key,
    required this.label,
    required this.icon,
    required this.index,
    this.isSelected = false,
    required this.onTap,
  });

  final ValueChanged<int>
      onTap; //gets the index of the and pass it up to the parent
  final String label;
  final IconData icon;
  final int index;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior:
          HitTestBehavior.opaque, //solves click beside icon that doesn't work
      onTap: () => onTap(index),
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: isSelected
                  ? TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    )
                  : TextStyle(
                      fontSize: 11,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
