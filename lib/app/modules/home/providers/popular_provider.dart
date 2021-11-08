import 'package:get/get.dart';

import '../popular_model.dart';

class PopularProvider extends GetConnect {

  Future<List<dynamic>> getPopuler() async {

    try{
      final response = await get("https://episodate.com/api/most-popular?page=1");
      if(response.status.hasError){
        return Future.error(response.status);
      }else{
        return response.body['tv_shows'];
      }
    }catch (exception){
      return Future.error(exception.toString());
    }
  }

}
