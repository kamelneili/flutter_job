import 'package:technoshop/models/offre.dart';

class CartItem {
  Offre offre;
  String qty;

  CartItem(
    this.offre,
    this.qty,
  );

  CartItem.fromJson(Map<String, dynamic> json) {
   // print(json);
   //print(json['product']);
    this.offre = Offre.fromJson(json['offre']);
    this.qty =json['qty'].toString();

    //int.tryParse(json['qty']);
    print(this.qty);
  }
}

class Cart {
  List<CartItem> cartItems;
  int id;
  int total;
  Cart(
    this.id,
    this.total,
    this.cartItems,
  );

  Cart.fromJson(Map<String, dynamic> json) {
    
    cartItems = [];
    var items = json['cart_items'];
   // print(items);
    for (var item in items) {
      cartItems.add(CartItem.fromJson(item));
    }
    this.id = json['id'];
    this.total = json['total'];
      //  print(this.total);

  }
}
