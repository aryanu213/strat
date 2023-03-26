import 'package:flutter/material.dart';
import 'package:strats/main.dart';

import 'home.dart';

class splash extends StatefulWidget {
  const splash ({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState(){
      super.initState();
      _navigateHome();
  }

  _navigateHome()async{
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "myhomepage")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Image.asset("assets/images/android.png", height: 200,),
        ),
      )
    );
  }
}
