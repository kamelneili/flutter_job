import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/Auth_bloc.dart';
import 'package:technoshop/blocs/category_bloc%20.dart';
import 'package:technoshop/blocs/offre_bloc.dart';
import 'package:technoshop/event/auth_event.dart';
import 'package:technoshop/repository/auth_repository.dart';
import 'package:technoshop/repository/offres_api.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/state/auth_state.dart';
//import 'package:newsapp/api/authentication_api.dart';
import 'package:dropdownfield/dropdownfield.dart';

class AddOffre extends StatefulWidget {
  @override
  _AddOffreState createState() => _AddOffreState();
}

class _AddOffreState extends State<AddOffre> {
  final _formKey = GlobalKey<FormState>();
  //AuthenticationAPI authenticationAPI = AuthenticationAPI();
  bool isLoading = false;

  bool loginError = false;
  TextEditingController content = TextEditingController();
  TextEditingController title = TextEditingController();

  TextEditingController _usernameController;
  TextEditingController _passwordController;
  // ignore: close_sinks
  OffreBloc offreBloc;
  OffresAPI repo;
  String username;
//
  String _mySelection;

String country_id;
  List<String> country = [
    "America",
    "Brazil",
    "Canada",
    "India",
    "Mongalia",
    "USA",
    "China",
    "Russia",
    "Germany"
  ];
  @override
  void initState() {
   // offreBloc = BlocProvider.of<OffreBloc>(context); //.add(StartEvent());
    TextEditingController content = TextEditingController();
    TextEditingController title = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text('Add Offer'),
      ),
      body: SingleChildScrollView(
              child: Padding(
          padding: EdgeInsets.all(16),
          child: _drawOffreForm(),
        ),
      ),
    );
  }

  Widget _drawOffreForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: title,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter title';
              }
              return null;
            },
          ),
          TextFormField(
            maxLines: 4,
            controller: content,
            decoration: InputDecoration(labelText: 'Content'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter content';
              }
              return null;
            },
          ),
          
          SizedBox(
            height: 48,
          ),
           BlocBuilder<CategoryBloc, CategoryStates>(
             builder: (context, state) {
               if (state is CatLoadingState1) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CatFetchSuccess1) {
                
          
               return Center(
        child: new DropdownButton(
                                    hint: Text('Select a category'),

          items: state.categories.map((item) {
            return new DropdownMenuItem(
              child: new Text(item.title),
              value: item.id.toString(),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _mySelection = newVal;
                                      print(newVal);

            });
          },
          value: _mySelection,

        ),
      );
      
        }
             },
           ),
           SizedBox(
            height: 150,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: kPrimaryColor,
              onPressed: () {
                BlocProvider.of<OffreBloc>(context).add(
                    AddOffreEvent(title: title.text, content: content.text,category:_mySelection));
                                Navigator.pushNamed(context, '/home');

              },
              // admin@gmail.com
              
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
