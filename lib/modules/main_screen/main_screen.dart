// @dart=2.9

// ignore_for_file: camel_case_types

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/home_layout/home_layout.dart';
import 'package:faster/modules/upload_product/upload_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Main_Screen extends StatelessWidget {
  const Main_Screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (contest, state) {
        if (state is SignInAnonymouslySuccessState ||
            state is GoogleSignInSuccessState ||
            state is SignUpSuccessState ||
            state is LoginSuccessState) {
          HomeCubit.get(context).getUserData();
        }
      },
      builder: (context, state) {
        return PageView(
          children: const [HomeLayout(), UploadProductForm()],
        );
      },
    );
  }
}
