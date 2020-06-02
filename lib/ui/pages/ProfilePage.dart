import 'dart:isolate';

import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/funcs/fireStorage.dart';
import 'package:flutterapp/ui/widgets/drawer.dart';

import '../../main.dart';

class  ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Isolate isolate;
  String photoUrl;

  @override
  void initState() {
    firestore.collection("users").document(user.uid).snapshots().listen((event) {
      if (event.data ==null) return;
      setState(() {
        photoUrl = event.data["photoURL"];
      });

    });
    super.initState();
  }

  getAndSaveAvatar() {
    uploadUserAvatar(user.uid, isolate);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold (
      appBar: AppBar( title: Text("Профиль"),),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlatButton(onPressed: () {
                getAndSaveAvatar();
        }          ,
                child: Container( width: 100,
                  height: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(fit: BoxFit.cover,
                        alignment: Alignment.center,
                        image: FirebaseImage("gs://myflutterlessons.appspot.com"+ photoUrl)

                    )


                ),


                 ),
              )

        ],), ),
      )


    );

    throw UnimplementedError();
  }
}