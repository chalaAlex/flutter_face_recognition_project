import 'package:flutter/material.dart';
import 'HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false));
}
