import 'package:chatapphg/pages/calls_page.dart';
import 'package:chatapphg/pages/contacts_page.dart';
import 'package:chatapphg/pages/messages_page.dart';
import 'package:chatapphg/pages/notifications_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
//Creating a list of pages for navbar

  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[0],
      ),
      bottomNavigationBar: const _BottomNavigationBar(),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavigationBarItem(),
          _NavigationBarItem(),
          _NavigationBarItem(),
          _NavigationBarItem(),
        ],
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('item');
  }
}
