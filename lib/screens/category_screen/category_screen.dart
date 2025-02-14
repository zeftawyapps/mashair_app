import 'package:JoDija_view/util/app_settings/settings_inherted.dart';
import 'package:JoDija_view/util/data_souce_bloc/feature_data_source_state.dart';
import 'package:JoDija_view/util/navigations/navigation_service.dart';
import 'package:JoDija_view/util/navigations/web_route.dart';
import 'package:JoDija_view/util/widgits/collections_widgets/grid_view_model.dart';
import 'package:JoDija_view/util/widgits/collections_widgets/list_view_model.dart';
import 'package:JoDija_view/util/widgits/data_source_bloc_widgets/data_source_bloc_builder.dart';

 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Mashair/bloc/prod_bloc.dart';
import 'package:Mashair/consts/views/colors.dart';
import 'package:Mashair/data/category.dart';
import 'package:Mashair/data/product.dart';
import 'package:Mashair/screens/card_drow/mobile/card_draw.dart';
import 'package:Mashair/widgets/side_bar.dart';
import 'package:mashir_service/data/model/home_data.dart';

import '../../consts/views/assets.dart';
import '../../data/howe_models/categ.dart';
 import '../../data/shared_category.dart';
import 'assets.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  static const routeName = '/category';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  List<CategoryHome>list = [];
  String id = "";
  String name = "";
  String lan = "";
 late  ProductBloc productBloc = ProductBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = SharedCategory().list;
    WebRouteUrlSplitter ? d = NavigationService()
        .argumants! as WebRouteUrlSplitter;
    id = d.pram!['id']!;

      lan = d.pram!['lan']!;
    name = lan == "ar"? "العرض" :  "Offer" ;
    productBloc = BlocProvider.of<ProductBloc>(context);
    // String  lang  = SettingChangeLestner.of(context).state.language??"ar";

    productBloc.getProductsList(id ,  lan  );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: SideBar(),
      endDrawer: SideBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                alignment: Alignment.center,
                width: 200.w,
                height: 150.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 30.sp,
                            color: Colors.black,
                          ),
                        )),
                    Expanded(
                      flex: 4,
                      child: Text(

                        '$name',
                        textAlign: TextAlign.center,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                      ),
                    ),
                    Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _scaffoldkey.currentState!.openEndDrawer();
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.menu,
                                size: 30.sp,
                                color: Colors.black,
                              )),
                        )),
                  ],
                ),
              ),
              Container(
                height: 60.h,
                child: ListViewModel<CategoryHome>(
                  scrollDirection: Axis.horizontal,
                  data: list,
                  listItem: (index, data) {
                    int index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          name = lan == "ar"?data.name : data.nemeEn;
                        });
                         productBloc.getProductsList(data.id!  ,  lan  );
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        margin:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                          image: DecorationImage(
                            image: NetworkImage(data!.image!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: BlocBuilder<ProductBloc,  FeaturDataSourceState<ProductViewDataModel> >(

                    builder: (context, state) {
                      return state.listState.maybeWhen(orElse: () {return Container() ; }, success: (data) {


                        return GridViewModel<ProductViewDataModel>(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                            childAspectRatio: .7,
                          ),
                          data:  data!,
                          listItem: (index, data) {
                            bool is2deveded = index % 2 != 0;
                            double paddeng = 30;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)   {
                                 return CardDrawing(data : data  ,);
                                }) );
                              },
                              child: Container(


                                margin: is2deveded
                                    ? EdgeInsets.only(top: paddeng)
                                    : EdgeInsets.only(bottom: paddeng),
                                decoration: BoxDecoration(
                                  // add shadow
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 5), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(data.image!),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            );
                          },
                        );

                      });


                    },
                  )

              ),
            ],
          ),
        ),
      ),
    );
  }
}
