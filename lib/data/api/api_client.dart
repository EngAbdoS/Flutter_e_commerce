import 'package:ecommirce/utils/app_constans.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseURL;

  late Map<String, String> _mainheaders;

  ApiClient({required this.appBaseURL}) {
    baseUrl = appBaseURL;
    timeout = Duration(seconds: 30);
    token=AppConstans.TOKEN;
    _mainheaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response>getData(String uri,)async{
    try{

      Response response=  await get(uri);//uses http
      print("راح يجيب الداتا 🙂");
      //print(response.status);
      return response;
    }catch(e){ print(" 😒مجبهاش");
      return Response(statusCode: 1,statusText: e.toString());

    }


  }


}
