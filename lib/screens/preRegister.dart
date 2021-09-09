import 'package:flutter/material.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/register.dart';
import 'package:technoshop/screens/registerSte.dart';


class PreRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: 
      Center(
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
                                  """ Choose the type of account: """,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    color: kSecondaryColor,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.person_add_alt,
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
  }
}
