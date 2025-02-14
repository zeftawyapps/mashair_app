import 'package:JoDija_view/util/navigations/navigation_service.dart';
import 'package:JoDija_view/util/shardeprefrance/shard_check.dart';
import 'package:Mashair/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Mashair/consts/views/assets.dart';
import 'package:Mashair/consts/views/icons/inputs_icons.dart';
import 'package:Mashair/screens/idea_screen/idea_screen.dart';
import 'package:Mashair/screens/profile_screen/profile_screen.dart';

import '../loclization/app_localizations.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        width: MediaQuery.of(context).size.width * 0.7,
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    )
                  ),
                  Container(
                    width: 200.w,
                    height: 200.h ,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(MyAsset.imglogo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ) ,

                ],
              ),
            ),
            _buildDrawerItem(context,  Translation().translate().SideBareProfile ,  MyAsset.userIcon,
            ProfileScreen.routeName
            )
            ,
            _buildDrawerItem(context,   Translation().translate().SideBareSuggestion ,  MyAsset.ideaIcon, IdeaScreen.routeName ),
            _buildDrawerItem(context,  Translation().translate().SideBareContactUs,  MyAsset.sendIcon, ""),
            _buildDrawerItem(context,   Translation().translate().SideBareLogOut,  MyAsset.outIcon, ""   , onTap: _logOut),
          ],
        ));
  }

  Widget _buildDrawerItem(BuildContext context, String title, String icon, String navigateTo
      // add call back function
      , {Function(BuildContext c )? onTap}
      ) {
    return ListTile(
      title: Row(
        children: [
          SvgPicture.asset(
            icon,
            color: Theme.of(context).primaryColor,
            width: 30,
            height: 30,
          ),
          SizedBox(width: 10),
          Text(title , style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 15.sp),)
        ],
      ),
      onTap: () {

        if (navigateTo == "") {

          if (onTap != null) {
            onTap(context);
            return;
          }

          Navigator.pop(context);
          return  ; }
         NavigationService().navigateToPage(path: navigateTo);
      },
      subtitle: Divider(),
    );
  }


    _logOut(BuildContext context  ) {
    SharedPrefranceChecking sharedPrefranceChecking =
    SharedPrefranceChecking();
sharedPrefranceChecking.clearDataInShardRefrace() ;
// navigat to splash screen and clear the stack
  Navigator.pushNamedAndRemoveUntil( context  , Splashscreen.routeName, (route) => false);
    // add the log out function
  }



}
