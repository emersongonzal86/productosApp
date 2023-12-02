import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-a20a2-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  //para saber si esta cargando los datos inicia en true porque inicia cargando datos
  //no se coloca final por que va esta variando entre true y false
  bool isLoading = true;

  ProductsService(){
    this.loadProducts();
  }

//TODO: <List<Product>>
  Future loadProducts() async {

    final url = Uri.https( _baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

   //cargamos el mapa como lista

   productsMap.forEach((key, value) {
    final tempProduct = Product.fromMap(value);
    tempProduct.id = key;
    this.products.add( tempProduct );
   });

   print(this.products[0].name);

  }


  
}
