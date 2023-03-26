import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/dataModel.dart';

class userDetails extends StatelessWidget {
  String id;

  userDetails({Key? key, required this.id}) : super(key: key);

  var data;
  List<DataModel> userList = [];

  Future<List<DataModel>> getUserApi() async {
    print(id);
    if (userList.isEmpty) {
      final response =
      await http.get(Uri.parse("https://reqres.in/api/users/" + id));
      data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print(response.body);
        userList.add(DataModel.fromJson(data['data']));
        //print(userList[0].email.toString());

        return userList;
      } else {
        return userList;
      }
    }else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('UserInfo'),
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
                      return Container(
                        height: 200,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            height: 200,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 60.0,
                                      height: 60.0,
                                      color: Colors.transparent,
                                      child: CachedNetworkImage(
                                        imageUrl: userList[0].avatar.toString(),
                                        placeholder: (context, url) =>
                                            const CircleAvatar(
                                          backgroundColor: Colors.amber,
                                          radius: 150,
                                        ),
                                        imageBuilder: (context, image) =>
                                            CircleAvatar(
                                          backgroundImage: image,
                                          radius: 150,
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
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 3, 0, 0),
                                          child: Text(
                                            userList[0].email.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 3, 0, 0),
                                          child: Text(
                                            userList[0].firstName.toString() +
                                                ' ' +
                                                userList[0].lastName.toString(),
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            )
          ],
        ));
  }
}
