import 'package:flutter/cupertino.dart';

class Menu {
  final String MenuId;
  final String Name;
  final double Price;
  final String Desc;
  final Image Img;

  Menu({this.Desc, this.MenuId, this.Name, this.Price, this.Img});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      MenuId: json['MenuID'],
      Name: json['Name'],
      Price: json['Price'],
      Desc: json['Desc'],
      Img: json['Img'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'MenuID': MenuId,
      'Name': Name,
      'Price': Price,
      'Desc': Desc,
      'Img': Img,
    };
  }
}
