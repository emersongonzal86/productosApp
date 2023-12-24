import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;

// importantisimo este producto debe ser una copia y no el mismo valor del arreglo de productos, porque sino hariamos
//modificaciones al mismo elemento ya que todos los elementos pasan por referencia
  ProductFormProvider( this.product);

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

}