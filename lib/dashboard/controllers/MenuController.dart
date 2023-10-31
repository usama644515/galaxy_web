import 'package:flutter/material.dart';

class MenuControllers extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  var menueSelect;
  void SelectedMenue(var orderid) {
    menueSelect = orderid;
    notifyListeners();
  }

  var storestatus;
  void StoreStatus(var status) {
    storestatus = status;
    notifyListeners();
  }

  var productstatus;
  void ProductStatus(var status) {
    productstatus = status;
    notifyListeners();
  }

  var sellerid;
  void SellerId(var id) {
    sellerid = id;
    notifyListeners();
  }

  // for store to product screen
  var storeid;
  void StoreId(var id) {
    storeid = id;
    notifyListeners();
  }

  var orderId;
  void OrderId(var id) {
    orderId = id;
    notifyListeners();
  }

  var productId;
  void ProductId(var id) {
    productId = id;
    notifyListeners();
  }

  var data;

  void Sellerdetails(var _data) {
    data = _data;
    notifyListeners();
  }

  var productdata;

  void Productdetails(var _data) {
    productdata = _data;
    notifyListeners();
  }

  var support;

  void Support(var _support) {
    support = _support;
    notifyListeners();
  }

  var usertype;
  void UserTypeChat(_type) {
    usertype = _type;
    notifyListeners();
  }
  var ordersearchid;
  void OrderSearchid(_id) {
    ordersearchid = _id;
    notifyListeners();
  }


    var Food, Clothing, Gadgets, Fragrances, Gifts, Beauty, Honey, Desert;
  var FoodA, ClothingA, GadgetsA, FragrancesA, GiftsA, BeautyA, HoneyA, DesertA;

  var selectedMenu = [];
  List<String> filters = <String>[];
  int mainCateg = 1;
  var storeTags = {};
  var location;
  String? name;

  onMenuSelected(index, selectItem){
    selectedMenu.isEmpty|| selectedMenu.length < index+1? selectedMenu.add(selectItem): selectedMenu[index] = selectItem;
    notifyListeners();
  }

  filterSelected(value){
    filters.add(value);
    notifyListeners();
  }
  filterRemove(value){
    filters.removeWhere((String name) {
      return name == value;
    });
    notifyListeners();
  }
}
