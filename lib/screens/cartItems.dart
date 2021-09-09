import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technoshop/blocs/Cart_bloc%20.dart';
import 'package:technoshop/blocs/Order_bloc.dart';
import 'package:technoshop/blocs/product_bloc.dart';
import 'package:technoshop/models/Cart.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/navigation_drawer.dart';
import 'package:technoshop/screens/orders.dart';

class CartItems extends StatefulWidget {
  int somme = 0;
  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  int cartId;
  int total;
  //raisedButton() {}

  bool isLoggedIn = false;
  SharedPreferences sharedPreferences;
  String token;
  _checkToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token');
    // print(token);
    setState(() {
      if (token == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
      }
    });
  }

  getCartId(int id) {
    return cartId = id;
  }

  //PostsAPI postsAPI = PostsAPI();
  void initState() {
    super.initState();

    cartId = null;
    total = 0;
    _checkToken();

    //BlocProvider.of<OrderBloc>(context).add(AddOrderEvent());

    BlocProvider.of<CartBloc>(context).add(DoFetchCartItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text('My favorites'),
      ),
      drawer: NavigationDrawer(),
      body: PageView(children: <Widget>[
        BlocBuilder<CartBloc, CartStates>(builder: (context, state) {
          if (!isLoggedIn) {
            return Center(child: Text("Empty"));
          } else {
            if (state is CartLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartItemFetchSuccess) {
              if (state.cart == null)
               
               //
 
         return Container(
                            color: Colors.red,
                            child:Center(child: Text("No favorite was found",
                              style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                            ))
                            
                            );
               //
              else
                //widget.somme=state.cart.total;

                return ListView.builder(
                    itemCount: state.cart.cartItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: drawSingleRow(state.cart.cartItems[index]),
                      );
                    });
            }
          }
        }),
      ]),
      bottomNavigationBar: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
           
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 90,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    //

    //
  }

  Widget drawSingleRow(CartItem cartItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
              width: 50,
              height: 50,
              child: Image.network(
                //image_location,
                // "assets/images/p1.jpg",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNMoU7OtItDHrVIRk5WEogUFlg3zImbN8w3A&usqp=CAU",
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(cartItem.offre.title),
                    
                  
                  ],
                ),
                 Row(
                  children: [
                    Text('Published on:'),
                    SizedBox(width: 15),
                    Text(
                      cartItem.offre.createdAt.toString(),
                      style: TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
            
              ],
            ),
          )
        ],
      ),
    );
  }
}
