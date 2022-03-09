// @dart=2.9

// ignore_for_file: deprecated_member_use

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (BuildContext context, HomeState state) {},
      builder: (BuildContext context, HomeState state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          extendBody: true,
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 0.01,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: kBottomNavigationBarHeight * 0.98,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ))),
                child: BottomNavigationBar(
                  onTap: (value) {
                    cubit.changecurrentIndex(value);
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  unselectedItemColor: Theme.of(context).textSelectionColor,
                  selectedItemColor: Colors.purple,
                  currentIndex: cubit.currentIndex,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.rss_feed),
                      label: 'Feeds',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: null,
                      icon: Icon(null),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_bag,
                      ),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'User',
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: Colors.purple,
              onPressed: () {
                cubit.changecurrentIndex(2);
              },
              child: const Icon(Icons.search_outlined),
              hoverElevation: 10,
              elevation: 4,
            ),
          ),
        );
      },
    );
  }
}
