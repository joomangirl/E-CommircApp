// @dart=2.9

// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class UploadProductForm extends StatelessWidget {
  const UploadProductForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is UploadProductSuccessState) {
          showToast(text: 'Success', state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          bottomSheet: Container(
            height: kBottomNavigationBarHeight * 0.8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsConst.white,
              border: const Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: state is UploadProductLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Material(
                    color: Theme.of(context).backgroundColor,
                    child: InkWell(
                      onTap: () {
                        if (cubit.UploadProduct_formKey.currentState
                            .validate()) {
                          cubit.uploadProduct(context);
                        } else {
                          return null;
                        }
                      },
                      splashColor: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: Text('Upload',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center),
                          ),
                          GradientIcon(
                            Feather.upload,
                            20,
                            LinearGradient(
                              colors: <Color>[
                                Colors.green,
                                Colors.yellow,
                                Colors.deepOrange,
                                Colors.orange,
                                Colors.yellow[800]
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Card(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: cubit.UploadProduct_formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 9),
                                    child: TextFormField(
                                      key: const ValueKey('Title'),
                                      controller: cubit.txtUploadTitle,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter a Title';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        labelText: 'Product Title',
                                      ),
                                      // onSaved: (value) {
                                      //   _productTitle = value;
                                      // },
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: TextFormField(
                                    key: const ValueKey('Price \$'),
                                    controller: cubit.txtUploadPrice,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Price is missed';
                                      }
                                      return null;
                                    },
                                    // inputFormatters: <TextInputFormatter>[
                                    //   FilteringTextInputFormatter.allow(
                                    //       RegExp(r'[0-9]')),
                                    // ],
                                    decoration: const InputDecoration(
                                      labelText: 'Price \$',
                                      //  prefixIcon: Icon(Icons.mail),
                                      // suffixIcon: Text(
                                      //   '\n \n \$',
                                      //   textAlign: TextAlign.start,
                                      // ),
                                    ),
                                    //obscureText: true,
                                    // onSaved: (value) {
                                    //   _productPrice = value;
                                    // },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            /* Image picker here ***********************************/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  //  flex: 2,
                                  child: cubit.finalPickedProductImage == null
                                      ? Container(
                                          margin: const EdgeInsets.all(10),
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Theme.of(context)
                                                .backgroundColor,
                                          ),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.all(10),
                                          height: 200,
                                          width: 200,
                                          child: Container(
                                            height: 200,
                                            // width: 200,
                                            decoration: BoxDecoration(
                                              // borderRadius: BorderRadius.only(
                                              //   topLeft: const Radius.circular(40.0),
                                              // ),
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                            ),
                                            child: Image.file(
                                              cubit.finalPickedProductImage,
                                              fit: BoxFit.fitWidth,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      child: FlatButton.icon(
                                        textColor: Colors.white,
                                        onPressed: () => cubit
                                            .uploadPickImageCamera(context),
                                        icon: const Icon(Icons.camera,
                                            color: Colors.purpleAccent),
                                        label: Text(
                                          'Camera',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .textSelectionColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: FlatButton.icon(
                                        textColor: Colors.white,
                                        onPressed: () =>
                                            cubit.UploadPickImageGallery(
                                                context),
                                        icon: const Icon(Icons.image,
                                            color: Colors.purpleAccent),
                                        label: Text(
                                          'Gallery',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .textSelectionColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: FlatButton.icon(
                                        textColor: Colors.white,
                                        onPressed: () =>
                                            cubit.removeUploadImage(context),
                                        icon: const Icon(
                                          Icons.remove_circle_rounded,
                                          color: Colors.red,
                                        ),
                                        label: const Text(
                                          'Remove',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  // flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 9),
                                    child: TextFormField(
                                      controller: cubit.txtUploadCategory,

                                      key: const ValueKey('Category'),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter a Category';
                                        }
                                        return null;
                                      },
                                      //keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                          labelText: 'Add a new Category',
                                          border: InputBorder.none),
                                      // onSaved: (value) {
                                      //   _productCategory = value;
                                      // },
                                    ),
                                  ),
                                ),
                                DropdownButton<String>(
                                  items: const [
                                    DropdownMenuItem<String>(
                                      child: Text('Phones'),
                                      value: 'Phones',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Clothes'),
                                      value: 'Clothes',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Beauty & health'),
                                      value: 'Beauty',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Shoes'),
                                      value: 'Shoes',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Funiture'),
                                      value: 'Funiture',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Watches'),
                                      value: 'Watches',
                                    ),
                                  ],
                                  onChanged: (String value) {
                                    cubit.selectCategory(value);
                                  },
                                  hint: const Text('Select a Category'),
                                  value: cubit.CategoryValue,
                                  //value: _categoryValue,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 9),
                                    child: TextFormField(
                                      controller: cubit.txtUploadBrand,

                                      key: const ValueKey('Brand'),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Brand is missed';
                                        }
                                        return null;
                                      },
                                      //keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        labelText: 'Brand',
                                      ),
                                      // onSaved: (value) {
                                      //   _productBrand = value;
                                      // },
                                    ),
                                  ),
                                ),
                                DropdownButton<String>(
                                  items: const [
                                    DropdownMenuItem<String>(
                                      child: Text('BrandLess'),
                                      value: 'BrandLess',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Addidas'),
                                      value: 'Addidas',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Apple'),
                                      value: 'Apple',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Dell'),
                                      value: 'Dell',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('H&M'),
                                      value: 'H&M',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Nike'),
                                      value: 'Nike',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Samsung'),
                                      value: 'Samsung',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Huawei'),
                                      value: 'Huawei',
                                    ),
                                  ],
                                  onChanged: (String value) {
                                    cubit.selectBrand(value);
                                  },
                                  hint: const Text('Select a Brand'),
                                  value: cubit.BrandValue,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                                key: const ValueKey('Description'),
                                controller: cubit.txtUploadDescription,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'product description is required';
                                  }
                                  return null;
                                },
                                maxLines: 10,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: const InputDecoration(
                                  //  counterText: charLength.toString(),
                                  labelText: 'Description',
                                  hintText: 'Product description',
                                  border: OutlineInputBorder(),
                                ),
                                // onSaved: (value) {
                                //   _productDescription = value;
                                // },
                                onChanged: (text) {
                                  // setState(() => charLength -= text.length);
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  //flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 9),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      key: const ValueKey('Quantity'),
                                      controller: cubit.txtUploadQuantity,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Quantity is missed';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Quantity',
                                      ),
                                      // onSaved: (value) {
                                      //   _productQuantity = value;
                                      // },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
