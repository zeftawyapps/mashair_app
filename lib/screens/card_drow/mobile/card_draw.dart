import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:JoDija_view/util/data_souce_bloc/feature_data_source_state.dart';
import 'package:JoDija_view/util/functions/show_dialog.dart';
import 'package:JoDija_view/util/main-screen/screen-type.dart';
import 'package:Mashair/ai_configs.dart';
import 'package:Mashair/screens/card_drow/mobile/widgets/ai/ai_cubit.dart';
import 'package:Mashair/screens/card_drow/mobile/widgets/ai/ai_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Mashair/consts/views/assets.dart';
import 'package:Mashair/consts/views/colors.dart';
import 'package:Mashair/drow_engen/core/shapes/QR_image/image_shap.dart';
import 'package:Mashair/drow_engen/core/shapes/text/text_shap.dart';
import 'package:Mashair/screens/card_drow/mobile/print_edit.dart';
import 'package:Mashair/screens/card_drow/mobile/print_screen.dart';
import 'package:Mashair/screens/card_drow/mobile/widgets/board.dart';
import 'package:Mashair/screens/card_drow/mobile/widgets/layers/layers.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../../../../../drow_engen/core/bloc/main_bloc/main_bloc.dart';
import '../../../../../../../../drow_engen/core/interfaces/base_shap.dart';
import '../../../../../../../../drow_engen/core/models/layout.dart';

import '../../../app-configs.dart';
import '../../../bloc/prod_bloc.dart';
import '../../../data/product.dart';
import '../../../drow_engen/core/shapes/QR_image/text_editor.dart';
import '../../../drow_engen/core/shapes/text/text_editor.dart';
import '../../../drow_engen/core/shapes/text/text_property.dart';
import '../../../drow_engen/init.dart';
import '../../../loclization/app_localizations.dart';
import 'widgets/property/property.dart';
import 'widgets/tools_box/tool_box.dart';

class CardDrawing extends StatefulWidget {
  CardDrawing({super.key, this.data, this.isNew = false,
    this.canUseAi = false});

  ProductViewDataModel? data;
  bool isNew = false;
  bool canUseAi = false;
  static String routeName = "cardDraw";

  @override
  State<CardDrawing> createState() => _CardDrawingState();
}

class _CardDrawingState extends State<CardDrawing> {
  String name = "data";
  Color color = Color(0xff9e5757);
  DrawEngineMainBloc? bloc;
  AiCubit? aiCubit;
  ProductBloc? saveBloc;
  Uint8List? image;
  bool isLoad = false;
  bool isInited = false;
  bool islayer = false;
  bool isProperty = false;
  bool isTool = false;
  BaseShape? Selectedshape;
  bool isprint = false;
  int _buttonState = 0;
  List<BaseShape> shapes = [];

  initState() {
    init(loadPath: "assets/card.png");

    bloc = context.read<DrawEngineMainBloc>();
    aiCubit = context.read<AiCubit>();

    saveBloc = context.read<ProductBloc>();
    var layout = Layout(width: 250.h, height: 300.w);
    isInited = true;
    if (widget.data != null) {
      bloc!.add(OnLoad(data: jsonDecode(widget.data!.cardData!)));
      isInited = true;
    } else {
      List<BaseShape> shapes = [];
if (!widget.canUseAi) {
  TextShape textShape = TextShape(
    text: Translation().translate().writeYourFeelingsHere,
  );
  textShape.xPos = layout.width / 4;
  textShape.yPos = layout.height / 2;
  textShape.fontSize = 25;
  shapes.add(textShape);
}
      bloc!.add(
          MainInitialEventWithDefaultShapes(layout: layout, shapes: shapes));
      isInited = true;

      //
      // bloc!.add(MainInitialEvent(layout: layout));
      // isInited = true;
    }

    aiOpration();
    super.initState();
  }

  void aiOpration() async {
    AIConfigs aiConfigs = AIConfigs();
    aiConfigs.aiOprationTest();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

// is keyboard open

    return Scaffold(
      // no chant in keyboard open
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Visibility(
          visible: _buttonState == 0,
          child: FloatingActionButton(
            // change position

            onPressed: () {
              setState(() {
                _buttonState = 3;
              });
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          MaterialButton(
            onPressed: () async {
              bloc!.add(SaveFile());
              setState(() {
                isprint = true;
              });
            },
            child: Container(
                decoration: BoxDecoration(
                    color: LightColors().primary,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(
                    Translation().translate().next,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
      body: BlocListener<ProductBloc,
          FeaturDataSourceState<ProductViewDataModel>>(
        listener: (context, state) {
          state.feadState.maybeWhen(
              loading: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('loading'),
                ));
                isLoad = true;
              },
              orElse: () {},
              success: (message) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message),
                ));
                Navigator.pop(context);
              });

          state.itemState.maybeWhen(
              orElse: () {},
              success: (data) {
                data;
              });
        },
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: BlocConsumer<DrawEngineMainBloc, MainState>(
                builder: (context, state) {
                  return Container(
                    width: width,
                    height: height,
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                child: Visibility(
                                    visible: widget.canUseAi,
                                    child: BlocListener<AiCubit, AiState>(
                                      listener: (context, state) {
                                       if (state is  AiDateChoosed)
                                         {
                                           TextShape textShape = TextShape(
                                             text: state.date,
                                           );
                                           bloc!.add(OnNewShapeAdded(shape: textShape));

                                         }
                                      },
                                      child: AiWidget(),
                                    )),
                              ),
                              // add delete
                              Container(
                                child: _buttonState == 2
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MaterialButton(
                                          enableFeedback:
                                              _buttonState == 2 ? true : false,
                                          onPressed: () {
                                            if (_buttonState != 2) {
                                              return;
                                            }
                                            bloc!.add(OnLayerDelete(
                                                shape: Selectedshape!));
                                          },
                                          child: Container(
                                              height: 40.h,
                                              width: 40.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 3,
                                                      blurRadius: 5,
                                                      offset: Offset(0, 3),
                                                    )
                                                  ]),
                                              child: Icon(
                                                Icons.delete_outline_outlined,
                                                color: LightColors().primary,
                                                size: 30.sp,
                                              )),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 60.h,
                                      ),
                              ),
                              // board
                              Container(
                                child: isLoad
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : AppMobliePaintBoard(),
                              ),

                              SizedBox(
                                height: 20.h,
                              ),
                              // Qr
                              MaterialButton(
                                onPressed: () {
                                  String text = "";
                                  showDialog<Texting>(
                                      context: context,
                                      builder: (_) {
                                        return Positioned(
                                          top: 0,
                                          left: 0,
                                          child: Dialog(
                                            child: QRTextEditor(
                                              text: text,
                                            ),
                                          ),
                                        );
                                      }).then((data) async {
                                    await toQrImageData(data!.id!)
                                        .then((image) {
                                      List<BaseShape> list = bloc!.engen.shapes;
                                      for (var item in list) {
                                        if (item is QRImageShape) {
                                          bloc!.add(OnLayerDelete(shape: item));
                                        }
                                      }
                                      text = data!.id!;
                                      bloc!.add(OnNewShapeAdded(
                                          shape: QRImageShape(
                                              xPos: 0,
                                              yPos: 0,
                                              qrImage: image)));

                                      setState(() {});
                                    });
                                  });
                                },
                                child: Container(
                                    height: 50.h,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 100.w, vertical: 15.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.purple.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0, 3),
                                          )
                                        ]),
                                    child: Image(
                                        image: AssetImage(MyAsset.QRUrl))),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible:
                              MediaQuery.of(context).viewInsets.bottom == 0,
                          child: Positioned(bottom: 0, child: showButton()),
                        ),
                      ],
                    ),
                  );
                },
                listener: (BuildContext context, MainState state) {
                  if (state is DrawSaved) {
                    isInited = true;
                  } else {
                    isInited = false;
                  }
                  if (state is DrawSaved) {
                    image = state.image;
                    if (isprint) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrintEditScreen(
                                    image: image!,
                                    engen: bloc!.engen,
                                    width: bloc!.engen.layout.width,
                                    height: bloc!.engen.layout.height,
                                  )));
                    }
                  }

                  if (state is ShapeSelected) {
                    Selectedshape = state.shape;
                  }
                  if (state is ShapeSelectedFromPanel) {
                    Selectedshape = state.shape;
                    if (Selectedshape is QRImageShape) {
                      _buttonState = 0;
                    } else {
                      _buttonState = 2;
                    }
                    setState(() {});
                  }
                  if (state is ShapeUnSelectedFromPanel) {
                    Selectedshape = null;
                    _buttonState = 0;
                    setState(() {});
                  }
                  if (state is ShapeDeleted) {
                    Selectedshape = null;
                    _buttonState = 0;
                    setState(() {});
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ui.Image> toQrImageData(String text) async {
    try {
      return await QrPainter(
        data: text,
        version: QrVersions.auto,
        gapless: false,
        color: Colors.black,
      ).toImage(300);
    } catch (e) {
      throw e;
    }
  }

  Widget showButton() {
    int buttonState = _buttonState;
    // if keyborad is open

    switch (buttonState) {
      case 1:
        return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height:
                buttonState != 1 ? 0 : MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                // add border
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _buttonState = 0;
                          });
                        },
                        icon: Icon(Icons.close)),
                  ],
                ),
                AppMoblieLayers(),
              ],
            ));
      case 2:
        return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: MediaQuery.of(context).size.width,
            height: buttonState != 2
                ? 0
                : MediaQuery.of(context).size.height * 0.24,
            decoration: BoxDecoration(
                color: Colors.white,
                // add border
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ]),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _buttonState = 0;
                            });
                          },
                          icon: Icon(
                            Icons.close,
                            size: 25,
                          )),
                    ],
                  ),
                  MoblieProperty(),
                ],
              ),
            ));
      case 3:
        return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: MediaQuery.of(context).size.width,
            height: buttonState != 3
                ? 0
                : MediaQuery.of(context).size.height * 0.22,
            decoration: BoxDecoration(
                color: Colors.white,
                // add border
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _buttonState = 0;
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          size: 25,
                        )),
                  ],
                ),
                Expanded(child: AppMoblieToolBox()),
              ],
            ));

      default:
        return Container();
    }
  }
}
