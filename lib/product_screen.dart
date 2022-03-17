import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/my_filled_button.dart';
import 'package:untitled/product_controller.dart';
import 'package:untitled/product_model.dart';

class ProductScreen extends StatelessWidget {
  ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products', style: TextStyle(color: Colors.black),),),
      body: Obx(() => controller.progressing.value
          ? const Center(child: CircularProgressIndicator(),)
          : ListView.builder(
              shrinkWrap: true,
              itemCount: controller.productsModal.value.products.length,
              itemBuilder: (BuildContext context, int index) {
                return renderingProduct(index, controller.productsModal.value.products[index], context);
              },
            ),
      )
    );
  }

  renderingProduct(int index, Products product, BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(product.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    // Get.to(() => ImageViewScreen(imageUrl: product.photo, productName: product.title,), transition: Transition.rightToLeft);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: CachedNetworkImage(
                      imageUrl: product.photo,
                      height: 75,
                      width: 75,
                      fit: BoxFit.cover,
                      // placeholder: (context,url) => Container(
                      //   child: CircularProgressIndicator(
                      //     value: 15,
                      //     valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                      //   ),
                      // ),
                    )
                  ),
                ),
                const SizedBox(width: 15,),
                Container(
                  width: size.width*0.58,
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(child: Text(product.shortDetails, style: const TextStyle(fontSize: 14, color: Colors.black54), maxLines: 3,)),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: product.discount == "0"
                              ? Text(product.salePrice, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
                              : Row(
                                  children: [
                                    Text(product.discountedPrice, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),),
                                    const SizedBox(width: 10,),
                                    Text(product.salePrice, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough, color: Colors.black45),)
                                  ],
                                )
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              product.status == '0'
                                ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.deepOrangeAccent,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text('Out of Stock',style: TextStyle(
                                      color: Colors.white
                                  ),),
                                ))
                                : MyFilledButton(
                                  txt: 'Add to cart',
                                  fontSize: 14,
                                  height: 25,
                                  width: Get.width * 0.25,
                                  color: Colors.orange,
                                  borderRadius: 0,
                                  ontap: (){
                                    // Get.bottomSheet(renderBottomSheetForAddToCart(index, productController.productsModal.value.products[index]));
                                  },
                              ),
                              const SizedBox(width: 10,),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
