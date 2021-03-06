import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technoshop/blocs/Cart_bloc%20.dart';
import 'package:technoshop/blocs/category_bloc%20.dart';
import 'package:technoshop/blocs/offre_bloc.dart';
import 'package:technoshop/blocs/search_bloc.dart';
import 'package:technoshop/models/category.dart';
import 'package:technoshop/models/offre.dart';
import 'package:technoshop/screens/catalogue.dart';
import 'package:technoshop/screens/category_offres.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/coustom_bottom_nav_bar.dart';

import 'package:technoshop/screens/enums.dart';
import 'package:technoshop/screens/navigation_drawer.dart';
import 'package:technoshop/screens/searchoffres%20.dart';
import 'package:technoshop/screens/single_offre.dart';
//import 'package:technoshop/screens/products.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  TabController _tabController;
  TextEditingController keyController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CatDoFetchEvent1());
    BlocProvider.of<CartBloc>(context).add(DoFetchCartItemsEvent());
    BlocProvider.of<OffreBloc>(context).add(DoFetchOffresEvent1());

    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    setState(() {
      keyController.text = '';
    });
    _checkToken();
    super.initState();
  }

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

  @override
  void dispose() {
    _tabController.dispose();
    keyController.dispose();
    //super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //keyController = TextEditingController();

    return Scaffold(
      // backgroundColor: const Color(0xFF332F43),
      backgroundColor: kBackgroundColor,

      //drawer:Drawer(child:Text('red',style:TextStyle(color:Colors.red))),

      appBar: AppBar(
          backgroundColor: kPrimaryColor,
        elevation: 0,
          title: Center(
            /* decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),*/
            child: Row(
              children: [
                Text('Space ',
                    style:
                        TextStyle(fontSize: 20, 
                        fontWeight: FontWeight.bold,
                        color:Colors.black
                        )),
                Text('Jobs',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent)),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(children: <Widget>[
                IconButton(
                    icon: Icon(Icons.favorite, color: Colors.yellow),
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(DoFetchCartItemsEvent());

                      Navigator.pushNamed(context, '/card');
                    }),
                Positioned(
                  top: 2.2,
                  right: 8,
                  child: Container(
                    child: Center(child: BlocBuilder<CartBloc, CartStates>(
                      builder: (context, state) {
                        
                        if (!isLoggedIn) {
                          return Text("0");
                        } else {
                          if (state is CartLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is CartItemFetchSuccess) {
                            //widget.somme=state.cart.total;
                            if (state.cart == null)
                              return Text("0");
                            else
                              return Text(
                                  state.cart.cartItems.length.toString());
                          }
                        }
                      },
                    )),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    width: 18,
                    height: 14,
                  ),
                )
              ]),
            ),
          ]),
      drawer: NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(' Get jobs from home '),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: keyController,
                  decoration: InputDecoration(
                    hintText: 'Search a job',
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        BlocProvider.of<SearchBloc>(context)
                            .add(FindEvent(key: keyController.text));

                        //Navigator.pushNamed(context, '/catalogue');
                        // Navigator.pushNamed(context, '/h');
//Navigator.push(context, MaterialPageRoute(builder: (_) { return SearchProducts(keyController.text);  }));
                        //  Navigator.of(context).pushNamed('/catalogue');
                        Navigator.pushReplacement(context,
                         //'/SearchProducts',
                            //arguments: keyController.text);
                        //setstate
                        MaterialPageRoute(builder: (BuildContext context) 
                        => SearchOffres(keyController.text)));
                      },
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categories',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                //Text('See All',
                //    style: TextStyle(fontSize: 10, color: Colors.red)),
                // MaterialButton(
                InkWell(
                  // backgroundColor:Colors.white,
                  child: Text(
                    "View all",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    //Navigator.pushNamed(context, '/catalogue');
                    // Navigator.pushNamed(context, '/h');
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Catalogue();
                    }));
                    //  Navigator.of(context).pushNamed('/catalogue');
                  },
                  // color: Colors.red,
                )
              ],
            ),
            HorizontalList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent jobs',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: BlocBuilder<OffreBloc, OffreStates>(
                builder: (context, state) {
                  if (state is OffreInitialState) {
                    return CircularProgressIndicator();
                  } else if (state is LoadingOffresState1) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is FetchOffresSuccess1) {
                    return Offres(state.offres);
                  }
                },
              ),
            )
          ],
        ),
      ),
            bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),

      //  bottomNavigationBar: BottomNavigationBar(),
    );
  }

  Widget HorizontalList() {
    return Container(
        height: 100,
        child: BlocBuilder<CategoryBloc, CategoryStates>(
          builder: (context, state) {
            if (state is CatLoadingState1) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is CatFetchSuccess1) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  return Cat(state.categories[index]);
                },
              );
            } else {
              return Container();
            }
          },
        ));
  }

  Widget Cat(Category category)
  //(image_location, image_caption)

  {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          //Navigator.pushNamed(context, '/catalogue');
          // Navigator.pushNamed(context, '/h');
//Navigator.push(context, MaterialPageRoute(builder: (_) {return SingleProduct( p);  }));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return CategoryOffres(category);
              // print(category);
            }),
          );
          BlocProvider.of<CategoryBloc>(context)
              .add(CatDoFetchOffresEvent1(category: category));
        },
        child: Container(
          width: 100.0,
          child: ListTile(
              title: Image.network(
                //image_location,
                // "assets/images/p1.jpg",
                category.image,
                width: 50.0,
                height: 50.0,
              ),
              //

              //
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  category.title,
                  //image_caption,
                  style:TextStyle(fontSize: 12.0),
                ),
              )),
        ),
      ),
    );
  }

  //products widget
  Widget Offres(List<Offre> offre_list) {
    return GridView.builder(
        itemCount: offre_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_offre(
              offre_list[index],
              //['title'],
              //  product_list[index]
              //['featuredImage'],
              //   product_list[index]['oldPrice'],
              //  product_list[index]['price'],
            ),
          );
        });
  }

  // single_product
  Widget Single_offre(Offre o) {
    return Card(
      child: Material(
        child: InkWell(
          onTap: () {
            //Navigator.pushNamed(context, '/catalogue');
            // Navigator.pushNamed(context, '/h');
//Navigator.push(context, MaterialPageRoute(builder: (_) {return SingleProduct( p);  }));
 
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SingleOffre( offre: o);
            }));
          },
          // color: Colors.red,

          child: GridTile(
            child: Container(
              color: Colors.white70,
              child: ListTile(
                title: Text(
                  o.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  o.content.substring(0, 90),
                  
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600),
                ),
               
                
              ),
            ),
          
          ),
        ),
      ),
    );
  }
}
