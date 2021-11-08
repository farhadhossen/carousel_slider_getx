import 'package:carousel_slider_getx/app/modules/home/providers/popular_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var lstPopular = List<dynamic>.empty(growable: true).obs;
  var isDataProcessing = false.obs;
  var isDataError = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPopular();
  }

  void getPopular(){

    try{
      isDataProcessing(true);
      PopularProvider().getPopuler().then((resp){
        lstPopular.clear();
        isDataProcessing(false);
        lstPopular.addAll(resp);
        isDataError(false);
      },
      onError: (err){
        isDataProcessing(false);
        isDataError(true);
      });
    }catch(exception){
      isDataProcessing(false);
      isDataError(true);
    }

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
