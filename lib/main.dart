import 'package:financial_app/Claims.dart';
import 'package:financial_app/ClaimsT.dart';
import 'package:financial_app/Logregister.dart';
import 'package:financial_app/Payments.dart';
import 'package:financial_app/Products.dart';
import 'package:financial_app/Support.dart';
import 'package:financial_app/authentication/Login.dart';
import 'package:financial_app/authentication/UserAuthentication.dart';
import 'package:financial_app/home.dart';
import 'package:financial_app/products/PackagesPage.dart';
import 'package:financial_app/transfer.dart';

import 'package:flutter/material.dart';

import 'Users.dart';

void main() => runApp(MaterialApp(
      title: 'Atlantic App',
      debugShowCheckedModeBanner: false,
      home: Logregister(),
    ));
