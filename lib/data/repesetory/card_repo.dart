import 'dart:convert';

import 'package:ecommirce/utils/app_constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;//only access string!

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addCartList(List<CartModel> cartList) {
var time=DateTime.now().toString();
   // sharedPreferences.remove(AppConstans.CART_LIST);
   // sharedPreferences.remove(AppConstans.CART_HISTORY_LIST);

    cart = [];
    cartList.forEach((element) {
      element.time=time;


      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstans.CART_LIST, cart);
   // print(sharedPreferences.getStringList(AppConstans.CART_LIST));
   // getCartList();
  }
List<CartModel>getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstans.CART_HISTORY_LIST)){
      cartHistory=[];
      cartHistory=sharedPreferences.getStringList(AppConstans.CART_HISTORY_LIST)!;
    }
    List<CartModel>cartListHistory=[];
    cartHistory.forEach((element) =>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
}

  List<CartModel>getCartList(){
    List<String>carts=[];//?
if(sharedPreferences.containsKey(AppConstans.CART_LIST)){
 carts= sharedPreferences.getStringList(AppConstans.CART_LIST)!;
 print("inside getcart"+carts.toString());

}


List<CartModel>cartList=[];

carts.forEach((element) { //?
  cartList.add(CartModel.fromJson(jsonDecode(element)));
});
//?
carts.forEach((element) =>cartList.add(CartModel.fromJson(jsonDecode(element))));///////////////////////////////??????!!!
    return cartList;



  }


  void addToCadtHistoryList(){
    if(sharedPreferences.containsKey(AppConstans.CART_HISTORY_LIST))
      {
        cartHistory=sharedPreferences.getStringList(AppConstans.CART_HISTORY_LIST)!;
      }

    for(int i=0;i<cart.length;i++)
      {
cartHistory.add(cart[i]);

      }
    sharedPreferences.setStringList(AppConstans.CART_HISTORY_LIST, cartHistory);


 removeCart();
  }

  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstans.CART_LIST);
    print("the lenth of history"+getCartHistoryList().length.toString());

  }
}
