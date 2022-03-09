// @dart=2.9

// ignore_for_file: unused_local_variable

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';

import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          showToast(text: 'Success', state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
            body: Form(
          key: cubit.resetPasswordLogin_formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Forget password',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  // key: const ValueKey('email'),
                  controller: cubit.txtResetPasswordEmailController,
                  focusNode: cubit.ResetPasswordFocusNode,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () => FocusScope.of(context)
                      .requestFocus(cubit.ResetPasswordFocusNode),
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
              state is LoginLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                  color: ColorsConst.backgroundColor),
                            ),
                          )),
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            if (cubit.resetPasswordLogin_formKey.currentState
                                .validate()) {
                              cubit.resetPasswordLogin_formKey.currentState
                                  .save();
                              cubit.resetPassword(context);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Reset password',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Entypo.key,
                                size: 18,
                              )
                            ],
                          )),
                    ),
            ],
          ),
        ));
      },
    );
  }
}
