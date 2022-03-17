import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:untitled/http_service.dart';
import 'package:untitled/product_model.dart';

class ProductController extends GetxController{
  Rx<ProductModel> productsModal = ProductModel().obs;
  RxBool progressing = false.obs;
  bool callApi = true;

  Future<void> onInit() async {
    loadProducts();
    // TODO: implement onInit
    super.onInit();
  }

  loadProducts() async {
    progressing.value = true;
    DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          callApi = true;
          break;
        case DataConnectionStatus.disconnected:
          callApi = false;
          break;
      }
    });
    productsModal.value = await ProductModel.productFromCache();
    if(callApi) {
      productsModal.value = await HttpService.getProductsOfSubCategory('1', 1);
      ProductModel.deleteCachedProduct();
    }
    ProductModel.saveProductToCache(productsModal.value);
    progressing.value = false;
  }

}