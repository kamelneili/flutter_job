import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/Cart_bloc%20.dart';
import 'package:technoshop/blocs/offre_bloc.dart';
import 'package:technoshop/blocs/product_bloc.dart';
import 'package:technoshop/models/offre.dart';
import 'package:technoshop/models/product.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technoshop/screens/login.dart';

class SingleOffre extends StatefulWidget {
  final Offre offre;
  //final Post post;

  SingleOffre({ this.offre});
  @override
  _SingleOffreState createState() => _SingleOffreState();
}

class _SingleOffreState extends State<SingleOffre> {
  List<int> ids = [];
  int position = 1;

  var description = Container(
      child: Text(
        "A style icon gets some love from one of today's top "
        "trendsetters. Pharrell Williams puts his creative spin on these "
        "shoes, which have all the clean, classicdetails of the beloved Stan Smith.",
        textAlign: TextAlign.justify,
        style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),
      ),
      padding: EdgeInsets.all(16));

  void initState() {
    //  BlocProvider.of<CartBloc>(context).add(DoFetchCartItemsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kBackgroundColor,

          centerTitle: false,
//backgroundColor: Color(0xFF332F43),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return HomePage();
              }));
            },
          ),
        ),
        body:
            BlocBuilder<OffreBloc, OffreStates>(builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.5),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      H(widget.offre),
                      Property(widget.offre),
                    ],
                  ),
                ),

                //
                Description(widget.offre)

                //
              ],
            ),
          );
        })

        //
        //
        );

    //
  }

//
  Widget Description(Offre o) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 1.5,
        vertical: kDefaultPadding / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description:",
            style: TextStyle(color: Colors.red, fontSize: 19.0),
          ),
          SizedBox(height:10),
          Text(
            widget.offre.content,
            style: TextStyle(color: Colors.black, fontSize: 19.0),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //Image.asset("images/p4.jpg"),
          //Container(),
          Image.asset(
            "images/bag_button.png",
            width: 27,
            height: 30,
          ),
        ],
      ),
    );
  }

  //
  Widget H(Offre offre) {
    return Container(
      child: Stack(
        children: <Widget>[
           Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNMoU7OtItDHrVIRk5WEogUFlg3zImbN8w3A&usqp=CAU",
             fit: BoxFit.cover,
             height: 300,
           ), 
              Row(
                  children: [
                    Text('Published on:'),
                    SizedBox(width: 15),
                    Text(
                      offre.createdAt.toString(),
                      style: TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
            
           //This
          // should be a paged
          // view.

//********************** */
          Positioned(
            right:60,
            width: 40,
            child: FloatingActionButton(
                      heroTag: null,

              elevation: 2,
              child: Icon(Icons.favorite),
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                int userId = pref.getInt('id');
                // print(userId);
                String token = pref.getString('token');
                // print(token);
                if (token == null) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Login();
                  }));
                } else {
                 
                  BlocProvider.of<CartBloc>(context)
                      .add(AddEvent(id: offre.id.toString()));
                  return showDialog(
                    context: context,
                    child: Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Container(
                        height: 200.0,
                        color: kBackgroundColor,
                        width: 400.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                """ New Job has been added to your favorites
                          """,
                                style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w600,
                                  color: kSecondaryColor,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.done_all_outlined,
                              size: 30,
                              color: Colors.green,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                    child: Text("View your favorites",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue,
                                        )),
                                    onPressed: () {
                                      BlocProvider.of<CartBloc>(context)
                                          .add(DoFetchCartItemsEvent());

                                      Navigator.pushNamed(context, '/card');
                                    } //Navigator.of(context, rootNavigator: true).pop()

                                    ),
                                FlatButton(
                                    child: const Text("No continue",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue,
                                        )),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    } //Navigator.of(context, rootNavigator: true).pop()

                                    ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  
                }
              },
              backgroundColor: Colors.redAccent,
            ),
            bottom: 0,
          ),
        ],
      ),
    );
  }

//
  Widget Property(Offre offre) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Row(
                children: [
                  Text(
                    "Title:",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width:10),
                  Text(
                    widget.offre.title,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                      color: kSecondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
