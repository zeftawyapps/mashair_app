import 'dart:io';

import 'package:JoDija_view/util/functions/launchers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Mashair/consts/views/assets.dart';
import 'package:Mashair/drow_engen/core/bloc/print_bloc/print_bloc.dart';
import 'package:Mashair/drow_engen/core/contrallers/drower_engen.dart';
import 'package:Mashair/screens/card_drow/mobile/print_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import '../../../drow_engen/core/tools/print_viewer.dart';
import '../../../loclization/app_localizations.dart';

class PrintEditScreen extends StatefulWidget {
  PrintEditScreen({
    super.key,
    required this.image,
    required this.engen,
    this.width = 1748,
    this.height = 2480,
  });
  DrowerEngen engen;
  Uint8List image;
  double width = 100;
  double height = 200;

  @override
  State<PrintEditScreen> createState() => _PrintEditScreenState();
}

class _PrintEditScreenState extends State<PrintEditScreen> {
  late DrawEnginePrintBloc bloc;
  bool isDouble = false;
  initState() {
    super.initState();
    bloc = context.read<DrawEnginePrintBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
            Translation().translate().ScreenPrintSetting,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Color(0xffF0E6FF),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: BlocListener<DrawEnginePrintBloc, PrintState>(
                  listener: (context, state) async {
                    if (state is DrawSaved) {
                      Uint8List image = state.image!;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrintScreen(
                                    image!,
                                  )));
                    }
                  },
                  child: Center(
                    // custom paint the image
                    child: AppMobilePrintViewer(

                      image: widget.image,
                      width:   widget.width,
                      height: widget.height ,
                      isDouble: isDouble,
                    ),
                  ),
                )),
            Expanded(
                flex: 3,
                child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isDouble = false;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  height: 120.h,
                                  margin: EdgeInsets.only(top: 10.h),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: !isDouble
                                            ? Color(0xff9a27d9)
                                            : Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 90.h,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                          color: Color(0xffC3A9CE),
                                          border: Border.all(
                                              color: Color(0xffF0E6FF),
                                              width: 10.w),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Translation().translate().ScreenPrintSingleCard,
                                                style:
                                                Theme.of(context).textTheme.titleSmall!,
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text("77*11",
                                                  style:   Theme.of(context).textTheme.titleSmall!),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isDouble = true;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  height: 120.h,
                                  margin: EdgeInsets.only(top: 10.h),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isDouble
                                            ? Color(0xff9a27d9)
                                            : Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 60.h,
                                          width: 90.w,
                                          decoration: BoxDecoration(
                                            color: Color(0xffF0E6FF),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50.h,
                                                width: 40.w,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffC3A9CE),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Container(
                                                height: 50.h,
                                                width: 40.w,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffC3A9CE),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Translation().translate().ScreenPrintDoubleCard,
                                                style:
                                                Theme.of(context).textTheme.titleSmall!,
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text("5*7",
                                                  style:  Theme.of(context).textTheme.titleSmall!),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                bloc.add(SaveFile(
                                    width: isDouble ? 1000 : 1500,
                                    height: 2000));
                              },
                              child: Container(
                                height: 50.h,
                                width: 140.w,
                                decoration: BoxDecoration(
                                  color: Color(0xff976D9D),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                  child: Text( Translation().translate().Print,
                                      style:   Theme.of(context).textTheme.titleSmall!.copyWith(
                                          color: Colors.white, fontSize: 20.sp)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
