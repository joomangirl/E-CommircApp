// @dart=2.9

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/modules/wishList/wishlist_empty.dart';
import 'package:faster/modules/wishList/wishlist_full.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WishList extends StatelessWidget {
  const WishList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return cubit.wishListItem.isEmpty
            ? const Scaffold(body: WishListEmpty())
            : Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: cubit.wishListItem.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return fullWish(
                          context,
                          cubit.wishListItem.values.toList()[index].id,
                          cubit.wishListItem.values.toList()[index].imageUrl,
                          cubit.wishListItem.values.toList()[index].title,
                          cubit.wishListItem.values
                              .toList()[index]
                              .price
                              .toString(), () {
                        showDialogAlairt(
                            context, 'Remove Item', 'Are you shore to remove ',
                            () {
                          cubit.removeWishListItem(
                              cubit.wishListItem.values.toList()[index].id);
                          Navigator.pop(context);
                        });
                      });
                    },
                  ),
                ),
                appBar: AppBar(
                  title: const Text('Wishlist ()'),
                  actions: [
                    IconButton(
                      onPressed: () {
                        showDialogAlairt(context, 'Remove items!',
                            'All Items will be removed !', () {
                          HomeCubit.get(context).deletWishLists();
                          Navigator.pop(context);
                        });
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
              );
      },
    );
  }
}
