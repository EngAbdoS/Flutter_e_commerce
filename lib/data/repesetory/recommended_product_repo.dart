import 'package:ecommirce/data/api/api_client.dart';
import 'package:ecommirce/utils/app_constans.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList()async{

    return await apiClient.getData(AppConstans.RECOMMENDED_PRODUCT_URI);//end point


  }
}