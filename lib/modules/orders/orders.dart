// @dart=2.9

// ignore_for_file: deprecated_member_use

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'orders_empty.dart';

class Orders extends StatelessWidget {
  const Orders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        //   if (state is HomePaymentSuccessState) {
        //     showToast(text: 'Success', state: ToastState.SUCCESS);
        //   }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return cubit.orderItems.isEmpty
            ? const Scaffold(
          body: Orders_Empty(),
        )
            : Scaffold(
          body: Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return orderWidget(
                    context,
                    index,
                    //cubit.orderItems[index].orderId,
                  );
                },
                separatorBuilder: (context, index) =>
                const SizedBox(
                  height: 5,
                ),
                itemCount: cubit.orderItems.length),
          ),
          appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .cardColor,
            title: Text(
                'Orders (${HomeCubit
                    .get(context)
                    .orderItems
                    .length})'),
            actions: [
              IconButton(
                onPressed: () {
                  showDialogAlairt(context, 'Remove items!',
                      'All products will be removed from the orders!',
                          () {
                        HomeCubit.get(context).deletOrders();
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

  Widget orderWidget(context,
      index,) =>
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: HomeCubit
                    .get(context)
                    .isDarkTheme == false
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
                              HomeCubit
                                  .get(context)
                                  .orderItems[index].imageUrl,
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
                                HomeCubit
                                    .get(context)
                                    .orderItems[index].title,
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
                                      'Product will be removed from the orders!',
                                          () {
                                        HomeCubit.get(context).removeOrderItem(
                                            HomeCubit
                                                .get(context)
                                                .orderItems[index]
                                                .orderId);
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
                              '${HomeCubit
                                  .get(context)
                                  .orderItems[index].price}\$',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: HomeCubit
                                      .get(context)
                                      .isDarkTheme ==
                                      false
                                      ? Colors.brown.shade900
                                      : Theme
                                      .of(context)
                                      .colorScheme
                                      .secondary),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Quantity: ',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'x${HomeCubit
                                  .get(context)
                                  .orderItems[index].quantity}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: HomeCubit
                                      .get(context)
                                      .isDarkTheme ==
                                      false
                                      ? Colors.brown.shade900
                                      : Theme
                                      .of(context)
                                      .colorScheme
                                      .secondary),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Date: ',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${HomeCubit
                                  .get(context)
                                  .orderItems[index].orderDate
                                  .toDate()
                                  .year}-'
                                  '${HomeCubit
                                  .get(context)
                                  .orderItems[index].orderDate
                                  .toDate()
                                  .month}-'
                                  '${HomeCubit
                                  .get(context)
                                  .orderItems[index].orderDate
                                  .toDate()
                                  .day}/'
                                  '${HomeCubit
                                  .get(context)
                                  .orderItems[index].orderDate
                                  .toDate()
                                  .hour}:'
                                  '${HomeCubit
                                  .get(context)
                                  .orderItems[index].orderDate
                                  .toDate()
                                  .minute}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: HomeCubit
                                      .get(context)
                                      .isDarkTheme ==
                                      false
                                      ? Colors.brown.shade900
                                      : Theme
                                      .of(context)
                                      .colorScheme
                                      .secondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
}
