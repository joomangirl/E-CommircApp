// @dart=2.9

// ignore_for_file: deprecated_member_use

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/modules/details/details.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'cart_empty.dart';

class Cart extends StatelessWidget {
  const Cart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomePaymentSuccessState) {
          showToast(text: 'Success', state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return cubit.cartItems.isEmpty
            ? const Scaffold(
                body: Cart_Empty(),
              )
            : Scaffold(
                body: Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return cartWidget(
                            context,
                            cubit.cartItems.values.toList()[index].productId,
                            cubit.cartItems.values.toList()[index].price,
                            cubit.cartItems.values.toList()[index].quantity,
                            cubit.cartItems.values.toList()[index].title,
                            cubit.cartItems.values.toList()[index].imageUrl,
                            cubit.cartItems.values.toList()[index].brand,
                            cubit.cartItems.values.toList()[index].category,
                            cubit.cartItems.values.toList()[index].description,
                            (){
                              navigateTo(
                                  context,
                                  DetailsProducts(
                                    context: context,
                                    id: cubit.cartItems.values.toList()[index].productId,
                                    categoryIndex: index,
                                    imageUrl: cubit.cartItems.values.toList()[index].imageUrl,
                                    title: cubit.cartItems.values.toList()[index].title,
                                    prise: cubit.cartItems.values.toList()[index].price,
                                    description: cubit.cartItems.values.toList()[index].category,
                                    brandName: cubit.cartItems.values.toList()[index].brand,
                                    quantityValue: cubit.cartItems.values.toList()[index].quantity.toString(),
                                    categoryName: cubit.cartItems.values.toList()[index].description,
                                    popularityState: HomeCubit.get(context).products[index].isPopular.toString(),
                                    addToCart: () {
                                      HomeCubit.get(context).addProductToCart(
                                          cubit.cartItems.values.toList()[index].productId,
                                        cubit.cartItems.values.toList()[index].price,
                                        cubit.cartItems.values.toList()[index].title,
                                        cubit.cartItems.values.toList()[index].imageUrl,
                                        cubit.cartItems.values.toList()[index].brand,
                                          cubit.cartItems.values.toList()[index].category,
                                          cubit.cartItems.values.toList()[index].description,



                                      );
                                    },
                                  )





                              );


                            }
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ),
                      itemCount: cubit.cartItems.length),
                ),
                appBar: AppBar(
                  backgroundColor: Theme.of(context).cardColor,
                  title:
                      Text('Cart (${HomeCubit.get(context).cartItems.length})'),
                  actions: [
                    IconButton(
                      onPressed: () {
                        showDialogAlairt(context, 'Remove items!',
                            'All products will be removed from the cart!', () {
                          HomeCubit.get(context).deletCarts();
                          Navigator.pop(context);
                        });
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
                bottomSheet: state is HomePaymentLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 70),
                        child: checkoutSection(
                            context, HomeCubit.get(context).totalAmount, () {
                          double amountInCents =
                              HomeCubit.get(context).totalAmount * 1000;
                          int intengerAmount = (amountInCents / 10).ceil();
                          HomeCubit.get(context)
                              .payWithCard(amount: intengerAmount);
                        }),
                      ),
              );
      },
    );
  }

  Widget cartWidget(context, String id, double price, int quantity,
          String title, String imageUrl,String brand,String category,String description,Function ontap
      ) {
    return InkWell(
        onTap: ontap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: HomeCubit.get(context).isDarkTheme == false
                      ? Colors.white
                      : ColorsConst.backgroundColor,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              topLeft: Radius.circular(16.0)),
                          image: DecorationImage(
                              image: NetworkImage(
                                imageUrl,
                              ),
                              fit: BoxFit.contain)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(32.0),
                                  onTap: () {
                                    showDialogAlairt(context, 'Remove item!',
                                        'Product will be removed from the cart!',
                                        () {
                                      HomeCubit.get(context).removeCartItem(id);
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      Entypo.cross,
                                      color: Colors.red,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Price: ',
                                style: TextStyle(color: Colors.black),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '$price\$',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: HomeCubit.get(context).isDarkTheme ==
                                            false
                                        ? Colors.brown.shade900
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Sub Total:',
                                style: TextStyle(color: Colors.black),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              FittedBox(
                                child: Text(
                                  '${HomeCubit.get(context).subTotal(price, quantity).toStringAsFixed(2)}\$',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: HomeCubit.get(context).isDarkTheme ==
                                              false
                                          ? Colors.brown.shade900
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Ships Free',
                                style: TextStyle(
                                    color: HomeCubit.get(context).isDarkTheme ==
                                            false
                                        ? Colors.brown.shade900
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                              const Spacer(),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(4.0),
                                  onTap: () {
                                    if (quantity < 2) {
                                      () {};
                                    } else {
                                      HomeCubit.get(context).MinseCartQuantity(
                                          id, price, title, imageUrl);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    child: const Icon(
                                      Entypo.minus,
                                      color: Colors.red,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 12,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.12,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      ColorsConst.gradiendLStart,
                                      ColorsConst.gradiendLEnd,
                                    ], stops: const [
                                      0.0,
                                      0.7
                                    ]),
                                  ),
                                  child: Text(
                                    quantity.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(4.0),
                                  onTap: () {
                                    HomeCubit.get(context).addProductToCart(
                                        id, price, title, imageUrl,brand,category,description);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    child: const Icon(
                                      Entypo.plus,
                                      color: Colors.green,
                                      size: 22,
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
          ],
        ),
      );
  }

  Widget checkoutSection(context, double total, Function onTap) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [
                    ColorsConst.gradiendLStart,
                    ColorsConst.gradiendLEnd,
                  ], stops: const [
                    0.0,
                    0.7
                  ]),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Checkout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              'Total: ',
              style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'US ${total.toStringAsFixed(2)}',
              //${HomeCubit.get(context).totalAmount},
              //textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
