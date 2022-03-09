// @dart=2.9
// ignore_for_file: must_be_immutable

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/modules/cart/cart.dart';
import 'package:faster/modules/feeds/feeds.dart';
import 'package:faster/modules/upload_product/upload_product.dart';
import 'package:faster/modules/user_info/user_info.dart';
import 'package:faster/modules/wishList/wishlist.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';
import 'package:faster/styles/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackLayerMenu extends StatelessWidget {
  BackLayerMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Stack(
            fit: StackFit.expand,
            children: [
              Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        ColorsConst.starterColor,
                        ColorsConst.endColor,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
              Positioned(
                top: -100.0,
                left: 140.0,
                child: Transform.rotate(
                  angle: -0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    width: 150,
                    height: 250,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 100.0,
                child: Transform.rotate(
                  angle: -0.8,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    width: 150,
                    height: 300,
                  ),
                ),
              ),
              Positioned(
                top: -50.0,
                left: 60.0,
                child: Transform.rotate(
                  angle: -0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    width: 150,
                    height: 200,
                  ),
                ),
              ),
              Positioned(
                bottom: 10.0,
                right: 0.0,
                child: Transform.rotate(
                  angle: -0.8,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    width: 150,
                    height: 200,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: InkWell(
                            onTap: () => navigateTo(context, User_Info()),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: HomeCubit.get(context).imageUrl ==
                                            null
                                        ? NetworkImage(cubit.image ??
                                            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg')
                                        : NetworkImage(cubit.imageUrl),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      content(context, () {
                        navigateTo(context, const Feeds());
                      }, 'Feeds', 0),
                      const SizedBox(height: 10.0),
                      content(context, () {
                        navigateTo(context, const Cart());
                      }, 'Cart', 1),
                      const SizedBox(height: 10.0),
                      content(context, () {
                        navigateTo(context, const WishList());
                      }, 'Wishlist', 2),
                      const SizedBox(height: 10.0),
                      content(context, () {
                        navigateTo(context, const UploadProductForm());
                      }, 'Upload a new product', 3),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        listener: (context, state) {});
  }

  final List _contentIcons = [
    MyAppIcons.rss,
    MyAppIcons.bag,
    MyAppIcons.wishlist,
    MyAppIcons.upload
  ];

  Widget content(BuildContext ctx, Function fct, String text, int index) {
    return InkWell(
      onTap: fct,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(_contentIcons[index])
        ],
      ),
    );
  }
}
