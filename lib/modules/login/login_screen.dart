// @dart=2.9
import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/modules/reset_password/reset_password.dart';
import 'package:faster/modules/sign%20up/signup_screen.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is LoginSuccessState) {
        showToast(text: 'Success Login', state: ToastState.SUCCESS);
      }
    }, builder: (context, state) {
      // final FocusNode _passwordFocusNode = FocusNode();

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
                  Container(
                    margin: const EdgeInsets.only(top: 80),
                    height: 120.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      //  color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://image.flaticon.com/icons/png/128/869/869636.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                      key: cubit.Login_formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              // key: const ValueKey('email'),
                              controller: cubit.txtLoginEmailController,
                              focusNode: cubit.LogInEmailFocusNode,
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(cubit.LogInpasswordFocusNode),
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
                              //key: const ValueKey('Password'),
                              controller: cubit.txtLoginPassController,
                              focusNode: cubit.LogInpasswordFocusNode,
                              validator: (value) {
                                if (value.isEmpty || value.length < 7) {
                                  return 'Please enter a valid Password';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,

                              decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  filled: true,
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      cubit.HiddenPassword();
                                    },
                                    child: Icon(cubit.icon),
                                  ),
                                  labelText: 'Password',
                                  fillColor: Theme.of(context).backgroundColor),
                              // onSaved: (value) {
                              //   _password = value;
                              // },
                              obscureText: cubit.isHidden,
                              onEditingComplete: () {
                                if (cubit.Login_formKey.currentState
                                    .validate()) {
                                  cubit.Login_formKey.currentState.save();
                                  cubit.Login(context);
                                }
                              },
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(width: 10),
                                  ElevatedButton(
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
                                        navigateTo(context, const SignUp_Screen());
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
                                            Feather.user_plus,
                                            size: 18,
                                          )
                                        ],
                                      )),
                                  const SizedBox(width: 10),
                                  state is LoginLoadingState
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              side: BorderSide(
                                                  color: ColorsConst
                                                      .backgroundColor),
                                            ),
                                          )),
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();

                                            if (cubit.Login_formKey.currentState
                                                .validate()) {
                                              cubit.Login_formKey.currentState
                                                  .save();
                                              cubit.Login(context);
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                'Login',
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
                              TextButton(
                                  onPressed: () => navigateTo(
                                      context, const ResetPasswordScreen()),
                                  child: const Text(
                                    'Forget password ?',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
