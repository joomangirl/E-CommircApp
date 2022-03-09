// @dart=2.9

import 'package:faster/styles/colors.dart';
import 'package:flutter/material.dart';

Widget fullWish(context, String id, String imageUrl, String title, String price,
        Function clos) =>
    Container(
      margin: const EdgeInsets.only(right: 30.0, bottom: 10.0),
      width: double.infinity,
      height: 100,
      child: Material(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        elevation: 3.0,
        child: Stack(
          //alignment: Alignment.topRight,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    height: 80,
                    child: Image.network(
                      imageUrl,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 7.0,
                        ),
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Expanded(
                          child: Text(
                            "\$ $price",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            cancelButton(clos)
          ],
        ),
      ),
    );

Positioned cancelButton(Function fuc) => Positioned(
      top: 0,
      right: 0,
      child: SizedBox(
        height: 30,
        width: 30,
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: const EdgeInsets.all(0.0),
          color: ColorsConst.favColor,
          child: const Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: fuc,
        ),
      ),
    );
