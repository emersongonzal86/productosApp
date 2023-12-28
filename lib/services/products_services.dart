import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-a20a2-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;
  //para saber si esta cargando los datos inicia en true porque inicia cargando datos
  //no se coloca final por que va esta variando entre true y false
  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    this.loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    //cargamos el mapa como lista

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });

    this.isLoading = false;
    notifyListeners();

    return this.products;
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //es necesario crear
      await this.createProduct(product);
    } else {
      //actualizar
      await this.updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;
    //print( decodedData );

    //Actualizar el listado de productos
    final index =
        this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toJson());
    //final decodedData = resp.body;
    //print( decodedData );
    //lo convertimos en un mapa
    final decodedData = json.decode(resp.body);

//como el producto nuevo no tiene id debemos traerlo de la base de datos mediante el decodedData
    product.id = decodedData['name'];
    this.products.add(product);

    return product.id!;
  }
}
