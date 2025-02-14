
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:mashir_service/data/model/home_data.dart';
import '../../../data/product.dart';
import '../../card_drow/mobile/card_draw.dart';

class CenteredListView extends StatelessWidget {
  CenteredListView({ required this.data});

  double width = 150.w;

  List<FavorProduct> data;



  @override
  Widget build(BuildContext context) {

    return ListView.builder(

      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return   GestureDetector(
                  onTap: () {
                    ProductViewDataModel prodData = ProductViewDataModel(
                      id: data[index].id,
                      cardData: data[index].data,
                      image: data[index].image, name: 'data',
                    );
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return CardDrawing(data: prodData);
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: width,
                      height: 100,
                      decoration: BoxDecoration(
                        // add image
                        image: DecorationImage(
                          image: NetworkImage(data[index].image),
                          //   image:  AssetImage( HomeAssets.category1),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        // add shadow
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 0.5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ),
                );


      },
    );
  }


}