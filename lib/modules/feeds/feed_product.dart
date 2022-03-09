// @dart=2.9
// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:badges/badges.dart';
import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/modules/details/details.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';
import 'package:faster/styles/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

Widget product_feed(context, index, String id) => Padding(
      padding: const EdgeInsets.all(0.8),
      child: InkWell(
        onTap: () {
          navigateTo(
              context,
              DetailsProducts(
                context: context,
                id: HomeCubit.get(context).products[index].id,
                categoryIndex: index,
                imageUrl: HomeCubit.get(context).products[index].imageUrl,
                title: HomeCubit.get(context).products[index].title,
                prise: HomeCubit.get(context).products[index].price,
                description: HomeCubit.get(context).products[index].description,
                brandName: HomeCubit.get(context).products[index].brand,
                quantityValue:
                    HomeCubit.get(context).products[index].quantity.toString(),
                categoryName:
                    HomeCubit.get(context).products[index].productCategoryName,
                popularityState:
                    HomeCubit.get(context).products[index].isPopular.toString(),
                addToCart: () {
                  HomeCubit.get(context).addProductToCart(
                    HomeCubit.get(context).products[index].id,
                    HomeCubit.get(context).products[index].price,
                    HomeCubit.get(context).products[index].title,
                    HomeCubit.get(context).products[index].imageUrl,
                    HomeCubit.get(context).products[index].brand,
                    HomeCubit.get(context).products[index].description,
                    HomeCubit.get(context).products[index].productCategoryName,
                  );
                },
              ));
        },
        child: Material(
          elevation: 5,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).backgroundColor),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Image.network(
                          HomeCubit.get(context).products[index].imageUrl,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Badge(
                      toAnimate: true,
                      shape: BadgeShape.square,
                      badgeColor: Colors.pink,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8)),
                      badgeContent: const Text('NEW',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  //margin: const EdgeInsets.only(left: 5, bottom: 2, right: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        HomeCubit.get(context).products[index].description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15,
                            color: HomeCubit.get(context).isDarkTheme == false
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '\$ ${HomeCubit.get(context).products[index].price.toString()}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 18,
                            color: HomeCubit.get(context).isDarkTheme == false
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity: ${HomeCubit.get(context).products[index].quantity}',
                            style: TextStyle(
                                fontSize: 12,
                                color:
                                    HomeCubit.get(context).isDarkTheme == false
                                        ? Colors.black
                                        : Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          FeedDialog(context, id, () {
                                            HomeCubit.get(context)
                                                .addProductToWishList(
                                                    id,
                                                    HomeCubit.get(context)
                                                        .products[index]
                                                        .price,
                                                    HomeCubit.get(context)
                                                        .products[index]
                                                        .title,
                                                    HomeCubit.get(context)
                                                        .products[index]
                                                        .imageUrl);
                                          }, () {
                                            navigateTo(
                                                context,
                                                DetailsProducts(
                                                  context: context,
                                                  id: HomeCubit.get(context)
                                                      .products[index]
                                                      .id,
                                                  categoryIndex: index,
                                                  imageUrl:
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .imageUrl,
                                                  title: HomeCubit.get(context)
                                                      .products[index]
                                                      .title,
                                                  prise: HomeCubit.get(context)
                                                      .products[index]
                                                      .price,
                                                  description:
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .description,
                                                  brandName:
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .brand,
                                                  quantityValue:
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .quantity
                                                          .toString(),
                                                  categoryName:
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .productCategoryName,
                                                  popularityState:
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .isPopular
                                                          .toString(),
                                                  addToCart: () {
                                                    HomeCubit.get(context)
                                                        .addProductToCart(
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .id,
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .price,
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .title,
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .imageUrl,
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .description,
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .productCategoryName,
                                                      HomeCubit.get(context)
                                                          .products[index]
                                                          .brand,
                                                    );
                                                  },
                                                ));
                                          }, () {
                                            HomeCubit.get(context).addProductToCart(
                                              HomeCubit.get(context).products[index].id,
                                              HomeCubit.get(context).products[index].price,
                                              HomeCubit.get(context).products[index].title,
                                              HomeCubit.get(context).products[index].imageUrl,
                                              HomeCubit.get(context).products[index].brand,
                                              HomeCubit.get(context).products[index].description,
                                              HomeCubit.get(context).products[index].productCategoryName,
                                            );
                                          },
                                              HomeCubit.get(context)
                                                  .products[index]
                                                  .imageUrl));
                                },
                                borderRadius: BorderRadius.circular(18.0),
                                child: const Icon(
                                  Icons.more_horiz_outlined,
                                  color: Colors.grey,
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

Widget FeedDialog(context, String id, Function wishFuc, Function eyeFuc,
    Function cartFuc, String imageUrl) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 1.0,
    backgroundColor: Colors.transparent,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: MediaQuery.of(context).size.height * 0.6),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Image.network(
              imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: dialogContent(context, 0, wishFuc, id),
                  ),
                  Flexible(
                    child: dialogContent(context, 1, eyeFuc, id),
                  ),
                  Flexible(
                    child: dialogContent(context, 2, cartFuc, id),
                  ),
                ]),
          ),
        ],
      ),
    ),
  );
}

Widget dialogContent(BuildContext context, int index, Function fct, String id) {
  var cubit = HomeCubit.get(context);
  List<IconData> _dialogIcons = [
    cubit.wishListItem.containsKey(id) ? Icons.favorite : Icons.favorite_border,
    Feather.eye,
    MyAppIcons.cart,
    MyAppIcons.trash,
  ];

  List<String> _texts = [
    cubit.wishListItem.containsKey(id) ? 'In wishlist' : 'Add to wishlist',
    'View product',
    cubit.cartItems.containsKey(id) ? 'In Cart ' : 'Add to cart',
  ];
  List<Color> _colors = [
    cubit.wishListItem.containsKey(id)
        ? Colors.red
        : Theme.of(context).textSelectionColor,
    Theme.of(context).textSelectionColor,
    Theme.of(context).textSelectionColor,
  ];

  return FittedBox(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: fct,
        splashColor: Colors.grey,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: ClipOval(
                  // inkwell color

                  child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Icon(
                        _dialogIcons[index],
                        color: _colors[index],
                        size: 25,
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FittedBox(
                child: Text(
                  _texts[index],
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    //  fontSize: 15,
                    color: cubit.isDarkTheme == true
                        ? Theme.of(context).disabledColor
                        : ColorsConst.subTitle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
