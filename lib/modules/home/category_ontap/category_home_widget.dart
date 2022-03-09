// @dart=2.9
// ignore_for_file: deprecated_member_use

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:flutter/material.dart';

import 'category_feed.dart';

Widget category(index, context) {
  return InkWell(
    onTap: () {
      HomeCubit.get(context).getCategoryFeed(
          HomeCubit.get(context).categories[index]['categoryName']);
      navigateTo(context, const Feeds_Category());
    },
    child: Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(
                      HomeCubit.get(context).categories[index]
                          ['categoryImagesPath'],
                    ),
                    fit: BoxFit.cover)),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Theme.of(context).backgroundColor,
            child: Text(
              HomeCubit.get(context).categories[index]['categoryName'],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Theme.of(context).textSelectionColor,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
