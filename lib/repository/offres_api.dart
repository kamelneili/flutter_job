import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technoshop/models/offre.dart';
import 'dart:convert';
import 'package:technoshop/models/product.dart';
//import 'package:technoshop/utilities/api_utilities.dart';


class OffresAPI {

  List<Offre> offres=[];
  Future<List<Offre>> fetchOffres() async {
  //  List<PostModel> posts = [];
  String baseUrl = '192.168.1.20';
    String offres_api = 'flutter/pfebac/technoshopapi/public/api/offres';

   Uri uri= Uri.http(baseUrl,'$offres_api');

    var response = await http.get(uri);
    List<Offre> offres = List<Offre>();
    if( response.statusCode == 200 ){
      var jsonData = jsonDecode(  response.body);
      var data = jsonData["data"];
      data.map((offre)=>offres.add(
        Offre.fromJson(offre))).toList();
           //  data.map((post)=>posts.add(Post.fromJson(post))).toList();

      }
        //  print (products);

	  return offres;

    }
    //add offre
      Future<bool> addOffre(String title,String content,String category ) async {
  //  var id= cartId;
    String baseUrl = '192.168.1.20';
    String offre = 'flutter/pfebac/technoshopapi/public/api/offre';
    //   var token = data['data']['access_token'];
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    Uri uri = Uri.http(baseUrl, '$offre');
    print(category);
    var res = await http.post(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    }, body: {
      'title': title.toString(),
     // 'user_id': userId.toString()
     'category_id':category.toString(),
       'content': content.toString(),
    });
    print(res.statusCode);
    //final data = json.decode(res.body);
    if (res.statusCode == 201) {
      return true;
    //  print('true');
    } else {
      print('error to add offre');
    }
  }


    // search function
   Future <List<Offre>> searchOffres(key) async{
   
   List<Offre>offres=[];
      //List<Product>p=[];

       String all_categories_api = 'flutter/pfebac/technoshopapi/public/api/offres/$key';
  String baseUrl = '192.168.1.20';

   Uri uri= Uri.http(baseUrl,'$all_categories_api');
   var response = await http.get(uri);
   if(response.statusCode==200){
     var jsondata=jsonDecode(response.body);
     var data=jsondata["data"];
     data.map((offre)=>offres.add(Offre.fromJson(offre))).toList();
    //print(products);
    //print (key);
     return offres;
   }
 }


  

}