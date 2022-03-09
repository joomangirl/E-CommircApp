// @dart=2.9

import 'package:backdrop/backdrop.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:faster/home_layout/cubit/cubit.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/modules/feeds/feed_product.dart';
import 'package:faster/modules/feeds/feeds.dart';
import 'package:faster/modules/user_info/user_info.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'backlayer.dart';
import 'brands_ontap/brand_navigation_rail_screen.dart';
import 'category_ontap/category_home_widget.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Scaffold(
          body: Center(
              child: BackdropScaffold(
            frontLayerBackgroundColor:
                Theme.of(context).scaffoldBackgroundColor,
            headerHeight: MediaQuery.of(context).size.height * 0.25,
            appBar: BackdropAppBar(
              title: const Text("Home"),
              leading: const BackdropToggleButton(
                icon: AnimatedIcons.home_menu,
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    ColorsConst.starterColor,
                    ColorsConst.endColor,
                  ], stops: const [
                    0.0,
                    0.7
                  ]),
                ),
              ),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      navigateTo(context, User_Info());
                    },
                    padding: const EdgeInsets.all(10),
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 13,
                        backgroundImage: HomeCubit.get(context).imageUrl == null
                            ? NetworkImage(cubit.image ??
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg')
                            : NetworkImage(cubit.imageUrl),
                      ),
                    ))
              ],
            ),
            backLayer: BackLayerMenu(),
            frontLayer: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 190.0,
                    width: double.infinity,
                    child: Carousel(
                      boxFit: BoxFit.fill,
                      dotSize: 5.0,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: const Duration(milliseconds: 1000),
                      dotIncreasedColor: Colors.purple,
                      dotBgColor: Colors.black.withOpacity(0.1),
                      dotPosition: DotPosition.bottomCenter,
                      indicatorBgPadding: 4.0,
                      images: [
                        ExactAssetImage(cubit.carouselImage[0]),
                        ExactAssetImage(cubit.carouselImage[1]),
                        ExactAssetImage(cubit.carouselImage[2]),
                        ExactAssetImage(cubit.carouselImage[3]),
                      ],
                      showIndicator: true,
                      borderRadius: false,
                      moveIndicatorFromBottom: 180.0,
                      noRadiusForIndicator: true,
                      overlayShadow: true,
                      overlayShadowColors: Colors.white,
                      overlayShadowSize: 0.7,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Categories',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: ListView.builder(
                      itemCount: 7,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext ctx, int index) {
                        return category(index, context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Popular Brands',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                        const Spacer(),
                        MaterialButton(
                          onPressed: () {
                            cubit.brand = 'All';
                            cubit.getPrandFeed();
                            navigateTo(context, const BrandsNavigationRail());
                          },
                          child: const Text(
                            'View all...',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 210,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Swiper(
                      itemCount: cubit.brandImages.length,
                      autoplay: true,
                      viewportFraction: 0.8,
                      scale: 0.9,
                      onTap: (index) {
                        cubit.brand = 'All';
                        cubit.getPrandFeed();
                        navigateTo(context, const BrandsNavigationRail());
                      },
                      itemBuilder: (BuildContext ctx, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.blueGrey,
                            child: Image.asset(
                              cubit.brandImages[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            'Popular Products',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                          const Spacer(),
                          MaterialButton(
                            onPressed: () {
                              navigateTo(context, const Feeds());
                            },
                            child: const Text(
                              'View all...',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: Colors.red),
                            ),
                          )
                        ],
                      )),
                  SafeArea(
                    child: SizedBox(
                      height: 320,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: ListView.separated(
                        itemBuilder: (context, index) => product_feed(
                            context, index, cubit.products[index].id),
                        scrollDirection: Axis.horizontal,
                        itemCount: HomeCubit.get(context).products.length < 7
                            ? HomeCubit.get(context).products.length
                            : 7,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 75,
                  )
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
