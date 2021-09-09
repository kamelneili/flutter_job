import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technoshop/screens/catalogue.dart';
import 'package:technoshop/screens/home.dart';
import 'package:technoshop/screens/profile.dart';

import 'constants.dart';
import 'enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home,color:Colors.blue),

                  onPressed: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return HomePage();
                      }))),
              IconButton(
                icon: Icon(Icons.favorite,color:Colors.blue),
                onPressed: () {
                                        Navigator.pushNamed(context, '/card');

                },
              ),
              IconButton(
                //icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
                icon: Icon(Icons.dashboard,color:Colors.blue),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Catalogue();
                  }));
                },
              ),
              IconButton(
             icon: Icon(Icons.person,color:Colors.blue),

                  onPressed: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Profile();
                      }))),
            ],
          )),
    );
  }
}
