// @dart=2.9

// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/modules/details/details.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:flutter/material.dart';

Widget BrandNavigationRailScreen(context, index) {
  return InkWell(
    onTap: () {
      navigateTo(
          context,
          DetailsProducts(
            context: context,
            id: HomeCubit.get(context).prand_feed[index].id,
            categoryIndex: index,
            imageUrl: HomeCubit.get(context).prand_feed[index].imageUrl,
            title: HomeCubit.get(context).prand_feed[index].title,
            prise: HomeCubit.get(context).prand_feed[index].price,
            description: HomeCubit.get(context).prand_feed[index].description,
            brandName: HomeCubit.get(context).prand_feed[index].brand,
            quantityValue:
                HomeCubit.get(context).prand_feed[index].quantity.toString(),
            categoryName:
                HomeCubit.get(context).prand_feed[index].productCategoryName,
            popularityState:
                HomeCubit.get(context).prand_feed[index].isPopular.toString(),
            addToCart: () {
              HomeCubit.get(context).addProductToCart(
                  HomeCubit.get(context).prand_feed[index].id,
                  HomeCubit.get(context).prand_feed[index].price,
                  HomeCubit.get(context).prand_feed[index].title,
                  HomeCubit.get(context).prand_feed[index].imageUrl,
                  HomeCubit.get(context).prand_feed[index].brand,
                  HomeCubit.get(context).prand_feed[index].productCategoryName,
                  HomeCubit.get(context).prand_feed[index].description,



              );
            },
          ));
    },
    child: Container(
      //color: Colors.red,
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      margin: const EdgeInsets.only(right: 20.0, bottom: 5, top: 18),
      constraints: const BoxConstraints(
          minHeight: 150, minWidth: double.infinity, maxHeight: 195),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                image: DecorationImage(
                  image: NetworkImage(
                    HomeCubit.get(context).prand_feed[index].imageUrl,
                  ),
                  fit: BoxFit.contain,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0)
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              width: 160,
              margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.5, 0.5),
                        blurRadius: 10.0)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    HomeCubit.get(context).prand_feed[index].title,
                    maxLines: 4,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textSelectionColor),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  FittedBox(
                    child: Text(
                        'US ${HomeCubit.get(context).prand_feed[index].price} \$',
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 30.0,
                        )),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                      HomeCubit.get(context)
                          .prand_feed[index]
                          .productCategoryName,
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 18.0)),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
