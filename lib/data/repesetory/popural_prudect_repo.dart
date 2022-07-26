import 'package:ecommirce/data/api/api_client.dart';
import 'package:ecommirce/utils/app_constans.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
final ApiClient apiClient;
PopularProductRepo({required this.apiClient});
Future<Response> getPopularProductList()async{

return await apiClient.getData(AppConstans.POPULAR_PRODUCT_URI);//end point


}
}