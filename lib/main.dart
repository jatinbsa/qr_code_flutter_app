import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  String result="Hey there !";
  Future _scanQr() async{
    try{
      String qrReuslt=await BarcodeScanner.scan();
      setState(() {
             result=qrReuslt;
      });
    }on PlatformException catch(ex){
      if(ex.code==BarcodeScanner.CameraAccessDenied){
        setState(() {
          return "Camera permission was denied";
        });
      }
      else{
        setState(() {
          return "Unknown Error $ex";
        });
      }
    }on FormatException{
      setState(() {
         result="you pressed button before scanning";
      });
    }catch(ex){
      setState(() {
        return "Unknown Error $ex";
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("QR Code Scanner"),
      ),
      body: Center(
        child: Text("Hey There!",
          style: new TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _scanQr ,
          icon: Icon(Icons.camera_alt),
          label: Text("Scan")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

  }
}
