import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/themes/custom_theme.dart';
import 'package:flutterapp/themes/themes.dart';
import 'package:flutterapp/ui/pages/ProfilePage.dart';

class MainDrawer extends StatelessWidget {
  void _changeTheme(BuildContext buildContext, {MyThemeKeys key}) {
    if (CustomTheme.instanceOf(buildContext).mythemeKey == MyThemeKeys.LIGHT)
      CustomTheme.instanceOf(buildContext).changeTheme(MyThemeKeys.DARK);
    else
      CustomTheme.instanceOf(buildContext).changeTheme(MyThemeKeys.LIGHT);
  }

  @override
  Widget build(BuildContext context) {
   return Drawer(
     child: Column (children: <Widget>[
       ListTile (title: Text( "Поменять тему"),
         onTap: () {
           _changeTheme(context);
         },
       ),
       ListTile (title: Text( "Профиль"),
         leading: Icon(Icons.account_circle) ,
         onTap: () {
           Navigator.of(context).pushNamed("/profile");
         },
       )

     ],),
   );
  }

}