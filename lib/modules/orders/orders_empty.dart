// ignore_for_file: deprecated_member_use, camel_case_types, import_of_legacy_library_into_null_safe


import 'package:faster/modules/feeds/feeds.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:flutter/material.dart';




class Orders_Empty extends StatelessWidget {
  const Orders_Empty({Key? key}) : super(key: key);

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
            fit: BoxFit.fitHeight,
            image: NetworkImage('https://image.flaticon.com/icons/png/128/3759/3759041.png',),
          )),
        ),
        Text(
          'Your Orders Is Empty',
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontSize: 36,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Looks Like You did\'t \n add anything to your orders yet',
          style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontSize: 26,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
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
              'shop now'.toUpperCase(),
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
