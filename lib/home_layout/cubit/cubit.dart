// @dart=2.9

// ignore_for_file: non_constant_identifier_names, deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faster/home_layout/cubit/state.dart';
import 'package:faster/landing_screen/landing_screen.dart';
import 'package:faster/models/cart_attr_model.dart';
import 'package:faster/models/orders_attr_model.dart';
import 'package:faster/models/product_model.dart';
import 'package:faster/models/wishlist_attr_model.dart';
import 'package:faster/modules/cart/cart.dart';
import 'package:faster/modules/feeds/feeds.dart';
import 'package:faster/modules/home/home.dart';
import 'package:faster/modules/main_screen/main_screen.dart';

import 'package:faster/modules/search/search.dart';
import 'package:faster/modules/user_info/user_info.dart';
import 'package:faster/shared/components/componant.dart';
import 'package:faster/shared/network/end_point.dart';
import 'package:faster/shared/network/local.dart';
import 'package:faster/shared/network/payment.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  final FirebaseAuth auth = FirebaseAuth.instance;
  var uuid = const Uuid();

  // Home Layout

  int currentIndex = 0;
  List screens = [
    const Home(),
    const Feeds(),
    Search(),
    const Cart(),
    User_Info()
  ];

  void changecurrentIndex(int value) {
    currentIndex = value;
    emit(HomeChangeBottmNavState());
  }

  // Change Theme Mode

  bool isDarkTheme = false;

  void mode({bool fromShared}) {
    if (fromShared != null) {
      isDarkTheme = fromShared;
      emit(HomeChangeThemeState());
    } else {
      isDarkTheme = !isDarkTheme;
      Cash_Helper.saveData(key: 'them', value: isDarkTheme).then((value) {
        emit(HomeChangeThemeState());
      });
    }
  }

  // Home Screen

  List<String> carouselImage = [
    'images/carousel1.png',
    'images/carousel2.jpeg',
    'images/carousel3.jpg',
    'images/carousel4.png'
  ];

  List brandImages = [
    //'images/dell.jpg',
    'images/addidas.jpg',
    'images/addidas.jpg',
    'images/apple.jpg',
    'images/h&m.jpg',
    'images/nike.jpg',
    'images/samsung.jpg',
    'images/samsung.jpg',
    // 'images/huawei.jpg',
  ];
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'Phones',
      'categoryImagesPath': 'images/CatPhones.png',
    },
    {
      'categoryName': 'Clothes',
      'categoryImagesPath': 'images/CatClothes.jpg',
    },
    {
      'categoryName': 'Shoes',
      'categoryImagesPath': 'images/CatShoes.jpg',
    },
    {
      'categoryName': 'Beauty&Health',
      'categoryImagesPath': 'images/CatBeauty.jpg',
    },
    {
      'categoryName': 'Laptops',
      'categoryImagesPath': 'images/CatLaptops.png',
    },
    {
      'categoryName': 'Furniture',
      'categoryImagesPath': 'images/CatFurniture.jpg',
    },
    {
      'categoryName': 'Watches',
      'categoryImagesPath': 'images/CatWatches.jpg',
    },
  ];

  List<Product> popularPruducts = [];

  void getPopularPruducts() {
    popularPruducts = [];
    popularPruducts = products;

    // products.where((element) => element.isPopular == false).toList();
    emit(GetPopularProductsSuccessState());
    debugPrint(popularPruducts.toString());
  }

  // Category Screen

  List<Product> category_feed = [];

  void getCategoryFeed(String category) {
    category_feed = [];
    for (var element in products) {
      if (element.productCategoryName == category) {
        category_feed.add(element);
        emit(HomeGetCategoryFeedState());
      }
    }
  }

  // Brand Screen

  int selectPrandIndex = 7;

  String brand;

  void onDestinationSelected(int index) {
    selectPrandIndex = index;
    if (selectPrandIndex == 0) {
      brand = 'Addidas';
      emit(HomePrandIndexState());
    }
    if (selectPrandIndex == 1) {
      brand = 'Apple';
      emit(HomePrandIndexState());
    }
    if (selectPrandIndex == 2) {
      brand = 'Dell';
      emit(HomePrandIndexState());
    }
    if (selectPrandIndex == 3) {
      brand = 'H&M';
      emit(HomePrandIndexState());
    }
    if (selectPrandIndex == 4) {
      brand = 'Nike';
      emit(HomePrandIndexState());
    }
    if (selectPrandIndex == 5) {
      brand = 'Samsung';
      emit(HomePrandIndexState());
    }
    if (selectPrandIndex == 6) {
      brand = 'Huawei';
      emit(HomePrandIndexState());
    }
    if (selectPrandIndex == 7) {
      brand = 'All';
      emit(HomePrandIndexState());
    }
    debugPrint(brand);

    emit(HomePrandIndexState());
  }

  List<Product> prand_feed = [];

  void getPrandFeed() {
    if (brand == 'All') {
      prand_feed = products;
    } else {
      prand_feed = [];
      prand_feed =
          products.where((element) => element.brand.contains(brand)).toList();
    }
  }

// Cart Screen

  Map<String, CartAttr> cartItems = {};

  double get totalAmount {
    var total = 0.0;

    cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });

    return total;
  }

  void addProductToCart(String productId, double prise, String title,
      String imageUrl, String brand, String category, String description) {
    if (cartItems.containsKey(productId)) {
      cartItems.update(productId, (exitingCartItem) {
        return CartAttr(
            id: exitingCartItem.id,
            brand: exitingCartItem.brand,
            category: exitingCartItem.category,
            title: exitingCartItem.title,
            price: exitingCartItem.price,
            imageUrl: exitingCartItem.imageUrl,
            description: exitingCartItem.description,
            quantity: exitingCartItem.quantity + 1,
            productId: exitingCartItem.productId);
      });
      emit(HomeAddCartItemState());
    } else {
      cartItems.putIfAbsent(
          productId,
          () => CartAttr(
                id: DateTime.now().toString(),
                title: title,
                price: prise,
                brand: brand,
                category: category,
                description: description,
                imageUrl: imageUrl,
                quantity: 1,
                productId: productId,
              ));
      debugPrint(cartItems.toString());
      emit(HomeAddCartItemState());
    }
  }

  void MinseCartQuantity(
      String productId, double prise, String title, String imageUrl) {
    if (cartItems.containsKey(productId)) {
      cartItems.update(productId, (exitingCartItem) {
        return CartAttr(
          id: exitingCartItem.id,
          title: exitingCartItem.title,
          price: exitingCartItem.price,
          imageUrl: exitingCartItem.imageUrl,
          quantity: exitingCartItem.quantity - 1,
          productId: productId,
        );
      });
      emit(HomeQuantityMinesState());
    }
  }

  void removeCartItem(String id) {
    cartItems.remove(id);
    emit(HomeRemoveCartItemState());
  }

  void deletCarts() {
    cartItems.clear();
    emit(HomeRemoveCartsState());
  }

  double subTotal(double subtotal, int quantity) {
    return subtotal * quantity;
  }

  var response;

  Future<void> payWithCard({int amount, context}) async {
    emit(HomePaymentLoadingState());
    response = await StripeService.payWithNewCard(
            currency: 'USD', amount: amount.toString())
        .then((value) {
      User user = auth.currentUser;
      final uid = user.uid;
      cartItems.forEach((key, orderValue) {
        final orderId = uuid.v4();

        FirebaseFirestore.instance.collection('orders').doc(orderId).set({
          'orderId': orderId,
          'userId': uid,
          'productId': orderValue.productId,
          'title': orderValue.title,
          'price': orderValue.price * orderValue.quantity,
          'imageUrl': orderValue.imageUrl,
          'quantity': orderValue.quantity,
          'orderDate': Timestamp.now(),
        }).then((value) {
          deletOrders();
          getOrdersData();
          emit(HomeUploadOrderSuccessState());
        }).catchError((e) {
          debugPrint(e.toString());
          emit(HomeUploadOrderErrorState());
        });
      });
      deletCarts();
      emit(HomePaymentSuccessState());
      //debugPrint('response : ${response.success}');
    }).catchError((e) {
      debugPrint(e.toString());
      showToast(text: e.toString(), state: ToastState.ERROR);
      emit(HomePaymentErrorState());
    });
  }

  // Orders Screen

  List<OrdersAttr> orderItems = [];

  void removeOrderItem(String id) {
    emit(HomeRemoveOrderItemLoadingState());
    FirebaseFirestore.instance
        .collection('orders')
        .doc(id)
        .delete()
        .then((value) {
      getOrdersData();
      emit(HomeRemoveOrderItemSuccessState());
    }).catchError((e) {
      emit(HomeRemoveOrderItemErrorState());
    });
  }

  Future<void> deletOrders() async {
    emit(HomeRemoveOrdersLoadingState());
    final collection =
        await FirebaseFirestore.instance.collection("orders").get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }
    getOrdersData();
    emit(HomeRemoveOrdersSuccessState());
    return batch.commit();
  }

  // void deletOrders() {
  //   emit(HomeRemoveOrdersLoadingState());
  //
  //   FirebaseFirestore.instance.collection('orders')
  //       .then((value) {
  //     emit(HomeRemoveOrdersSuccessState());
  //   }).catchError((e) {
  //     emit(HomeRemoveOrdersErrorState());
  //   });
  //
  // }

  Future<void> getOrdersData() async {
    User user = auth.currentUser;
    var uid = user.uid;
    emit(GetOrderDataLoadingState());
    await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .get()
        .then((QuerySnapshot productsSnapshot) {
      orderItems = [];
      for (var element in productsSnapshot.docs) {
        orderItems.insert(
            0,
            OrdersAttr(
                orderId: element.get('orderId'),
                userId: element.get('userId'),
                productId: element.get('productId'),
                title: element.get('title'),
                price: element.get('price').toString(),
                imageUrl: element.get('imageUrl'),
                quantity: element.get('quantity').toString(),
                orderDate: element.get('orderDate')));
      }

      debugPrint(orderItems.toString());
      emit(GetOrderDataSuccessState());
    }).catchError((e) {
      debugPrint(e.toString());
      emit(GetOrderDataErrorState());
    });
  }

// WishList Screen
  Map<String, WishListAttr> wishListItem = {};

  void addProductToWishList(
      String id, double prise, String title, String imageUrl) {
    if (wishListItem.containsKey(id)) {
      removeWishListItem(id);
    } else {
      wishListItem.putIfAbsent(
          id,
          () => WishListAttr(
                id: id,
                title: title,
                price: prise,
                imageUrl: imageUrl,
              ));
      debugPrint(wishListItem.toString());
      emit(HomeAddWishListItemState());
    }
  }

  void removeWishListItem(String id) {
    wishListItem.remove(id);
    emit(HomeRemoveWishListItemState());
  }

  void deletWishLists() {
    wishListItem.clear();
    emit(HomeRemoveWishListsState());
  }

  // UserInfo
  File user_info_finalPickedImage;

  void signOut(context) {
    auth.signOut().then((value) {
      Navigator.pop(context);
      TOKEN = null;
      navigateWithoutBack(context, const LandingScreen());

      emit(UserInfoSuccessState());
      // ignore: argument_type_not_assignable_to_error_handler
    }).catchError((e) {
      emit(SignUpErrorState());
    });
  }

  void userInfoPickImageGallery(context) async {
    final userPicker = ImagePicker();
    final userPickedImage =
        await userPicker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(userPickedImage.path);
    user_info_finalPickedImage = pickedImageFile;

    emit(UserInfoGalleryImageState());
  }

// Search Screen

  List<Product> searchList = [];

  void getSearchFeed(String onChange) {
    searchList = [];
    searchList = products
        .where((element) =>
            element.title.toLowerCase().contains(onChange.toLowerCase()))
        .toList();

    emit(HomeSearchState());
  }

  // Google SignIn
  Future<void> signInWithGoogle(context) async {
    emit(GoogleSignInLoadingState());
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        // Create a new credential
        final authResult =
            await auth.signInWithCredential(GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ));
        var date = DateTime.now().toString();
        var dateParse = DateTime.parse(date);
        var formattedData =
            "${dateParse.day}-${dateParse.month}-${dateParse.year}";
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'id': authResult.user.uid,
          'fullName': authResult.user.displayName,
          'email': authResult.user.email,
          'phone': authResult.user.phoneNumber,
          'imageUrl': authResult.user.photoURL,
          'joinedAt': formattedData,
        }).then((value) {
          navigateWithoutBack(context, const Main_Screen());

          final uid = authResult.user.uid;
          Cash_Helper.saveData(key: 'token', value: uid);
          getUserData();
          emit(GoogleSignInSuccessState());
        }).catchError((e) {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Error'),
                      ),
                    ],
                  ),
                  content: Text(e.message),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Ok',
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                );
              });
          emit(GoogleSignInErrorState());
        });
      }
    }
  }

// Login Screen

  var txtLoginEmailController = TextEditingController();
  var txtLoginPassController = TextEditingController();
  var LogInpasswordFocusNode = FocusNode();
  var LogInEmailFocusNode = FocusNode();
  var Login_formKey = GlobalKey<FormState>();

  bool isHidden = true;
  IconData icon = Icons.visibility_off;

  void HiddenPassword() {
    isHidden = !isHidden;
    if (isHidden) {
      icon = Icons.visibility_off;
      emit(HomeHiddenPasswordState());
    } else {
      icon = Icons.visibility;
      emit(HomeNotHiddenPasswordState());
    }
  }

  void Login(context) {
    emit(LoginLoadingState());
    auth
        .signInWithEmailAndPassword(
            email: txtLoginEmailController.text.toLowerCase().trim(),
            password: txtLoginPassController.text.trim())
        .then((value) {
      final User user = auth.currentUser;
      final uid = user.uid;
      Cash_Helper.saveData(key: 'token', value: uid);
      getUserData();
      navigateWithoutBack(context, const Main_Screen());
      emit(LoginSuccessState());
      // ignore: argument_type_not_assignable_to_error_handler
    }).catchError((e) {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Error'),
                  ),
                ],
              ),
              content: Text(e.message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            );
          });

      emit(LoginErrorState());
    });
  }

// SignUp Screen
  var txtSignUpFullNameController = TextEditingController();
  var txtSignUpEmailController = TextEditingController();
  var txtSignUpPassController = TextEditingController();
  var txtSignUpPhoneController = TextEditingController();
  var SignUp_formKey = GlobalKey<FormState>();
  var SignUpPasswordFocusNode = FocusNode();
  var SignUpEmailFocusNode = FocusNode();
  var SignUpPhoneFocusNode = FocusNode();
  var SignUpFullNameFocusNode = FocusNode();
  String imageUrl;
  File finalPickedImage;

  void pickImageCamera(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage.path);
    finalPickedImage = pickedImageFile;
    Navigator.pop(context);

    emit(HomeCameraImageState());
  }

  void pickImageGallery(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    finalPickedImage = pickedImageFile;
    Navigator.pop(context);
    emit(HomeGalleryImageState());
  }

  void removeImage(context) {
    finalPickedImage = null;
    Navigator.pop(context);

    emit(HomeRemoveImageState());
  }

  void signUp(context) async {
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedData = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    emit(SignUpLoadingState());
    if (finalPickedImage == null) {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Error'),
                  ),
                ],
              ),
              content: const Text('Please pick an image'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            );
          });
      emit(SignUpErrorState());
    } else {
      final ref = FirebaseStorage.instance
          .ref()
          .child('usersImages')
          .child(txtSignUpFullNameController.text + '.jpg');
      ref.putFile(finalPickedImage).then((p) async {
        imageUrl = await ref.getDownloadURL();
        auth
            .createUserWithEmailAndPassword(
                email: txtSignUpEmailController.text.trim().toLowerCase(),
                password: txtSignUpPassController.text.trim())
            .then((value) {
          final User user = auth.currentUser;
          final uid = user.uid;
          Cash_Helper.saveData(key: 'token', value: uid);
          FirebaseFirestore.instance.collection('users').doc(uid).set({
            'id': uid,
            'fullName': txtSignUpFullNameController.text,
            'email': txtSignUpEmailController.text,
            'phone': txtSignUpPhoneController.text,
            'password': txtSignUpPassController.text,
            'imageUrl': imageUrl,
            'joinedAt': formattedData,
            'createdAt': Timestamp.now()
          });
          getUserData();
          emit(SignUpSuccessState());
          // ignore: argument_type_not_assignable_to_error_handler
        }).catchError((e) {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Error'),
                      ),
                    ],
                  ),
                  content: Text(e.message),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Ok',
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                );
              });

          emit(SignUpErrorState());
        });
        emit(SignUpImageSuccessState());
      }).catchError((e) {
        emit(SignUpImageErrorState());
      });
    }
  }

  //Get Data

  String uid;
  String name;
  String email;
  String joinedAt;
  String phone;
  String image;

  void getUserData() async {
    User user = auth.currentUser;
    uid = user.uid;
    final DocumentSnapshot userDoc = user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc == null) {
      return null;
    } else {
      name = userDoc.get('fullName');
      email = user.email;
      joinedAt = userDoc.get('joinedAt');
      phone = userDoc.get('phone');
      image = userDoc.get('imageUrl');
    }

    emit(HomeGetUserDataSuccessState());
  }

  // Upload Product
  var UploadProduct_formKey = GlobalKey<FormState>();
  var txtUploadTitle = TextEditingController();
  var txtUploadPrice = TextEditingController();
  var txtUploadCategory = TextEditingController();
  var txtUploadBrand = TextEditingController();
  var txtUploadDescription = TextEditingController();
  var txtUploadQuantity = TextEditingController();
  String CategoryValue;
  String BrandValue;
  String productImageUrl;

  File finalPickedProductImage;

  void uploadPickImageCamera(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProductImage = pickedImageFile;

    emit(HomeCameraUploadImageState());
  }

  void UploadPickImageGallery(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    finalPickedProductImage = pickedImageFile;
    emit(HomeGalleryUploadImageState());
  }

  void removeUploadImage(context) {
    finalPickedProductImage = null;

    emit(HomeRemoveUploadImageState());
  }

  void selectCategory(String value) {
    CategoryValue = value;
    txtUploadCategory.text = value;
    emit(HomeSelectCategoryState());
  }

  void selectBrand(String value) {
    BrandValue = value;
    txtUploadBrand.text = value;
    emit(HomeSelectBrandState());
  }

  void uploadProduct(context) async {
    emit(UploadProductLoadingState());
    if (finalPickedProductImage == null) {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Error'),
                  ),
                ],
              ),
              content: const Text('Please pick an image'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            );
          });
      emit(UploadProductErrorState());
    } else {
      final ref = FirebaseStorage.instance
          .ref()
          .child('productsImages')
          .child(txtUploadTitle.text + '.jpg');
      ref.putFile(finalPickedProductImage).then((p) async {
        productImageUrl = await ref.getDownloadURL();

        final User user = auth.currentUser;
        final uid = user.uid;
        final productId = uuid.v4();
        FirebaseFirestore.instance.collection('products').doc(productId).set({
          'id': uid,
          'productId': productId,
          'productTitle': txtUploadTitle.text,
          'price': txtUploadPrice.text,
          'productImage': productImageUrl,
          'productCategory': txtUploadCategory.text,
          'productBrand': txtUploadBrand.text,
          'productDescription': txtUploadDescription.text,
          'productQuantity': txtUploadQuantity.text,
          'createdAt': Timestamp.now(),
        }).then((value) {
          txtUploadBrand.text = '';
          txtUploadTitle.text = '';
          txtUploadPrice.text = '';
          txtUploadCategory.text = '';
          txtUploadDescription.text = '';
          txtUploadQuantity.text = '';
          finalPickedProductImage = null;
          getProductsData();
          emit(UploadProductSuccessState());
        }).catchError((e) {});
        // ignore: argument_type_not_assignable_to_error_handler
      }).catchError((e) {
        emit(UploadProductImageErrorState());
      });
    }
  }

  // SignIn Anonymously

  void signInAnonymously(context) {
    emit(SignInAnonymouslyLoadingState());
    FirebaseAuth.instance.signInAnonymously().then((value) {
      final User user = auth.currentUser;
      final uid = user.uid;
      Cash_Helper.saveData(key: 'token', value: uid);
      getUserData();
      navigateWithoutBack(context, const Main_Screen());
      emit(SignInAnonymouslySuccessState());
    }).catchError((e) {
      emit(SSignInAnonymouslyErrorState());
    });
  }

  // Reset Password

  var txtResetPasswordEmailController = TextEditingController();
  var ResetPasswordFocusNode = FocusNode();
  var resetPasswordLogin_formKey = GlobalKey<FormState>();

  void resetPassword(context) {
    emit(ResetPasswordLoadingState());
    auth
        .sendPasswordResetEmail(
            email: txtResetPasswordEmailController.text.trim().toLowerCase())
        .then((value) {
      // navigateWithoutBack(context,LoginScreen());
      txtLoginEmailController.text = '';
      txtLoginPassController.text = '';
      emit(ResetPasswordSuccessState());
    }).catchError((e) {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Error'),
                  ),
                ],
              ),
              content: Text(e.message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            );
          });

      emit(ResetPasswordErrorState());
    });
  }

// Data

  List<Product> products = [];

  Future<void> getProductsData() async {
    emit(GetProductDataLoadingState());
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      products = [];
      for (var element in productsSnapshot.docs) {
        products.insert(
          0,
          Product(
              id: element.get('productId'),
              title: element.get('productTitle'),
              description: element.get('productDescription'),
              price: double.parse(element.get('price')),
              imageUrl: element.get('productImage'),
              brand: element.get('productBrand'),
              productCategoryName: element.get('productCategory'),
              quantity: int.parse(element.get('productQuantity')),
              isPopular: true),
        );
      }

      emit(GetProductDataSuccessState());
    }).catchError((e) {
      emit(GetProductDataErrorState());
    });
  }
}
