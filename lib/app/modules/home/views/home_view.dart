import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Obx((){
        if(controller.isDataProcessing.value){
          return Center(
            child: Container(
              margin: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
          );
        }else{
          if(controller.isDataError.value){
            return FailureView(onPressed: ()=>controller.getPopular());
          }else{
            return CarouselSlider(
                items: generateSlider(),
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height

                )
            );
          }
        }
      }),
    );
  }

List<Widget> generateSlider(){

  List<Widget> imageSliders = controller.lstPopular.map((item){

    return Container(
      child: Container(
        margin: EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: InkWell(
            onTap: (){
              print(item['image_thumbnail_path']);
              print(item['network']);
            },
            child: CachedNetworkImage(
              imageUrl: item['image_thumbnail_path'],
              fit: BoxFit.cover,
              width: Get.width,
              placeholder: (context,url)=>Container(
                color: Colors.grey,
              ),
              errorWidget: (context,url,error)=>Icon(Icons.error, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
  ).toList();

  return imageSliders;
}
  
}



class FailureView extends StatelessWidget {
  const FailureView({
    Key? key,
    this.title = "Error",
    this.message = "Something went wrong",
    required this.onPressed}) : super(key: key);

  final String title, message;
  final VoidCallback  onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error,
            color: Colors.red,
            size: 150,
            ),
            SizedBox(height: 4,
            ),
            Text(
              title,
            style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 2,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 2,
            ),
            ElevatedButton(
              child: Text('Retry'),
              onPressed: onPressed, )
          ],
        ),
      ),
    );
  }
}

