import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/ui/widgets/drawer.dart';

class MainPage extends StatelessWidget {




  // TODO  нужно создать экран где будет испоьзоваться этот  метод для создания нового чата и нужно использовать TextFormField
  createNewChat(BuildContext context, Map<String, dynamic> newChat) {
    firestore.collection("chats").add(newChat).then((value) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(

              child: Center(
                child: Text("сохранненно успешно"),
              ),
            );
          });
    });
  }

  createNewUser(BuildContext context, Map<String, dynamic> newUser) {
    Map<String, dynamic> newUserData = {
      "id": user.uid,
      "name": "имя",
    };
    firestore
        .collection("chats")
        .document(user.uid)
        .setData(newUserData)
        .then((value) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Center(
                child: Text("сохранненно успешно"),
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      drawerDragStartBehavior: DragStartBehavior.down,
      floatingActionButton: FloatingActionButton(
        child: Text("+"),
        onPressed: () {
          Map<String, dynamic> newChatData = {
            "title": "Новый чат",
            "message": "последнее сообщение чата"
          };
          createNewChat(context, newChatData);
        },
      ),
      appBar: AppBar(
        title: Text(
          "Наш Чат",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Container(
        child: Center(
          child:
               StreamBuilder(
                  stream: firestore.collection("chats").snapshots(),
                  builder: (BuildContext context, snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, item) {
                              return buildInkWell(context,
                                  title: snapshot.data.documents
                                      .elementAt(item)["title"]
                                      .toString(),
                                  message: snapshot.data.documents
                                      .elementAt(item)["message"]
                                      .toString(), onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    TextEditingController controller =
                                        TextEditingController();
                                    return Dialog(
                                      child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.7,
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(                                          child:                                              Text(snapshot.data.documents
                                                  .elementAt(item)["title"]) ),

                                              Expanded(flex: 7,
                                                child: StreamBuilder(
                                                  stream: firestore
                                                      .collection("chats")
                                                      .document(snapshot
                                                          .data.documents
                                                          .elementAt(item)
                                                          .documentID)
                                                      .collection("messages")
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<dynamic>
                                                              snapshot) {
                                                    return snapshot.hasData
                                                        ? ListView.builder(
                                                            itemCount: snapshot
                                                                .data
                                                                .documents
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    item) {
                                                              return Container(
                                                                  child: Text(snapshot
                                                                      .data
                                                                      .documents
                                                                      .elementAt(
                                                                          item)["message"]));
                                                            })
                                                        : Text("Загрузка");
                                                  },
                                                ),
                                              ),
                                              Expanded(

                                                child:  Container(
                                                height: 80,
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(child: TextField(
                                                      controller: controller,
                                                    ),),
                                                    FlatButton(
                                                        onPressed: () {
                                                          var data = snapshot
                                                              .data.documents
                                                              .elementAt(item);
                                                          newMessage(
                                                              context,
                                                              controller.text,
                                                              snapshot.data
                                                                  .documents
                                                                  .elementAt(
                                                                  item)
                                                                  .documentID);
                                                        },
                                                        child: Text(
                                                          "отправить",
                                                        ))
                                                  ],
                                                ),
                                              )
                                                ,)
                                            ],
                                          )),
                                    );
                                  },
                                );
                              });
                            })
                        : Text("идет загрузка");
                  },
                ),
        ),
      ),
    );
  }

  Widget buildInkWell(BuildContext context,
      {String message = "Последнее сообщение",
      String title = "",
      bool isPrivate = false,
      Null Function() onTap}) {
    if (isPrivate == null) {
      isPrivate = false;
    }
    return InkWell(
      onTap: onTap,
      splashColor: Colors.red,
      child: Container(
        margin: EdgeInsets.all(9.0),
        padding: EdgeInsets.all(9.0),
        decoration: BoxDecoration(
            color: Colors.white10,
            border: Border.all(color: Colors.greenAccent)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[Text(title), Text(message)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isPrivate
                  ? Icon(
                      Icons.lock,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  void getuser() {
    auth.currentUser().then((value) => user = value);
  }

  void newMessage(BuildContext context, String text, String chatID) {
    Map<String, dynamic> newMessage = {"author": user.uid, "message": text};
    firestore
        .collection("chats")
        .document(chatID)
        .collection("messages")
        .add(newMessage)
        .then((value) {

    });
  }
}
