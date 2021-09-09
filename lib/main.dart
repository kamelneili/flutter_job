import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/Auth_bloc.dart';
import 'package:technoshop/blocs/Cart_bloc%20.dart';
import 'package:technoshop/blocs/Order_bloc.dart';
import 'package:technoshop/blocs/category_bloc%20.dart';
import 'package:technoshop/blocs/offre_bloc.dart';
import 'package:technoshop/blocs/product_bloc.dart';
import 'package:technoshop/blocs/search_bloc.dart';
import 'package:technoshop/models/Cart.dart';
import 'package:technoshop/models/product.dart';
import 'package:technoshop/repository/auth_repository.dart';
import 'package:technoshop/repository/cart_api.dart';
import 'package:technoshop/repository/categories_api.dart';
import 'package:technoshop/repository/offres_api.dart';
import 'package:technoshop/repository/order_api.dart';
import 'package:technoshop/repository/products_api.dart';
import 'package:technoshop/screens/add_offre.dart';
import 'package:technoshop/screens/cartItems.dart';
import 'package:technoshop/screens/catalogue.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/login.dart';
import 'package:technoshop/screens/order_details.dart';
import 'package:technoshop/screens/orders.dart';
import 'package:technoshop/screens/offres.dart';
import 'package:technoshop/screens/Home.dart';
import 'package:technoshop/screens/profile.dart';
import 'package:technoshop/screens/register.dart';
import 'package:technoshop/screens/registerSte.dart';
import 'package:technoshop/screens/searchoffres%20.dart';
import 'package:technoshop/screens/single_offre.dart';
import 'package:technoshop/screens/splash/splash_screen.dart';
import 'package:technoshop/screens/view/LoginPage.dart';
import 'package:technoshop/state/auth_state.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() => runApp(Auth());

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Product p;
    String key;
    String title;
    return MultiBlocProvider(
        providers: [
           
          BlocProvider(
            create: (context) =>
                OrderBloc(OrderInitialState(), OrderAPI()),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(CatInitialState1(), CategoriesAPI()),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(CatProductsInitialState1(), CategoriesAPI()),
          ),
          BlocProvider(
            create: (context) => ProductBloc(InitialState1(), ProductsAPI()),
          ),
          BlocProvider(
            create: (context) =>
                SearchBloc(SearchInitialState1(), OffresAPI()),
          ),
          BlocProvider(
              create: (context) =>
                  AuthBloc(LoginInitState(), AuthRepository())),
          BlocProvider(
            create: (context) => CartBloc(CartInitialState(), CartAPI()),
          ),
          BlocProvider(
            create: (context) =>
                OffreBloc(OffreInitialState(), OffresAPI()),
          ),
        ],
        child: MaterialApp(

            debugShowCheckedModeBanner: false,
             theme: ThemeData(
       // textTheme: GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme),
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
      ),
            initialRoute: '/spalishScreen',
            routes: {
              '/register': (context)=>Register(),
                            '/registerManager': (context)=>RegisterSte(),

                              '/addOffre': (context) => AddOffre(),

                              '/orderDetails': (context) => OrderDetails(),
                    '/spalishScreen' :(context) => SplashScreen(),
                '/order': (context) => Orders(),
              '/card': (context) => CartItems(),
              '/profile': (context) => Profile(),
              '/offres': (context) => Offres(),
              '/singleoffre': (context) => SingleOffre(),
              '/catalogue': (context) => Catalogue(),
              '/home': (context) => HomePage(),
              '/': (context) => Login(),
              '/SearchOffres': (context) => SearchOffres(key),
            }));
  }
}
