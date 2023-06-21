import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'login_page.dart';

class MyRestaurantPage extends StatefulWidget {
  static const routeName = '/my-restaurant';
  const MyRestaurantPage({super.key});

  @override
  State<MyRestaurantPage> createState() => _MyRestaurantPageState();
}

class _MyRestaurantPageState extends State<MyRestaurantPage> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Restaurant'),
        actions: [],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text('no data')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (value) {},
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), label: 'All Restaurant'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'My Account'),
        ],
      ),
    );
  }
}
