// @dart=2.9

// ignore_for_file: deprecated_member_use

import 'package:faster/modules/feeds/feeds.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:flutter/material.dart';

class WishListEmpty extends StatelessWidget {
  const WishListEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          margin: const EdgeInsets.only(top: 80),
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/empty-wishlist.png'),
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Your Wishlist Is Empty',
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Explore more and shortlist some items',
          style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontSize: 26,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 80,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.06,
          child: MaterialButton(
            onPressed: () {
              navigateTo(context, const Feeds());
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.red)),
            color: Colors.redAccent,
            child: Text(
              'Add a wish'.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    ));
  }
}
