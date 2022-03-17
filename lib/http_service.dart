import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/product_model.dart';


class HttpService {
  static Uri _uri = Uri.parse("https://karobareasy.com/app/app.php");

  static Future<ProductModel> getProductsOfSubCategory(
      String subCategoryID,int pageNo) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'sub_category_products': '1',
          'sub_category_id': '2',
          'page_no': pageNo.toString()
        },
      );
      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body)) ;

      } else {
        return null;
      }
    }
    catch (e) {
      return null;
    }
  }

}




