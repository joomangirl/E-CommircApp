// @dart=2.9
// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/modules/details/details.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';



Widget PopularProducts(context, index) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(
              10.0,
            ),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(
                10.0,
              ),
              bottomRight: Radius.circular(10.0),
            ),
            onTap: () {
              navigateTo(
                  context,
                  DetailsProducts(
                    context: context,
                    id: HomeCubit.get(context).popularPruducts[index].id,
                    categoryIndex: index,
                    imageUrl:
                        HomeCubit.get(context).popularPruducts[index].imageUrl,
                    title: HomeCubit.get(context).popularPruducts[index].title,
                    prise: HomeCubit.get(context).popularPruducts[index].price,
                    description: HomeCubit.get(context)
                        .popularPruducts[index]
                        .description,
                    brandName:
                        HomeCubit.get(context).popularPruducts[index].brand,
                    quantityValue: HomeCubit.get(context)
                        .popularPruducts[index]
                        .quantity
                        .toString(),
                    categoryName: HomeCubit.get(context)
                        .popularPruducts[index]
                        .productCategoryName,
                    popularityState: HomeCubit.get(context)
                        .popularPruducts[index]
                        .isPopular
                        .toString(),
                    addToCart: () {
                      HomeCubit.get(context).addProductToCart(
                          HomeCubit.get(context).popularPruducts[index].id,
                          HomeCubit.get(context).popularPruducts[index].price,
                          HomeCubit.get(context).popularPruducts[index].title,
                          HomeCubit.get(context).popularPruducts[index].imageUrl,
                          HomeCubit.get(context).popularPruducts[index].brand,
                          HomeCubit.get(context).popularPruducts[index].productCategoryName,
                          HomeCubit.get(context).popularPruducts[index].description,




                      );
                    },
                  ));
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    // Container(
                    //   height: 170,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: NetworkImage(HomeCubit.get(context)
                    //               .popularPruducts[index]
                    //               .imageUrl),
                    //           fit: BoxFit.contain)),
                    // ),
                    Positioned(
                      right: 5,
                      top: 2,
                      child: IconButton(
                        onPressed: () {
                          HomeCubit.get(context).addProductToWishList(
                              HomeCubit.get(context).popularPruducts[index].id,
                              HomeCubit.get(context)
                                  .popularPruducts[index]
                                  .price,
                              HomeCubit.get(context)
                                  .popularPruducts[index]
                                  .title,
                              HomeCubit.get(context)
                                  .popularPruducts[index]
                                  .imageUrl);
                        },
                        icon: const Icon(Entypo.star_outlined),
                        color: HomeCubit.get(context).wishListItem.containsKey(
                                HomeCubit.get(context)
                                    .popularPruducts[index]
                                    .id)
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 32.0,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          '\$ ${HomeCubit.get(context).popularPruducts[index].price}',
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        HomeCubit.get(context).popularPruducts[index].title,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              HomeCubit.get(context)
                                  .popularPruducts[index]
                                  .description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: HomeCubit.get(context)
                                      .cartItems
                                      .containsKey(HomeCubit.get(context)
                                          .popularPruducts[index]
                                          .id)
                                  ? () {}
                                  : () {
                                      HomeCubit.get(context).addProductToCart(
                                          HomeCubit.get(context)
                                              .popularPruducts[index]
                                              .id,
                                          HomeCubit.get(context)
                                              .popularPruducts[index]
                                              .price,
                                          HomeCubit.get(context)
                                              .popularPruducts[index]
                                              .title,
                                          HomeCubit.get(context)
                                              .popularPruducts[index]
                                              .imageUrl,
                                        HomeCubit.get(context)
                                            .popularPruducts[index]
                                            .brand,
                                        HomeCubit.get(context)
                                            .popularPruducts[index]
                                            .productCategoryName,
                                        HomeCubit.get(context)
                                            .popularPruducts[index]
                                            .description,


                                      );
                                    },
                              borderRadius: BorderRadius.circular(30.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  HomeCubit.get(context).cartItems.containsKey(
                                          HomeCubit.get(context)
                                              .popularPruducts[index]
                                              .id)
                                      ? MaterialCommunityIcons.check_all
                                      : MaterialCommunityIcons.cart_plus,
                                  size: 25,
                                  color: HomeCubit.get(context)
                                          .cartItems
                                          .containsKey(HomeCubit.get(context)
                                              .popularPruducts[index]
                                              .id)
                                      ? Colors.green
                                      : Colors.black,
                                ),
                              ),
                            ),
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
