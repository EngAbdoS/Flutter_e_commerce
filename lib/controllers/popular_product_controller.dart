import 'dart:convert';

import 'package:ecommirce/controllers/cart_controller.dart';
import 'package:ecommirce/data/repesetory/popural_prudect_repo.dart';
import 'package:ecommirce/models/products_model.dart';
import 'package:ecommirce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularproductlist = [];

  List<dynamic> get popularproductlist => _popularproductlist;
  late CartController _cart;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  int _quantity = 0;

  int get quantity => _quantity;
  int _inCardItems = 0;

  int get inCardItems => _inCardItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    //print("step1");
    //print(json.decode(response.body));
    if (response.statusCode == 200) //successful
    {
      print("🤸 جاب الداتا");
      _popularproductlist = [];
      _popularproductlist.addAll(Product.fromJson(response.body).products);
      print(_popularproductlist);
      _isLoaded = true;
      update();
    } else {
      print("مفيش");
    }
  }

  void setQuantity(bool isincrement) {
    if (isincrement) {
      _quantity = checkQuantity(_quantity + 1);
       print("quantity"+_quantity.toString());
    } else {
      //if(_quantity>0)
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCardItems+ quantity )< 0) {
      Get.snackbar(
        "Item count",
        "You cant reduce more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    } else if ((_inCardItems+ quantity ) > 20) {
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product,CartController cart) {
    _quantity = 0;
    _inCardItems = 0;
    _cart = cart;
    var exist=false;
    exist=_cart.existInCart(product);
    print ("exist"+exist.toString());
    if(exist){
      _inCardItems=_cart.getQuantity(product);
      print ("quantity in tje cart is "+_inCardItems.toString());
    }
    //get from storage incarditems=?
  }

  void addItem(ProductModel product) {
   // if (_quantity > 0) {
      _cart.addItem(product, _quantity);
      _quantity=0;
      _inCardItems=_cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print("the id is "+value.id.toString()+" the quantity is "+value.quantity.toString());
      });
   /*} else {
      Get.snackbar(
        "Item count",
        "You should add at least an item to the cart !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
    }*/
    update();
  }

  int get totalItems{

    return _cart.totalItems;
  }

List<CartModel>get getItems
{

  return _cart.getItems;
}}
