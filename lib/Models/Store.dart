import 'package:flutter/material.dart';

class Store {
  final String StoreId;
  final String Name;
  final String Owner;
  final String StoreLocation;
  final Image Img;

  Store(
      {this.StoreLocation,
      @required this.StoreId,
      this.Name,
      this.Owner,
      this.Img});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      StoreId: json['StoreId'],
      Name: json['Name'],
      Owner: json['Owner'],
      StoreLocation: json['StoreLocation'],
      Img: json['Img'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'StoreID': StoreId,
      'Name': Name,
      'Owner': Owner,
      'StoreLocation': StoreLocation,
      'Img': Img,
    };
  }
}
