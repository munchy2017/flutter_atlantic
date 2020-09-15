import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(Claims());

class Claims extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atlantic',
      theme: ThemeData(
        primaryColor: Color(0xFF00B8D4),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedCurrency, selectedType;


  // Boolean variable for CircularProgressIndicator.
  bool visible = false ;

  // Getting value from TextField widget.
  final policyNoController = TextEditingController();
  final reasonController = TextEditingController();
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  List<String> _package_type = <String>[
    'Funeral Policies',
    'Funeral Arrangements',
    'Cremations',
    'Cash Funerals',
    'Tombstones'
  ];

  Future claims() async{

    // Showing CircularProgressIndicator.
    setState(() {
      visible = true ;
    });

    // Getting value from Controller
    String policy_number = policyNoController.text;
    //GlobalKey<FormState> package_type = _formKeyValue ;
    String packageType=selectedType;
    String reason = reasonController.text;

    // SERVER LOGIN API URL
    var url = 'http://10.0.2.2/apps/Atlantic_Dashboard/app_api/claims.php';

    // Store all data with Param Name.
    var data = {'policy_number': policy_number, 'package_type' : packageType,'reason':reason};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var encodeFirst = json.encode(response.body);
    //var message = jsonDecode(response.body);
    // var encodeFirst = json.encode(res.body);
    var message = json.decode(encodeFirst);

    // If Web call Success than Hide the CircularProgressIndicator.
    if(response.statusCode == 200){
      setState(() {
        var visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
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
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                FontAwesomeIcons.angleLeft,
                color: Colors.white,
              ),
              onPressed: () {}),
          title: Container(
            alignment: Alignment.center,
            child: Text("Claim Form",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
          /*actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.coins,
                size: 20.0,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ],*/
        ),


        body: Form(
          key: _formKeyValue,
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: <Widget>[
              SizedBox(height: 20.0),
              new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(
                      FontAwesomeIcons.portrait,
                      color: Color(0xFF0288D1),
                    ),
                    hintText: 'Enter your Policy Number',
                    labelText: 'Policy Number',
                  ),
                  keyboardType: TextInputType.text,
                controller: policyNoController,
              ),


              SizedBox(height: 20.0),
              Row(
               // mainAxisAlignment: MainAxisAlignment.left,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.moneyBill,
                    size: 25.0,
                    color: Color(0xFF0288D1),
                  ),
                  SizedBox(width: 50.0),
                  DropdownButton(
                    items: _package_type
                        .map((value) => DropdownMenuItem(
                      child: Text(
                        value,
                        style: TextStyle(color: Color(0xFF0288D1)),
                      ),
                      value: value,
                    ))
                        .toList(),
                    onChanged: (selectedAccountType) {
                      print('$selectedAccountType');
                      setState(() {
                        selectedType = selectedAccountType;
                      });
                    },
                    value: selectedType,
                    isExpanded: false,
                    hint: Text(
                      'Choose Policy Type',
                      style: TextStyle(color: Color(0xFF0288D1)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40.0),







              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(
                    FontAwesomeIcons.envelope,
                    color: Color(0xFF0288D1),
                  ),
                  hintText: 'Enter Reason',
                  labelText: 'Reason For Claim',
                ),
               // keyboardType: TextInputType.emailAddress,
                controller: reasonController,
                keyboardType: TextInputType.multiline,

                maxLength: null,
                maxLines: null,
              ),


              SizedBox(
                height: 60.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                      color: Color(0xFF0288D1),
                      textColor: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Submit", style: TextStyle(fontSize: 24.0)),
                            ],
                          )),
                      onPressed: () {
                        claims();

                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                ],
              ),
            ],
          ),
        ));
  }
}

