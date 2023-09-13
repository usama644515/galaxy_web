import 'package:flutter/material.dart';

class menuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  // String selectedCategory = "Select a Category";

  // String selectedPCategory = "Clothes & Shoes ";

  // changeCategory(value){
  //   selectedCategory = value;
  //   notifyListeners();
  // }
  var menue = 'Home';
  navmenueSelect(value) {
    menue = value;
    notifyListeners();
  }
}
