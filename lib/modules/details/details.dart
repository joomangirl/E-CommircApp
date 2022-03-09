// @dart=2.9

// ignore_for_file: deprecated_member_use, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:badges/badges.dart';
import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/modules/feeds/feed_product.dart';
import 'package:faster/modules/main_screen/main_screen.dart';
import 'package:faster/modules/wishList/wishlist.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';
import 'package:faster/styles/my_icons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsProducts extends StatelessWidget {
  var context;
  var id;
  int categoryIndex;
  String imageUrl;
  String title;
  var prise;
  String description;
  String brandName;
  String quantityValue;
  String categoryName;
  String popularityState;
  Function addToCart;

  DetailsProducts(
      {Key key,
      this.context,
      this.id,
      this.categoryIndex,
      this.imageUrl,
      this.title,
      this.prise,
      this.description,
      this.brandName,
      this.quantityValue,
      this.categoryName,
      this.popularityState,
      this.addToCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: detailsBroduct(
              this.context,
              id,
              categoryIndex,
              imageUrl,
              title,
              prise,
              description,
              brandName,
              quantityValue,
              categoryName,
              popularityState,
              addToCart),
        );
      },
    );
  }

  Widget detailsBroduct(
    context,
    var id,
    int categoryIndex,
    String imageUrl,
    String title,
    var prise,
    String description,
    String brandName,
    String quantityValue,
    String categoryName,
    String popularityState,
    Function addToCart,
  ) =>
      Stack(
        //alignment: Alignment.bottomCenter,
        children: [
          Container(
            foregroundDecoration: const BoxDecoration(color: Colors.black12),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Image.network(imageUrl),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 250.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.save,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.share,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(16.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                title,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                'US \$ $prise',
                                maxLines: 2,
                                style: TextStyle(
                                    color: HomeCubit.get(context).isDarkTheme ==
                                            true
                                        ? Theme.of(context).disabledColor
                                        : ColorsConst.subTitle,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                          height: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 21.0,
                            fontWeight: FontWeight.w400,
                            color: HomeCubit.get(context).isDarkTheme == true
                                ? Theme.of(context).disabledColor
                                : ColorsConst.subTitle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                          height: 1,
                        ),
                      ),
                      details('Brand: ', brandName, context),
                      details('Quantity: ', quantityValue, context),
                      details('Category: ', categoryName, context),
                      details('Popularity: ', popularityState, context),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        height: 1,
                      ),
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).backgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No reviews yet',
                                style: TextStyle(
                                    color: Theme.of(context).textSelectionColor,
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Be the first review!',
                                style: TextStyle(
                                    color: HomeCubit.get(context).isDarkTheme ==
                                            true
                                        ? Theme.of(context).disabledColor
                                        : ColorsConst.subTitle,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1.0,
                              height: 1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Suggested category_feed:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  height: 350,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin: const EdgeInsets.only(bottom: 30),
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        product_feed(context, index, id),
                    scrollDirection: Axis.horizontal,
                    itemCount: HomeCubit.get(context).products.length < 7
                        ? HomeCubit.get(context).products.length
                        : 7,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: const Text(
                  'DETAIL',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
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
                          HomeCubit.get(context).changecurrentIndex(3);
                          navigateWithoutBack(context, const Main_Screen());
                        },
                        icon: Icon(
                          MyAppIcons.cart,
                          color: ColorsConst.cartColor,
                        )),
                  ),
                ],
              )),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 50,
                      child: MaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape:
                            const RoundedRectangleBorder(side: BorderSide.none),
                        color: Colors.redAccent.shade400,
                        onPressed:
                            HomeCubit.get(context).cartItems.containsKey(id)
                                ? () {}
                                : addToCart,
                        child: Text(
                          HomeCubit.get(context).cartItems.containsKey(id)
                              ? 'In Cart'
                              : 'Add to Cart',
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 50,
                      child: MaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape:
                            const RoundedRectangleBorder(side: BorderSide.none),
                        color: Theme.of(context).backgroundColor,
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              'buy now'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Theme.of(context).textSelectionColor),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.payment,
                              color: Colors.green.shade700,
                              size: 19,
                            )
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 50,
                      color: HomeCubit.get(context).isDarkTheme == true
                          ? Theme.of(context).disabledColor
                          : ColorsConst.subTitle,
                      child: InkWell(
                        splashColor: ColorsConst.favColor,
                        onTap: () {
                          HomeCubit.get(context)
                              .addProductToWishList(id, prise, title, imageUrl);
                        },
                        child: Center(
                          child: HomeCubit.get(context)
                                  .wishListItem
                                  .containsKey(id)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  MyAppIcons.wishlist,
                                  color: ColorsConst.white,
                                ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      );

  Widget details(
    String title,
    String info,
    context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 16.0, right: 16.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontSize: 21.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            info,
            style: TextStyle(
              color: HomeCubit.get(context).isDarkTheme
                  ? Theme.of(context).disabledColor
                  : ColorsConst.subTitle,
              fontSize: 21.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
