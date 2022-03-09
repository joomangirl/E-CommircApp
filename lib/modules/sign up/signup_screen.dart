// @dart=2.9

// ignore_for_file: camel_case_types

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/home_layout/home_layout.dart';
import 'package:faster/modules/main_screen/main_screen.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignUp_Screen extends StatelessWidget {
  const SignUp_Screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is SignUpSuccessState) {
        showToast(text: 'Success SignUp', state: ToastState.SUCCESS);
        navigateTo(context, const Main_Screen());
      }
    }, builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.95,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: WaveWidget(
                    config: CustomConfig(
                      gradients: [
                        [
                          ColorsConst.gradiendFStart,
                          ColorsConst.gradiendLStart
                        ],
                        [ColorsConst.gradiendFEnd, ColorsConst.gradiendLEnd],
                      ],
                      durations: [19440, 10800],
                      heightPercentages: [0.20, 0.25],
                      blur: const MaskFilter.blur(BlurStyle.solid, 10),
                      gradientBegin: Alignment.bottomLeft,
                      gradientEnd: Alignment.topRight,
                    ),
                    waveAmplitude: 0,
                    size: const Size(
                      double.infinity,
                      double.infinity,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 30),
                        child: CircleAvatar(
                          radius: 68,
                          backgroundColor: ColorsConst.gradiendLEnd,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: ColorsConst.gradiendFEnd,
                            backgroundImage: cubit.finalPickedImage == null
                                ? null
                                : FileImage(cubit.finalPickedImage),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 120,
                          left: 120,
                          child: RawMaterialButton(
                            elevation: 10,
                            fillColor: ColorsConst.gradiendLEnd,
                            child: const Icon(Icons.add_a_photo),
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Hero(
                                      tag: 'picked image',
                                      child: AlertDialog(
                                        title: Text(
                                          'Choose Option',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  ColorsConst.gradiendLStart),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  cubit
                                                      .pickImageCamera(context);
                                                },
                                                splashColor:
                                                    Colors.purpleAccent,
                                                child: Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.camera,
                                                        color:
                                                            Colors.purpleAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Camera',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorsConst
                                                              .title),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  cubit.pickImageGallery(
                                                      context);
                                                },
                                                splashColor:
                                                    Colors.purpleAccent,
                                                child: Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.image,
                                                        color:
                                                            Colors.purpleAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Gallery',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorsConst
                                                              .title),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  cubit.removeImage(context);
                                                },
                                                splashColor:
                                                    Colors.purpleAccent,
                                                child: Row(
                                                  children: const [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.remove_circle,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Remove',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.red),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ))
                    ],
                  ),
                  Form(
                    key: cubit.SignUp_formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: const ValueKey('full name'),
                            focusNode: cubit.SignUpFullNameFocusNode,
                            controller: cubit.txtSignUpFullNameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a valid full name';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: const Icon(Icons.person),
                                labelText: 'Full Name',
                                fillColor: Theme.of(context).backgroundColor),
                            // onSaved: (value) {
                            //   _emailAddress = value;
                            // },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: const ValueKey('email'),
                            focusNode: cubit.SignUpEmailFocusNode,
                            controller: cubit.txtSignUpEmailController,
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            // onEditingComplete: () =>
                            //     FocusScope.of(context)
                            //         .requestFocus(_passwordFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: const Icon(Icons.email),
                                labelText: 'Email Address',
                                fillColor: Theme.of(context).backgroundColor),
                            // onSaved: (value) {
                            //   _emailAddress = value;
                            // },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: const ValueKey('Password'),
                            focusNode: cubit.SignUpPasswordFocusNode,
                            controller: cubit.txtSignUpPassController,
                            validator: (value) {
                              if (value.isEmpty || value.length < 7) {
                                return 'Please enter a valid Password';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            //focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () => cubit.HiddenPassword(),
                                  icon: Icon(cubit.icon),
                                ),
                                labelText: 'Password',
                                fillColor: Theme.of(context).backgroundColor),
                            // onSaved: (value) {
                            //   _password = value;
                            // },
                            obscureText: cubit.isHidden,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: const ValueKey('phone'),
                            focusNode: cubit.SignUpPhoneFocusNode,
                            controller: cubit.txtSignUpPhoneController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a valid phone';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.done,

                            keyboardType: TextInputType.phone,
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();

                              if (cubit.SignUp_formKey.currentState
                                  .validate()) {
                                cubit.SignUp_formKey.currentState.save();
                                navigateWithoutBack(
                                    context, const HomeLayout());
                              }
                            },
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: const Icon(Icons.phone_android),
                                labelText: 'Phone',
                                fillColor: Theme.of(context).backgroundColor),
                            // onSaved: (value) {
                            //   _emailAddress = value;
                            // },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(width: 10),
                            state is SignUpLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color:
                                                ColorsConst.backgroundColor),
                                      ),
                                    )),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();

                                      if (cubit.SignUp_formKey.currentState
                                          .validate()) {
                                        cubit.SignUp_formKey.currentState
                                            .save();
                                        cubit.signUp(context);
                                        //   navigateWithoutBack(
                                        //       context, LoginScreen());
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
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
                            const SizedBox(width: 20),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
