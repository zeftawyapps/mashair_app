import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
class Loading extends StatefulWidget {
    Loading({super.key , this.isloading= false });
  bool isloading = false;
    static String category1 = "assets/img/laocal_image/c3.png";
    static String category2 = "assets/img/laocal_image/c2.png";
    static String category4 = "assets/img/laocal_image/c4.png";
    static String category5 = "assets/img/laocal_image/c5.png";
    static String category6 = "assets/img/laocal_image/c6.png";

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
List<String> categories = [Loading.category1, Loading.category2, Loading.category4, Loading.category5, Loading.category6];
late Timer timer;
int index = 0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   timer = Timer.periodic(Duration(seconds: 50), (timer) {
   setState(() {
     index = index + 1;
   });
   if (index == categories.length) {
     index = 0;
   }
 });

      setState(() {
        index ++;
        if (index == categories.length) {
          index = 0;
        }
      });

      }



@override
void dispose() {
  // TODO: implement dispose
  super.dispose();
  timer.cancel();
}
    @override
  Widget build(BuildContext context) {
    return   Container(

      height: widget.isloading?  MediaQuery.of(context).size.height : 0,
      width: widget.isloading ? MediaQuery.of(context).size.width :0,
       child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
       decoration: BoxDecoration(
         color: widget.isloading? Colors.black.withOpacity(0.5): Colors.transparent,

       ),
         child: Center(
           child: Image.asset(categories[index] , height: 100, width: 100,),
         ),
      ),
    )  ;
  }
}
