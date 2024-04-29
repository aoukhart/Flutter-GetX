import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:products/model/products_model.dart';

class ProductController extends GetxController{
  var isLoad = true.obs;
  var products = RxList<Product>();
  var selectedProduct = Product().obs;
  @override
  void onInit(){
    fetchProducts();
    super.onInit();
  }

  void updateSelectedProduct(Product prod){
    selectedProduct.value = prod;
  }
  void fetchProducts() async{
    try {
      var res = await getProducts();
      // res.forEach((element) {
      //   print(element.id);
      //   print(element.brand);
      //   print(element.title);
      //   print("\n\n");
      // });
      products.value = res;
    } finally {
      isLoad(false);
    }
}

}