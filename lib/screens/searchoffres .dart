import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/category_bloc%20.dart';
import 'package:technoshop/blocs/search_bloc.dart';
import 'package:technoshop/models/offre.dart';
import 'package:technoshop/models/product.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/home.dart';
import 'package:technoshop/screens/navigation_drawer.dart';
import 'package:technoshop/screens/single_offre.dart';

class SearchOffres extends StatefulWidget {
   String k='';
  SearchOffres(this.k);
  @override
  _SearchOffresState createState() => _SearchOffresState();
}

class _SearchOffresState extends State<SearchOffres> {
  //PostsAPI postsAPI = PostsAPI();
  //Category category ;

  @override
  void initState() {
    BlocProvider.of<SearchBloc>(context).add(FindEvent(key: widget.k));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackgroundColor,

      appBar: AppBar(
              elevation: 0,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return HomePage();
            }));
          },
        ),
        backgroundColor: Colors.blue,
      ),
      drawer: NavigationDrawer(),
      body: BlocBuilder<SearchBloc, SearchStates>(builder: (context, state) {
       if (state is SearchLoadingState1) {
              return Center(child: CircularProgressIndicator());

       }else
       if (state is FindState) {
         if(state.offres.length!=0){

          return ListView.builder(
              itemCount: state.offres.length,
              itemBuilder: (context, index) {
                if(state.offres.length!=0){
 return Card(
                  child: drawSingleRow(state.offres[index]),
                );
                } 
                         

               
              });
        } else
         return Container(
                            color: Colors.red,
                            child:Center(child: Text("No job was found",
                              style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                            ))
                            
                            );
      }
        else {
          return Container(color: Colors.red);
        }
      }),
    );
    //

    //
  }

  Widget drawSingleRow(Offre offre) {
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
              width: 50,
              height: 124,
            ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(offre.title),
                InkWell(
                  
                  
                  
                  // backgroundColor:Colors.white,
                  // heroTag: Text("btn1"),
                 child: Container(
                   padding: EdgeInsets.symmetric(
                     horizontal: kDefaultPadding * 1, // 30 px padding
                     vertical: kDefaultPadding / 3, // 5 px padding
                   ),
                   decoration: BoxDecoration(
                     color: kSecondaryColor,
                     borderRadius: BorderRadius.circular(22),
                   ),
                   child: Row(
                     children: [
                       Text('see more...'),
                        Icon(Icons.arrow_right),

                     ],
                   ),
                 ),
                 
                  // color: Colors.red,
                
                  onTap: () {
                  //Navigator.pushNamed(context, '/catalogue');
                  // Navigator.pushNamed(context, '/h');
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return SingleOffre(offre:offre);
                  }));
                  //  Navigator.of(context).pushNamed('/catalogue');
                  },
                  // color: Colors.red,
                  
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
