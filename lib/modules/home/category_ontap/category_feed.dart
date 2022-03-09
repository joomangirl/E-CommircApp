// @dart=2.9
// ignore_for_file: camel_case_types

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'category_widget_feed.dart';



class Feeds_Category extends StatelessWidget {
  const Feeds_Category({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Feeds Items Count'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 480,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: List.generate(HomeCubit.get(context).category_feed.length,
                    (index) => CategoryProductFeed(context, index)),
          ),
        ));
  }
}
