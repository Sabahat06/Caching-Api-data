
import 'package:cached_map/cached_map.dart';
import 'package:get/get.dart';
class ProductModel {
  List<Products> products=[];
  List<Products> tempProducts=[];
  int totalPages=0;

  ProductModel({this.products, this.totalPages});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    return data;
  }

  static Future<ProductModel> productFromCache() async {
    Mapped cacheJson = await Mapped.getInstance();
    var cachedProduct = cacheJson.loadFile(cachedFileName: "Product");
    print("Product from cache: $cachedProduct");
    if(cachedProduct==null)
      return null;
    else
      return ProductModel.fromJson(cachedProduct);
  }

  /// member functions

  static Future<String> saveProductToCache(ProductModel productModel) async {
    Mapped cacheJson = await Mapped.getInstance();
    try{
      cacheJson.saveFile(file: productModel.toJson(), cachedFileName: "Product");
    }
    catch(e){
      return "Failed to save product due to: $e";
    }
    return "Save product to cache successfully ";
  }



  static Future<String> deleteCachedProduct() async {
    Mapped cacheJson = await Mapped.getInstance();
    try{
      cacheJson.deleteFile(cachedFileName: "Product");
    }
    catch(e){
      return "Some Problem accoured while deleting product File:$e";
    }
    return "Deleted product to cache successfully";

  }
}

class Products {
  String id;
  String title;
  String urduTitle;
  String shortDetails;
  String longDetails;
  String salePrice;
  String discount;
  String unitValue;
  String unitId;
  String photo;
  String categoryId;
  String subCategoryId;
  String status;
  String userId;
  RxInt quantity = 0.obs;
  String discountedPrice;
  List<Choices> choices;
  RxString colorId = ''.obs;
  RxString colorCode = ''.obs;

  Products(
      {this.id,
        this.title,
        this.urduTitle,
        this.shortDetails,
        this.longDetails,
        this.salePrice,
        this.discount,
        this.unitValue,
        this.unitId,
        this.photo,
        this.categoryId,
        this.subCategoryId,
        this.status,
        this.userId,
        this.quantity,
        this.choices,
        this.colorId,
        this.colorCode,
        this.discountedPrice,
      });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    urduTitle = json['urdu_title'];
    shortDetails = json['short_details'];
    longDetails = json['long_details'];
    salePrice = json['sale_price'];
    discount = json['discount'];
    unitValue = json['unit_value'];
    unitId = json['unit_id'];
    photo = json['photo'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    status = json['status'];
    userId = json['user_id'];
    discountedPrice = json['discounted_price'];
    quantity.value = json['quantity']??0;
    if (json['choices'] != null) {
      choices = new List<Choices>();
      json['choices'].forEach((v) {
        choices.add(new Choices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['urdu_title'] = this.urduTitle;
    data['short_details'] = this.shortDetails;
    data['long_details'] = this.longDetails;
    data['sale_price'] = this.salePrice;
    data['discount'] = this.discount;
    data['unit_value'] = this.unitValue;
    data['unit_id'] = this.unitId;
    data['photo'] = this.photo;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['quantity'] = this.quantity.value;
    data['discounted_price'] = this.discountedPrice;
    if (this.choices != null) {
      data['choices'] = this.choices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Choices {
  String id;
  String colorName;

  Choices({this.id,this.colorName});

  Choices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    colorName = json['color_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color_name'] = this.colorName;
    return data;
  }
}