// @dart=2.9
// ignore_for_file: non_constant_identifier_names

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../../home_layout/cubit/cubit.dart';
import '../../../shared/components/componant.dart';
import '../../details/details.dart';





Widget CategoryProductFeed (context, index) => Padding(
  padding: const EdgeInsets.all(0.8),
  child: InkWell(
    onTap: () {

      navigateTo(context, DetailsProducts(
        context: context,
        id:HomeCubit.get(context).category_feed[index].id ,
        categoryIndex: index,
        imageUrl: HomeCubit.get(context).category_feed[index].imageUrl,
        title:HomeCubit.get(context).category_feed[index].title ,
        prise: HomeCubit.get(context).category_feed[index].price,
        description: HomeCubit.get(context).category_feed[index].description,
        brandName: HomeCubit.get(context).category_feed[index].brand,
        quantityValue: HomeCubit.get(context).category_feed[index].quantity.toString(),
        categoryName: HomeCubit.get(context).category_feed[index].productCategoryName,
        popularityState: HomeCubit.get(context).category_feed[index].isPopular.toString(),
        addToCart: (){
          HomeCubit.get(context).addProductToCart(
              HomeCubit.get(context).category_feed[index].id,
              HomeCubit.get(context).category_feed[index].price,
              HomeCubit.get(context).category_feed[index].title,
              HomeCubit.get(context).category_feed[index].imageUrl,
              HomeCubit.get(context).category_feed[index].brand,
              HomeCubit.get(context).category_feed[index].productCategoryName,
              HomeCubit.get(context).category_feed[index].description,


          );
        },




      ));
    },
    child: Material(
      elevation: 5,
      child: Container(
        height: 290,
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).backgroundColor),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                      minHeight: 100,
                    ),
                    child: Image.network(
                      HomeCubit.get(context).category_feed[index].imageUrl,
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
              margin: const EdgeInsets.only(left: 5, bottom: 2, right: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    HomeCubit.get(context).category_feed[index].description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15,
                        color: HomeCubit.get(context).isDarkTheme == false
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '\$ ${HomeCubit.get(context).category_feed[index].price.toString()}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 18,
                          color: HomeCubit.get(context).isDarkTheme == false
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity: ${HomeCubit.get(context).category_feed[index].quantity}',
                          style: TextStyle(
                              fontSize: 12,
                              color: HomeCubit.get(context).isDarkTheme ==
                                  false
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(18.0),
                              child: const Icon(
                                Icons.more_horiz_outlined,
                                color: Colors.grey,
                              )),
                        )
                      ],
                    ),
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
