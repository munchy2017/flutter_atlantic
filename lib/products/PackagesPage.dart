import 'dart:developer';

import 'package:flutter/material.dart';
import 'Packages.dart';
import 'CustomAppBar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PackageDetails.dart';

class PackagesPage extends StatefulWidget {
  PackagesPage({Key key}) : super(key: key);

  _BookDashboardState createState() => _BookDashboardState();
}

class _BookDashboardState extends State<PackagesPage> {
  List<Packages> packagedetails = [];
  Future<List<Packages>> _packageDetails() async {
    var data =await http.get("http://10.0.2.2/apps/Atlantic_Dashboard/app_api/getproducts.php");
    var jsonData = json.decode(data.body);
    //print('data: $jsonData');

    for (var bookval in jsonData) {
      Packages packages = Packages(bookval['packageName'], bookval['image_url'], bookval['packageAmount'],
          bookval['packageDescription']);
      packagedetails.add(packages);

    }
    return packagedetails;


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomAppBar(),
            FutureBuilder(
              future: _packageDetails(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {

                  return Container(
                    height: MediaQuery.of(context).size.height,
                    color: Color(0xfffF7F7F7),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PackageDetails(
                          snapshot.data[index],
                          snapshot.data[index].packageName,
                          snapshot.data[index].image_url,
                          snapshot.data[index].packageAmount,
                          snapshot.data[index].packageDescription,
                         // snapshot.data[index].bookviews,
                        );
                      },
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Text("Loading"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}