import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(Products());

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Our Products')
        ),
        body: JsonImageList(),
      ),
    );
  }
}

class Flowerdata {
  int id;
  String packageName;
  String packageDescription;
  String image;

  Flowerdata({
    this.id,
    this.packageName,
    this.packageDescription,
    this.image
  });

  factory Flowerdata.fromJson(Map<String, dynamic> json) {
    return Flowerdata(
        id: json['id'],
        packageName: json['packageName'],
        packageDescription: json['packageDescription'],
        image: json['image_url']

    );
  }
}

class JsonImageList extends StatefulWidget {

  JsonImageListWidget createState() => JsonImageListWidget();

}

class JsonImageListWidget extends State {

  final String apiURL = 'http://10.0.2.2/apps/Atlantic_Dashboard/app_api/getproducts.php';

  Future<List<Flowerdata>> fetchFlowers() async {

    var response = await http.get(apiURL);

    if (response.statusCode == 200) {

      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Flowerdata> listOfFruits = items.map<Flowerdata>((json) {
        return Flowerdata.fromJson(json);
      }).toList();

      return listOfFruits;
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }

  selectedItem(BuildContext context, String holder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(holder),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Flowerdata>>(
      future: fetchFlowers(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) return Center(
            child: CircularProgressIndicator()
        );

        return ListView(
          children: snapshot.data
              .map((data) => Column(children: <Widget>[
            GestureDetector(
              onTap: (){selectedItem(context, data.packageName);},
              child: Row(
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child:
                            Image.network(data.image,
                              width: 100, height: 100, fit: BoxFit.cover,))),

                    Flexible(child:
                    Text(data.packageName,
                        style: TextStyle(fontSize: 18)),



                    ),
                    Flexible(child:
                    Text(data.packageDescription,
                        style: TextStyle(fontSize: 18)),



                    )



                  ]),),

            Divider(color: Colors.black),

          ],))
              .toList(),
        );
      },
    );
  }
}