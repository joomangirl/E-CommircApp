// @dart=2.9

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'brands_navigation_rail.dart';

class BrandsNavigationRail extends StatelessWidget {
  const BrandsNavigationRail({Key key}) : super(key: key);

  //static const routeName = '/brands_navigation_rail';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        const padding = 8.0;

        return Scaffold(
            appBar: AppBar(),
            body: Row(
              children: [
                LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: IntrinsicHeight(
                        child: NavigationRail(
                          minWidth: 60.0,
                          groupAlignment: 1.0,
                          selectedIndex: cubit.selectPrandIndex,
                          onDestinationSelected: (index) {
                            cubit.onDestinationSelected(index);
                            cubit.getPrandFeed();
                          },
                          labelType: NavigationRailLabelType.all,
                          leading: Column(
                            children: const <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage(
                                      "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
                                ),
                              ),
                              SizedBox(
                                height: 80,
                              ),
                            ],
                          ),
                          selectedLabelTextStyle: const TextStyle(
                            color: Colors.white,
                            //Color(0xffffe6bc97),
                            fontSize: 20,
                            letterSpacing: 1,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2.5,
                          ),
                          unselectedLabelTextStyle: const TextStyle(
                            fontSize: 15,
                            letterSpacing: 0.8,
                          ),
                          destinations: [
                            buildRotatedTextRailDestination('Addidas', padding),
                            buildRotatedTextRailDestination("Apple", padding),
                            buildRotatedTextRailDestination("Dell", padding),
                            buildRotatedTextRailDestination("H&M", padding),
                            buildRotatedTextRailDestination("Nike", padding),
                            buildRotatedTextRailDestination("Samsung", padding),
                            buildRotatedTextRailDestination("Huawei", padding),
                            buildRotatedTextRailDestination("All", padding),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView.builder(
                        itemCount: cubit.prand_feed.length,
                        itemBuilder: (context, index) =>
                            BrandNavigationRailScreen(context, index),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  NavigationRailDestination buildRotatedTextRailDestination(
      String text, padding) {
    return NavigationRailDestination(
      icon: const SizedBox.shrink(),
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: RotatedBox(
          quarterTurns: -1,
          child: Text(text),
        ),
      ),
    );
  }
}
