import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/offre_bloc.dart';
import 'package:technoshop/blocs/product_bloc.dart';
import 'package:technoshop/repository/offres_api.dart';
import 'package:technoshop/repository/products_api.dart';

class Offres extends StatefulWidget {
  @override
  _OffresState createState() => _OffresState();
}

class _OffresState extends State<Offres> {
  OffresAPI postsAPI = OffresAPI();
  OffreBloc bloc1;
  @override
  void initState() {
    super.initState();
        BlocProvider.of<OffreBloc>(context).add(DoFetchOffresEvent1());

  }
  var offre_list = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: offre_list.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_offre(
              offre_name: offre_list[index]['name'],
            ),
          );
        });
  }
}

class Single_offre extends StatelessWidget {
  final offre_name;
  
  Single_offre({
    this.offre_name,
   
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        child: InkWell(
          onTap: null,
          
          child: GridTile(
              child: Container(
                color: Colors.white70,
                child: ListTile(
                    leading: Text(
                      offre_name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    
                  
                ),
              ),
             ),
        ),
      ),
    );
  }
}
