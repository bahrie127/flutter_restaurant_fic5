import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant_fic5/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/my_restaurant_page.dart';
import 'package:flutter_restaurant_fic5/presentation/widgets/restaurant_card.dart';

import 'package:go_router/go_router.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();

  @override
  void initState() {
    context.read<GetAllProductBloc>().add(const GetAllProductEvent.get());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('List Restaurant'),
        actions: [],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: BlocBuilder<GetAllProductBloc, GetAllProductState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: () => const Text('error'),
                  loaded: (data) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return RestaurantCard(data: data.data[index]);
                      },
                      itemCount: data.data.length,
                    );
                  },
                );
              },
            )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (value) {
          if (value == 1) {
            context.push(MyRestaurantPage.routeName);
          }
        },
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
