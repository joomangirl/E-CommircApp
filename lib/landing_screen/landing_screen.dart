// @dart=2.9

// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/modules/login/login_screen.dart';
import 'package:faster/modules/sign%20up/signup_screen.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  List<String> images = [
    'https://media.istockphoto.com/photos/man-at-the-shopping-picture-id868718238?k=6&m=868718238&s=612x612&w=0&h=ZUPCx8Us3fGhnSOlecWIZ68y3H4rCiTnANtnjHk0bvo=',
    'https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F1138257321%2F0x0.jpg%3Ffit%3Dscale',
    'https://e-shopy.org/wp-content/uploads/2020/08/shop.jpeg',
    'https://e-shopy.org/wp-content/uploads/2020/08/shop.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    images.shuffle();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              animationController.reset();
              animationController.forward();
            }
          });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GoogleSignInSuccessState) {
          showToast(text: 'Success SignIn', state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: images[1],
              // placeholder: (context, url) => Image.network(
              //   'https://image.flaticon.com/icons/png/128/564/564619.png',
              //   fit: BoxFit.contain,
              // ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                size: 20,
              ),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: FractionalOffset(animation.value, 0),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Welcome to the biggest online store',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: ColorsConst.backgroundColor))),
                          ),
                          onPressed: () {
                            navigateWithoutBack(context, const LoginScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Feather.user,
                                size: 18,
                              )
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.pink.shade400),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: ColorsConst.backgroundColor))),
                          ),
                          onPressed: () {
                            navigateTo(context, const SignUp_Screen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Feather.user_plus,
                                size: 18,
                              )
                            ],
                          )),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                    ),
                    Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    state is GoogleSignInLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : OutlineButton(
                            shape: const StadiumBorder(),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                            highlightedBorderColor: Colors.red.shade200,
                            onPressed: () {
                              HomeCubit.get(context).signInWithGoogle(context);
                            },
                            child: const Text(
                              'Google +',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                    state is SignInAnonymouslyLoadingState
                        ? const CircularProgressIndicator()
                        : OutlineButton(
                            shape: const StadiumBorder(),
                            borderSide: const BorderSide(
                                color: Colors.deepPurple, width: 2),
                            highlightedBorderColor: Colors.deepPurple.shade200,
                            onPressed: () {
                              HomeCubit.get(context).signInAnonymously(context);
                              HomeCubit.get(context).getProductsData();
                            },
                            child: const Text('Sign in as a guest',
                                style: TextStyle(color: Colors.white)),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            )
          ],
        ));
      },
    );
  }
}
