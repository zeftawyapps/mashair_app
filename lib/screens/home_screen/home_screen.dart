 import 'package:JoDija_view/util/app_settings/settings_inherted.dart';
import 'package:JoDija_view/util/app_settings/settings_model.dart';
import 'package:JoDija_view/util/navigations/navigation_service.dart';
import 'package:JoDija_view/util/widgits/collections_widgets/grid_view_model.dart';
import 'package:JoDija_view/util/widgits/data_source_bloc_widgets/data_source_bloc_builder.dart';
import 'package:Mashair/loclization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:Mashair/data/howe_models/categ.dart';
import 'package:Mashair/data/shared_category.dart';
import 'package:Mashair/screens/card_drow/mobile/card_draw.dart';
import 'package:Mashair/screens/category_screen/category_screen.dart';
import 'package:Mashair/screens/home_screen/widgets/more_choose.dart';
 import 'package:Mashair/widgets/loading2.dart';
import 'package:Mashair/widgets/loading3.dart';
import 'package:Mashair/widgets/side_bar.dart';
import 'package:mashir_service/data/model/home_data.dart';

import '../../bloc/landing_bloc.dart';
import '../../consts/views/assets.dart';
 import 'assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  late LandingBloc _landingBloc;
  List<String>imagesStr = [
    HomeAssets.category1,
    HomeAssets.category2,
    HomeAssets.category3,
    HomeAssets.category4,
    HomeAssets.category5,
    HomeAssets.category6,
    HomeAssets.category7,
    HomeAssets.category8,
    HomeAssets.category9,
  ];

  String lan = "en";
  Offer? offer;
 late  var  sitteng;
 bool isArabic = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _landingBloc = LandingBloc();

  }

  @override
  Widget build(BuildContext context) {
    sitteng  = SettingChangeLestner.of(context) ;

    lan   = sitteng.state.language!;
    isArabic = lan == "ar";
    return Scaffold(
      key: _scaffoldkey,
      drawer: SideBar(),
      endDrawer: SideBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child:
          DataSourceBlocBuilder(
            bloc: _landingBloc.bloc,
            success: (data) {
              List<CategoryHome> categoryHome =
              data!.data!.loadData.categorys.map((e) {
                return CategoryHome(name: e.name, image: e.image , id: e.id
                , nemeEn: e.nemeEn
                );
              }).toList();
              offer =    data.data.loadData.offer ;


              List<Fevortes> fevortes = data!.data!.loadData.favorPorducts
                  .map((e) => Fevortes(image: e.image , data: e.data , lan: e.lan))
                  .toList();

              List<Fevortes> listFevortesFilter = fevortes.where((element) => element.lan == lan).toList();

              SharedCategory().list = categoryHome;
              return    ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    alignment: Alignment.center,
                    width: 200.w,
                    height: 120.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: GestureDetector(
                              onTap: () {

              if(lan == "en") {
                sitteng.change(BaseSetting(language: "ar"));
              }else {
                sitteng.change(BaseSetting(language: "en"));
              }

                              },
                              child: Text(
                            lan =="ar" ?"English" :   "عربية",
                                style: TextStyle(fontSize: 15.sp
                                ,fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: 150.w,
                            height: 160.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(MyAsset.imglogo),
                                fit: BoxFit.cover,
                              ),
                            ),
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

                  GestureDetector(
                    onTap: (){
                      NavigationService().navigateToPageWithUrl(path: CategoryScreen.routeName, pram: {"id":  offer!.pramLink! ,"name":offer!.title  ,  "lan":lan } );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      alignment: Alignment.center,
                      width: 200.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(HomeAssets.panner1),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ) ,
                  SizedBox(
                    height: 7.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5 , vertical: 2),
                    child: Text(
                      Translation().translate().moreChoices!
                     ,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    height: 220.h,

                    child: CenteredListView(data: listFevortesFilter,),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                        return CardDrawing(data:  null  , isNew:  true ,
                        canUseAi: true ,
                        );
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 25, top: 3),
                      alignment: Alignment.center,
                      height: 125.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(HomeAssets.panner2),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  GridViewModel<CategoryHome>(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1.1.sp ,
                    ),
                    data: categoryHome,
                    listItem: (index, data) {
                      return GestureDetector(
                        onTap: () {
                          NavigationService().navigateToPageWithUrl(path: CategoryScreen.routeName, pram: {"id":  data.id! , "name":isArabic ? data.name :data.nemeEn , "lan":lan } );
                        },
                        child: Column(
                          children: [
                            Container(

                              width: 75.w,
                              height: 75.h,

                              decoration: BoxDecoration(

                                image: DecorationImage(
                                  image: NetworkImage(data.image!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text( isArabic ?  data.name!:data.nemeEn ,
                                  style: Theme.of(context).textTheme.titleSmall),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),

                  Visibility(
                    visible: true  ,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                          return CardDrawing(data:  null  , isNew:  true ,);
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        alignment: Alignment.center,
                        width: 200.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(HomeAssets.panner3),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ) ,
                ],
              ) ; ;
            },
            loading: () {
              return Container(child: Center(child: Loading2(color: Color(
                  0xffee53e0),)));
            },
            failure: (erro, r) {
              return  Container(child: Center(child: Loading3()));

            },
          ),



        ),
      ),
    );
  }
}
