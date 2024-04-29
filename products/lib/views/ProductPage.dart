import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:products/Controller/product_controller.dart';
import 'package:products/model/products_model.dart';

class ProductPage extends StatelessWidget {
final ProductController _controller = Get.put(ProductController());
final TextEditingController _DropDownText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Center(
        child: _controller.isLoad.value ? 
        const CircularProgressIndicator()
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownMenu(
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))
            ),
            width: Get.width*0.8,
            menuHeight: Get.height*0.4,
            hintText: "Select a product",
            // label: Text("Select a product"),
            controller: _DropDownText,
            enabled: true,
            // trailingIcon: ,
            leadingIcon: _controller.selectedProduct.value.id == null ? null :
             IconButton(onPressed: () {
              _DropDownText.text = "";
              _controller.updateSelectedProduct(Product());
            },icon: const Icon(Icons.clear, size: 15,)),
            dropdownMenuEntries: 
              List<DropdownMenuEntry<Product>>.from(_controller.products.map((element) => DropdownMenuEntry(value: element, label: element.title!))),
            onSelected: (value) {
              _controller.updateSelectedProduct(value!);
              _DropDownText.text = value.title!;
            },
            ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              
              onPressed: (){
                if (_controller.selectedProduct.value.id == null){
                  Get.showSnackbar(
                   const GetSnackBar(
                      message: "Choose a product before submitting",
                      margin: EdgeInsets.all(10),
                      borderRadius: 20,
                      duration: Duration(seconds: 2),
                    )
                  );
                }else{
                  Get.defaultDialog(
                    title: "Product",
                    titleStyle: const TextStyle(fontWeight: FontWeight.w600),
                    barrierDismissible: false,
                    textCancel: "X",

                    content: Column(
                      children: [
                        Text("Category :\n${_controller.selectedProduct.value.category!}", textAlign: TextAlign.center,),
                      DecoratedBox(decoration: BoxDecoration(
                        boxShadow: [
                          
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),child: 
                          Image.network(_controller.selectedProduct.value.thumbnail!,
                           height: Get.height*0.3,fit: BoxFit.fitHeight),
                        ),
                        Text(_controller.selectedProduct.value.brand!),
                        Text(_controller.selectedProduct.value.title!),
                        Text("Price : ${_controller.selectedProduct.value.price.toString()}"),
                        Text("Stock : ${_controller.selectedProduct.value.stock.toString()}"),
                        Text("Description :\n ${_controller.selectedProduct.value.description!}", textAlign: TextAlign.center,),
                        Text("Discount : ${_controller.selectedProduct.value.discount!}"),
                        Text("Rating : ${_controller.selectedProduct.value.rating.toString()}/5"),
                      ],
                    )
                  );
                  // print(_controller.selectedProduct.value.title);
                  // print(_controller.selectedProduct.value.thumbnail);
                }
              },
             child: Text("Submit")),
          )
        ],),
      ),)
    );
  }
}