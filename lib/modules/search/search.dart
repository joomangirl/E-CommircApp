// @dart=2.9

// ignore_for_file: must_be_immutable

import 'package:badges/badges.dart';
import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/modules/cart/cart.dart';
import 'package:faster/modules/feeds/feed_product.dart';
import 'package:faster/modules/user_info/user_info.dart';
import 'package:faster/modules/wishList/wishlist.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';
import 'package:faster/styles/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Search extends StatelessWidget {
  ScrollController scrollController;
  TextEditingController txtSearch = TextEditingController();
  final FocusNode _node = FocusNode();
  var top = 0.0;

  Search({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    // leading: Icon(Icons.ac_unit_outlined),
                    // automaticallyImplyLeading: false,
                    expandedHeight: 200,
                    centerTitle: true,

                    elevation: 0,
                    pinned: true,
                    flexibleSpace: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;

                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            ColorsConst.starterColor,
                            ColorsConst.endColor,
                          ], stops: const [
                            0.0,
                            0.7
                          ]),
                        ),
                        child: FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: top <= 110.0 ? 1.0 : 0,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: kToolbarHeight / 1.8,
                                  width: kToolbarHeight / 1.8,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Guest',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          background: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Positioned(
                                top: 30,
                                right: 10,
                                child: Badge(
                                  badgeColor: ColorsConst.cartBadgeColor,
                                  animationType: BadgeAnimationType.slide,
                                  toAnimate: true,
                                  position:
                                      BadgePosition.topEnd(top: 5, end: 7),
                                  badgeContent: Text(
                                    HomeCubit.get(context)
                                        .cartItems
                                        .length
                                        .toString(),
                                    style: TextStyle(color: ColorsConst.white),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        // addToCart();
                                        navigateTo(context, const Cart());
                                      },
                                      icon: Icon(
                                        MyAppIcons.cart,
                                        color: ColorsConst.cartColor,
                                      )),
                                ),
                              ),
                              Positioned(
                                top: 30,
                                right: 50,
                                child: Badge(
                                  badgeColor: ColorsConst.cartBadgeColor,
                                  animationType: BadgeAnimationType.slide,
                                  toAnimate: true,
                                  position:
                                      BadgePosition.topEnd(top: 5, end: 7),
                                  badgeContent: Text(
                                    HomeCubit.get(context)
                                        .wishListItem
                                        .length
                                        .toString(),
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
                              ),
                              Positioned(
                                top: 35,
                                left: 10,
                                child: Material(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.shade300,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10.0),
                                    splashColor: Colors.grey,
                                    onTap: () =>
                                        navigateTo(context, User_Info()),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                              'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -10,
                                left: 130,
                                child: Text(
                                  "Search",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorsConst.title,
                                    fontSize: 35,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextFormField(
                                  controller: txtSearch,
                                  minLines: 1,
                                  focusNode: _node,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                    ),
                                    hintText: 'Search',
                                    filled: true,
                                    fillColor: Theme.of(context).cardColor,
                                    suffixIcon: IconButton(
                                      onPressed: txtSearch.text.isEmpty
                                          ? null
                                          : () {
                                              txtSearch.clear();
                                              _node.unfocus();
                                            },
                                      icon: Icon(Feather.x,
                                          color: txtSearch.text.isNotEmpty
                                              ? Colors.red
                                              : Colors.grey),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    //  txtSearch.text.toLowerCase();
                                    cubit.getSearchFeed(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        txtSearch.text.isNotEmpty && cubit.searchList.isEmpty
                            ? Center(
                                child: Column(
                                  children: const [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Icon(
                                      Feather.search,
                                      size: 60,
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text(
                                      'No results found',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  childAspectRatio: 240 / 500,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  children: List.generate(
                                      txtSearch.text.isEmpty
                                          ? cubit.products.length
                                          : cubit.searchList.length, (index) {
                                    return product_feed(
                                        context,
                                        txtSearch.text.isEmpty
                                            ? index
                                            : cubit.products.indexWhere(
                                                (element) =>
                                                    element.id ==
                                                    cubit.searchList[index].id),
                                        txtSearch.text.isEmpty
                                            ? cubit.products[index].id
                                            : cubit.searchList[index].id);
                                    //   ChangeNotifierProvider.value(
                                    //   value: txtSearch.text.isEmpty
                                    //       ? productsList[index]
                                    //       : cubit.searchList[index],
                                    //   child: product_feed(),
                                    // );
                                  }),
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
