import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:technoshop/utilities/api_utilities.dart';

import 'package:technoshop/models/category.dart';
import 'package:technoshop/models/offre.dart';
import 'package:technoshop/models/product.dart';

class CategoriesAPI {

 Future <List<Category>> fetchCategories() async{
   
   List<Category>categories=[];
       String all_categories_api = 'flutter/pfebac/technoshopapi/public/api/categories';
  String baseUrl = '192.168.1.20';

   Uri uri= Uri.http(baseUrl,'$all_categories_api');
   var response = await http.get(uri);
   if(response.statusCode==200){
     var jsondata=jsonDecode(response.body);
     var data=jsondata["data"];
     data.map((category)=>categories.add(Category.fromJson(category))).toList();
    //print(categories);
     return categories;
   }
 }
 //
 Future <List<Offre>> fetchPostsCategory(Category category) async{
   String i=category.id;
   print(i);
   List<Offre>offres=[];
       String all_categories_api = 'flutter/pfebac/technoshopapi/public/api/offres/categories/$i';
  String baseUrl = '192.168.1.20';

   Uri uri= Uri.http(baseUrl,'$all_categories_api');
   var response = await http.get(uri);
   if(response.statusCode==200){
     var jsondata=jsonDecode(response.body);
     var data=jsondata["data"];
     data.map((offre)=>offres.add(Offre.fromJson(offre))).toList();
   print(offres);
     return offres;
   }
 }
  


}