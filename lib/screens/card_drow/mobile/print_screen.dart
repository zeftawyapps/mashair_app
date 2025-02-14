import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart'  ;

import '../../../loclization/app_localizations.dart';



class PrintScreen extends StatelessWidget {
    PrintScreen(this.image, {super.key ,
    this.width = 1748,
    this.height = 2480,
    // this.width = 300,
    //   this.height = 200,

    });

  final Uint8List image;
  double width = 100;
  double height = 200;
  double A5Width = 1748;
  double A5Height = 2480;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      home: Scaffold(
        appBar: AppBar(title: Text(  Translation().translate().ScreenPrint) ,
         // add back button
          actions: [
            IconButton(
                onPressed: () async {

                  Navigator.pop(context);
                },
                icon: Icon(Icons.close_sharp  )),
          ],
        ),
        body:  PdfPreview(
          build: (format) => _generatePdf(format, image ),
          pageFormats: {"card": PdfPageFormat(width, height ) ,
          "standard": PdfPageFormat.a6
          },

        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, Uint8List title) async {
    double myWidth = width/A5Width  + width ;
    double myHeight = height/A5Height + height ;


    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(

      pw.Page(

        pageFormat: format,
        build: (context) {
          return pw.Center(
            child: pw.Image(
              height: height,
              width:  width    ,
              pw.MemoryImage(image),
            ),
          );
        },
      ),
    );

    return pdf.save();
  }


}