import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/category_bloc%20.dart';
import 'package:technoshop/models/category.dart';
import 'package:technoshop/models/offre.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/navigation_drawer.dart';
import 'package:technoshop/screens/single_offre.dart';


class CategoryOffres extends StatefulWidget {
  final Category category ;
  //final Post post;
  CategoryOffres(this.category);
  @override
  CategoryOffresState createState() => CategoryOffresState();
}

class CategoryOffresState extends State<CategoryOffres> {
  //PostsAPI postsAPI = PostsAPI();
  
void initState() {
    
    super.initState();
BlocProvider.of<CategoryBloc>(context)
              .add(CatDoFetchOffresEvent1(category: widget.category));

  }
  @override
  
  Widget build(BuildContext context) {
    
    return Scaffold(
            backgroundColor: kBackgroundColor,

      appBar: AppBar(
                backgroundColor: kPrimaryColor,

        centerTitle: true,
        title: Text(widget.category.title),
      ),
            drawer: NavigationDrawer(),

          body:

           BlocBuilder<CategoryBloc, CategoryStates>(builder: (context, state) {
        if (state is CatLoadingState1) {
                    return Center(child: CircularProgressIndicator());
                  }else
        if (state is CatOffresFetchSuccess1) {
          return ListView.builder(
              itemCount: state.offres.length,
              itemBuilder: (context, index) {
                return Card(
                  child: drawSingleRow(state.offres[index]),
                );
              });
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
               // Text(widget.category.id),
                Hero(
                                         tag: offre.title,
 
                                  child: InkWell(
                  
                  
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
                  ),
                  //
                  
                  //
                )
              ],
            ),
          )
        ],
      ),
    );
  }






  
}
