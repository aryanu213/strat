import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:strats/Models/dataModel.dart';
import 'package:strats/user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data;
  List<DataModel> userList = [];

  Future<List<DataModel>> getUserApi() async {
    if (userList.isEmpty) {
      final response =
          await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
      data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        //print(response.body);
        for (Map i in data['data']) {
          print(i);
          userList.add(DataModel.fromJson(i));
          //print(userList[0].email.toString());
        }
        return userList;
      } else {
        return userList;
      }
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Api calling'),
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<DataModel>>(
                  future: getUserApi(),
                  builder: (
                    context,
                    snapshot,
                  ) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Text(
                        'loading...',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ));
                    } else {
                      return ListView.builder(
                          itemCount: userList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => userDetails(
                                              id: userList[index].id.toString(),
                                            )),
                                  );
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Card(
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width: 60.0,
                                                  height: 60.0,
                                                  color: Colors.transparent,
                                                  child: GestureDetector(
                                                    onTap: //open the image
                                                        () async {
                                                      await showDialog(
                                                          context: context,
                                                          builder: (_) => ImageDialog(
                                                              imageUrl: userList[
                                                                      index]
                                                                  .avatar
                                                                  .toString()));
                                                    },
                                                    child: CachedNetworkImage(
                                                      imageUrl: userList[index]
                                                          .avatar
                                                          .toString(),
                                                      placeholder: (context,
                                                              url) =>
                                                          const CircleAvatar(
                                                        backgroundColor:
                                                            Colors.amber,
                                                        radius: 150,
                                                      ),
                                                      imageBuilder:
                                                          (context, image) =>
                                                              CircleAvatar(
                                                        backgroundImage: image,
                                                        radius: 150,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8.0,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 3, 0, 0),
                                                      child: Text(
                                                        userList[index]
                                                            .email
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 3, 0, 0),
                                                      child: Text(
                                                        userList[index]
                                                                .firstName
                                                                .toString() +
                                                            ' ' +
                                                            userList[index]
                                                                .lastName
                                                                .toString(),
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ));
                    }
                  }),
            )
          ],
        ));
  }
}

class ImageDialog extends StatelessWidget {
  String imageUrl;

  ImageDialog({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    ));
  }
}
/*
class  ReusableRaw extends StatelessWidget {
  String title, value;
  ReusableRaw({Key? key, required this.title, required this.value}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}*/
