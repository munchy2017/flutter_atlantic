import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:financial_app/Claims.dart';
import 'package:financial_app/Payments.dart';
import 'package:financial_app/Products.dart';
import 'package:financial_app/Support.dart';
import 'package:financial_app/transfer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final VoidCallback signOut;
  HomePage(this.signOut);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }
  int currentIndex = 0;

  String selectedIndex = 'TAB: 0';

  String email = "", name = "", id = "", mobile = "";
  int _selectedItemIndex = 2;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      email = preferences.getString("email");
      name = preferences.getString("name");
      mobile = preferences.getString("mobile");
    });
    print("id :" + id);
    print("user :" + email);
    print("name :" + name);
    print("mobile :" + mobile);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xFF0288D1),
       // color: Color(0xFF0288D1),
        iconSize: 30.0,
//        iconSize: MediaQuery.of(context).size.height * .60,
        currentIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
          selectedIndex = 'TAB: $currentIndex';
//            print(selectedIndex);
          reds(selectedIndex);
        },

        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Website'),
              activeColor: Color(0xFF0288D1)),
          BottomNavyBarItem(
              icon: Icon(Icons.view_list),
              title: Text('Dashboard'),
              activeColor: Color(0xFF0288D1)),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              activeColor: Color(0xFF0288D1)),
        ],
      ),




      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 280,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF0097A7), Color(0xFF0288D1)]),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20.0, top: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.menu,
                            color: Colors.white,

                          ),
                          Text(
                            "ATLANTIC ",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          Icon(

                            Icons.lock_open,
                            color: Colors.white,
),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: Color(0XFF00B686),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 8,
                                    spreadRadius: 3)
                              ],
                              border: Border.all(
                                width: 1.5,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://images.pexels.com/photos/2167673/pexels-photo-2167673.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ""+ name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        //text: "Active ",
                                      text: email,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        /*children: [
                                          TextSpan(
                                              text: email,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,))
                                        ]*/
                                        ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.grey.shade100,
                  child: ListView(
                    padding: EdgeInsets.only(top: 75),
                    children: [
                      Text(
                        "Activities",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          buildActivityButton(
                              Icons.card_membership,
                              "MY POLICY",
                              Colors.blue.withOpacity(0.2),
                              Color(0xFF0288D1)
                          ),
                          buildActivityButton(
                              Icons.card_membership,
                              "CLAIMS",
                              Colors.blue.withOpacity(0.2),
                              Color(0xFF0288D1)),

                          buildActivityButton(
                              Icons.card_membership,
                              "PRODUCTS",
                              Colors.blue.withOpacity(0.2),
                              Color(0xFF0288D1)),

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildActivityButton(Icons.card_membership,
                              "PAYMENTS",
                              Colors.blue.withOpacity(0.2),
                              Color(0xFF0288D1)),

                          buildActivityButton(Icons.card_membership,

                              "QUERIES",
                              Colors.blue.withOpacity(0.2),
                              Color(0xFF0288D1)),


                          buildActivityButton(Icons.card_membership,

                              "CONTACT US",
                              Colors.blue.withOpacity(0.2),
                              Color(0xFF0288D1)),
                        ],


                      ),
                    /*  SizedBox(
                        height: 15,
                      ),
                      Text(
                        "MY PREMIUMS",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildCategoryCard(Icons.attach_money, "Funeral Cover",  120, 20),
                      SizedBox(
                        height: 20,
                      ),
                      buildCategoryCard(Icons.attach_money, "Funeral Cover", 430, 17),
                      SizedBox(
                        height: 20,
                      ),
                      buildCategoryCard(Icons.attach_money, "Funeral Cover", 120, 20),
                      SizedBox(
                        height: 20,
                      ),
                      buildCategoryCard(Icons.attach_money, "Funeral Cover", 120, 20),*/
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 175,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 160,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 8,
                      spreadRadius: 3,
                      offset: Offset(0, 10),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(50),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Policy Cover",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.monetization_on,
                                color: Color(0XFF00838F),
                              )
                            ],
                          ),
                          Text(
                            "\$2 170.90",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.black87),
                          )
                        ],
                      ),
                      Container(width: 1, height: 50, color: Colors.grey),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Montly Premium",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.monetization_on,
                                color: Color(0XFF00838F),
                              )
                            ],
                          ),
                          Text(
                            "\$2 170.90",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.black87),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You spent \$ 1,494 this month",
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Let's see the cost statistics for this period",
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Policy Status:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF00B686)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );




  }

  //  Action on Bottom Bar Press
  void reds(selectedIndex) {
//    print(selectedIndex);

    switch (selectedIndex) {
      case "TAB: 0":
        {
          //callToast("Tab 0");
        }
        break;

      case "TAB: 1":
        {
          //callToast("Tab 1");
        }
        break;

      case "TAB: 2":
        {
         // callToast("Tab 2");
        }
        break;
    }
  }

  /*callToast(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }*/



  GestureDetector buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 60,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 4, color: Colors.green)),
                gradient: LinearGradient(colors: [
                  Colors.green.withOpacity(0.3),
                  Colors.green.withOpacity(0.016),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
            : BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? Color(0XFF00B868) : Colors.grey,
        ),
      ),
    );
  }

  Container buildCategoryCard(
      IconData icon, String title, int amount, int percentage) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 85,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Color(0xFF00B686),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "\$$amount",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "($percentage%)",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              Container(
                height: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey.shade300),
              ),
              Container(
                height: 5,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Color(0XFF00B686)),
              ),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector buildActivityButton(
      IconData icon, String title, Color backgroundColor, Color iconColor) {
    return GestureDetector(



      //onTap: () => Navigator.of(context).push(
        //  MaterialPageRoute(builder: (BuildContext context) => TransferPage())),


    child: GestureDetector(
    onTap: (){


    if(title=='MY POLICY'){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TransferPage()),
    );
    }
    if(title=='PRODUCTS'){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  _launchURL2()),
      );
    }
    if(title=='CLAIMS'){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Claims()),
    );
    }
    if(title=='PAYMENTS'){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Payments()),
    );
    }
    if(title=='QUERIES'){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Support()),
    );
    }

    if(title=='CONTACT US'){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  _launchURL()),
      );
      }




    },

















      child: Container(
        margin: EdgeInsets.all(10),
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ));
  }



  _launchURL() async {
    const url = 'http://atlantic-funerals.co.za/contact-us/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL2() async {
    const url = 'http://atlantic-funerals.co.za/our-packages/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
