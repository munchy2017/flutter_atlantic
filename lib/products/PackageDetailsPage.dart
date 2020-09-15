import 'package:flutter/material.dart';
import 'Packages.dart';

class PackageDetailsPage extends StatelessWidget {
  final Packages packages;
  const PackageDetailsPage(this.packages);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(packages.packageName),
      ),
      body: Column(
        children: <Widget>[
          Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 260.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          packages.image_url)
                  )
              )
          ),
          SizedBox(height: 10.0,),
          Padding(
              padding: EdgeInsets.only(left: 8.0,right:8.0),
              child:Text(packages.packageDescription,style: TextStyle(fontSize: 16.0),)),
        ],),

    );
  }
}