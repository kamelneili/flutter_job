import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/Auth_bloc.dart';
import 'package:technoshop/event/auth_event.dart';
import 'package:technoshop/repository/auth_repository.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/profile.dart';
import 'package:technoshop/screens/register.dart';
import 'package:technoshop/screens/registerSte.dart';
import 'package:technoshop/state/auth_state.dart';
//import 'package:newsapp/api/authentication_api.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  //AuthenticationAPI authenticationAPI = AuthenticationAPI();
  bool isLoading = false;

  bool loginError = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  AuthBloc authBloc;
  AuthRepository repo;
  String username;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
 static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor:  kPrimaryColor,
        centerTitle: true,
        title: Text('LOGIN'),
      ),
       body: SingleChildScrollView(
                child: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
          // TODO: implement listener
          if(state is LoginLoadingState){
            _drawLoading();
          }else
          if (state is UserLoginSuccessState) {
             Scaffold.of(context).showSnackBar(SnackBar(
  content: Text(
  "welcome",
  style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
  ),
  ));
            Navigator.pushNamed(context, '/home');
          }
          else if(state is LoginErrorState){
  Scaffold.of(context).showSnackBar(SnackBar(
  content: Text(
  "Password or email does not exist",
   style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
  ),
  ));
  }
      },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: (isLoading) ? _drawLoading() : _drawLoginForm(),
          ),
      ),
       ),
    );
  }

  Widget _drawLoginForm() {
    if (loginError) {
      return Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Login Error'),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    loginError = false;
                  });
                },
                child: Text(
                  'try Again',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
    }
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: email,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value.isEmpty
              ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)
              
              ){
                return 'Enter a valid email!';
              }
              return null;
            },
          ),
          SizedBox(
            height: 48,
          ),
          TextFormField(
               obscureText: true,

            controller: password,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(
            height: 48,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
                                                color: kPrimaryColor,

              onPressed: () {
    if (_formKey.currentState.validate()) {

                authBloc.add(LoginButtonPressed(
                    email: email.text, password: password.text));
            
                }
                  },
              child: Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Text("Don't have an account?"),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
                    color: kPrimaryColor,
              onPressed: () {

                //
                return 
                showDialog(
                  
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
                                """ Choose an account: """,
                                style: TextStyle(
                                  fontSize: 15.0,
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
                                    child: Text("Candidate",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue,
                                        )),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Register();
                }
                )
                );

                                    } //Navigator.of(context, rootNavigator: true).pop()

                                    ),
                                FlatButton(
                                    child: const Text("Employer",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue,
                                        )),
                                    onPressed: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegisterSte();
                }
                )
                );
                                    } //Navigator.of(context, rootNavigator: true).pop()

                                    ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                );

                //

                
                 },
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),

//


//


            ),
          )
        ],
      ),
    );
  }

  Widget _drawLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
