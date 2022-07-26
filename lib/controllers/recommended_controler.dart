import 'package:ecommirce/data/repesetory/recommended_product_repo.dart';
import 'package:ecommirce/models/products_model.dart';
import 'package:get/get.dart';



class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recomendedproductlist = [];

  List<dynamic> get recomendedproductlist => _recomendedproductlist;
  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;
  Future<void> getRecommendedrProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    //print("step1");
    //print(json.decode(response.body));
    if (response.statusCode == 200) //successful
        {
      print("recommended 🤸 جاب الداتا");
      _recomendedproductlist = [];
      _recomendedproductlist.addAll(Product.fromJson(response.body).products);
      print(_recomendedproductlist);
      _isLoaded=true;
      update();
    } else {

      print("recommendedمفيش");

    }
  }
}
