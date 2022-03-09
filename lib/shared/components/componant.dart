// @dart=2.9

// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigateWithoutBack(context, widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => widget));
}

Widget defultTextFormField(
    {@required TextEditingController controller,
    @required TextInputType type,
    @required String label,
    @required IconData prefix,
    @required Function validate,
    IconData suffix,
    bool isPassword = false,
    Function onchange,
    Function onSubmit,
    Function hidden,
    Function onTap,
    Function onSave,
    Color fillColor,
    TextInputAction textInputAction}) {
  return TextFormField(
    onChanged: onchange,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    validator: validate,
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    //textInputAction: textInputAction,
    //  onSaved: onSave,
    decoration: InputDecoration(
      labelText: label,
      border: const UnderlineInputBorder(),
      prefixIcon: Icon(prefix),
      filled: true,
      fillColor: fillColor,
      suffixIcon: suffix != null
          ? IconButton(
              icon: Icon(suffix),
              onPressed: hidden,
            )
          : null,
    ),
  );
}

Widget buildButton({
  double width = double.infinity,
  Color color = Colors.blue,
  bool isUppercase = true,
  double radius = 20.0,
  @required Function onPress,
  @required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: onPress,
        child: Text(
          isUppercase ? text.toUpperCase() : text.toLowerCase(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
    );

void showToast({
  @required String text,
  @required ToastState state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;

  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.yellow;
      break;
  }

  return color;
}

void showDialogAlairt(context, String title, String subtitle, Function fuc) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Image.network(
                  'https://image.flaticon.com/icons/png/128/564/564619.png',
                  height: 20,
                  width: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title),
              )
            ],
          ),
          content: Text(subtitle),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            TextButton(onPressed: fuc, child: const Text('Ok')),
          ],
        );
      });
}
