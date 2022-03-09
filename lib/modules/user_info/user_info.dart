// @dart=2.9

// ignore_for_file: camel_case_types, must_be_immutable

import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/modules/cart/cart.dart';
import 'package:faster/modules/orders/orders.dart';
import 'package:faster/modules/wishList/wishlist.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class User_Info extends StatelessWidget {
  ScrollController scrollController;
  var top = 0.0;

  User_Info({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    // leading: Icon(Icons.ac_unit_outlined),
                    automaticallyImplyLeading: false,
                    expandedHeight: 200,
                    centerTitle: true,

                    elevation: 0,
                    pinned: true,
                    flexibleSpace: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;

                      return Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.purple, Colors.deepPurple],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp)),
                        child: FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: top <= 110.0 ? 1.0 : 0,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: kToolbarHeight / 1.8,
                                  width: kToolbarHeight / 1.8,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: cubit.user_info_finalPickedImage ==
                                              null
                                          ? NetworkImage(cubit.image ??
                                              'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg')
                                          : FileImage(
                                              cubit.user_info_finalPickedImage),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  cubit.name ?? 'Anonymous',
                                  style: const TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          background: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Image(
                                image: cubit.imageUrl == null
                                    ? NetworkImage(cubit.image ??
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg')
                                    : NetworkImage(cubit.image ??
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg'),
                                fit: BoxFit.fitWidth,
                                width: double.infinity,
                              ),
                              FloatingActionButton(
                                backgroundColor: Colors.purple,
                                heroTag: "btn1",
                                onPressed: () {
                                  cubit.userInfoPickImageGallery(context);
                                },
                                child: const Icon(Icons.camera_alt_outlined),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: userTitle(title: 'User Bag')),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                navigateTo(context, const WishList());
                              },
                              splashColor: Colors.red,
                              child: const ListTile(
                                title: Text('Wishlist'),
                                trailing: Icon(Icons.chevron_right_rounded),
                                leading: Icon(Icons.favorite),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                navigateTo(context, const Cart());
                              },
                              splashColor: Colors.red,
                              child: const ListTile(
                                title: Text('My Cart'),
                                trailing: Icon(Icons.chevron_right_rounded),
                                leading: Icon(MaterialCommunityIcons.cart_plus),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                navigateTo(context, const Orders());
                              },
                              splashColor: Colors.red,
                              child: const ListTile(
                                title: Text('My Orders'),
                                trailing: Icon(Icons.chevron_right_rounded),
                                leading: Icon(Icons.shopping_bag_outlined),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: userTitle(title: 'User Information'),
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Container(
                            child: userTile(
                              'Email Address',
                              cubit.email ?? "Anonymous",
                              Icons.email,
                            ),
                          ),
                          Container(
                            child: userTile(
                              'Phone Number',
                              cubit.phone ?? 'Anonymous',
                              Icons.phone,
                            ),
                          ),
                          Container(
                            child: userTile(
                              'Shipping address',
                              "",
                              Icons.local_shipping,
                            ),
                          ),
                          Container(
                            child: userTile(
                              'joined date',
                              cubit.joinedAt ?? 'Anonymous',
                              Icons.watch_later,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.8),
                            child: userTitle(title: 'User settings'),
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          ListTileSwitch(
                            value: cubit.isDarkTheme,
                            onChanged: (value) {
                              cubit.mode();
                            },
                            leading: const Icon(Icons.dark_mode_outlined),
                            visualDensity: VisualDensity.comfortable,
                            switchType: SwitchType.cupertino,
                            switchActiveColor: Colors.indigo,
                            title: const Text('Dark theme'),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                          title: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 6.0),
                                                child: Image.network(
                                                  'https://image.flaticon.com/icons/png/128/1828/1828304.png',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text('Sign out'),
                                              ),
                                            ],
                                          ),
                                          content: const Text(
                                              'Do you want to Sign out?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel')),
                                            TextButton(
                                                onPressed: () {
                                                  cubit.signOut(context);
                                                },
                                                child: const Text(
                                                  'Ok',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ))
                                          ],
                                        );
                                      });
                                },
                                title: const Text('Logout'),
                                leading: const Icon(Icons.exit_to_app_rounded),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 85,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget userTile(String title, String subtitle, IconData leading) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(leading),
    );
  }

  Widget userTitle({@required String title}) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}
