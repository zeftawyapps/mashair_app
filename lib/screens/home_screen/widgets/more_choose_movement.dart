
import 'package:JoDija_view/util/view_data_model/base_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Mashair/consts/views/assets.dart';
import 'package:mashir_service/data/model/home_data.dart';

import '../../../data/product.dart';
import '../../card_drow/mobile/card_draw.dart';
import '../../category_screen/assets.dart';
class CenteredListMoveView extends StatelessWidget {
  CenteredListMoveView({ required this.data});

  double width = 133.w;

  List<FavorProduct> data;

  double _calculateScale(int index, double scrollOffset, BuildContext context) {
    double viewportWidth = 370; // Adjust viewport width as needed
    double itemWidth = width; // Adjust item width as needed

    final centerOfItem = (index * itemWidth) + (itemWidth / 2);
    final distanceFromCenter = (scrollOffset + viewportWidth / 2) -
        centerOfItem;

    final scale = 1 - (distanceFromCenter.abs() / viewportWidth);
    return scale;
  }


  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return ListView.builder(
      controller: _scrollController, // Pass the controller here
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _scrollController,
          builder: (context, child) {
            final offset = _calculateScale(
                index, _scrollController.position.pixels, context);
            return Transform.scale(
                scale: offset,
                child: GestureDetector(
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
                )
            );
          },
        );
      },
    );
  }


}