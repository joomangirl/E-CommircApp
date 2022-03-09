// @dart=2.9
import 'package:badges/badges.dart';
import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/modules/wishList/wishlist.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';
import 'package:faster/styles/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feed_product.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      // if (state is GetProductDataSuccessState){
      //   HomeCubit.get(context).getProductsData();
      // }
    }, builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            title: const Text(
              'Feeds',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Badge(
                badgeColor: ColorsConst.cartBadgeColor,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  HomeCubit.get(context).wishListItem.length.toString(),
                  style: TextStyle(color: ColorsConst.white),
                ),
                child: IconButton(
                    onPressed: () {
                      // HomeCubit.get(context)
                      //     .addProductToWishList(id, prise, title, imageUrl);
                      navigateTo(context, const WishList());
                    },
                    icon: Icon(
                      MyAppIcons.wishlist,
                      // HomeCubit.get(context).wishListItem.containsKey(id)
                      //     ? Icons.favorite
                      //     : MyAppIcons.wishlist,
                      color: ColorsConst.favColor,
                    )),
              ),
              Badge(
                badgeColor: ColorsConst.cartBadgeColor,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  HomeCubit.get(context).cartItems.length.toString(),
                  style: TextStyle(color: ColorsConst.white),
                ),
                child: IconButton(
                    onPressed: () {
                      // addToCart();
                      HomeCubit.get(context).changecurrentIndex(3);
                    },
                    icon: Icon(
                      MyAppIcons.cart,
                      color: ColorsConst.cartColor,
                    )),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 240 / 480,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: List.generate(
                  HomeCubit.get(context).products.length,
                  (index) => product_feed(context, index,
                      HomeCubit.get(context).products[index].id)),
            ),
          ));
    });
  }
}
