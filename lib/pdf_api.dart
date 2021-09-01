import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class PdfApi {
  static Future<File> generateTag(
      String telephone,
      String PS,
      List PSFirst,
      List PSFinal,
      String pos_Start_Print,
      List numTags,
      Uint8List uploadedImage) async {
    final pdf = Document();
    double containerH = 2.96;
    double containerW = 6.3;
    var imageLogo;
    int conta = 0;
    List listaLlena = _buildPs(PS, PSFirst, PSFinal, numTags);
    int contaFinal = listaLlena.length;

    final pageTheme = PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.only(
            top: 1.65 * PdfPageFormat.cm,
            bottom: 1.25 * PdfPageFormat.cm,
            left: 0.6 * PdfPageFormat.cm,
            right: 0.8 * PdfPageFormat.cm));

    final imageCe = pw.MemoryImage(
      (await rootBundle.load('assets/ce.png')).buffer.asUint8List(),
    );

    if (uploadedImage == null) {
      imageLogo = pw.MemoryImage(
        (await rootBundle.load('assets/logo_manusa.png')).buffer.asUint8List(),
      );
    } else {
      imageLogo = pw.MemoryImage(uploadedImage);
    }

    tagBlank() {
      return pw.Container(
        width: containerW * PdfPageFormat.cm,
        height: containerH * PdfPageFormat.cm,
        child: pw.Padding(
          padding: const pw.EdgeInsets.all(5),
        ),
      );
    }

    List<pw.Widget> _getListData(String PS) {
      List<pw.Widget> list = new List();
      for (int i = 1; i <= contaFinal; i++) {
        if (i >= int.parse(pos_Start_Print)) {
          list.add(pw.Container(
            width: containerW * PdfPageFormat.cm,
            height: containerH * PdfPageFormat.cm,
            padding: const pw.EdgeInsets.only(
                bottom: 2.0 * PdfPageFormat.mm,
                top: 2.0 * PdfPageFormat.mm,
                left: 5.0 * PdfPageFormat.mm,
                right: 5.0 * PdfPageFormat.mm),
            child: pw.Row(
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Image(imageLogo, width: 150, height: 35),
                    pw.Text(
                      telephone,
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    pw.Row(
                      children: [
                        pw.Image(imageCe, height: 10, width: 10),
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 10),
                          child: pw.Text(
                            'PS:',
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        pw.Text(
                          listaLlena[conta],
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(top: 40, left: 5),
                      child: pw.BarcodeWidget(
                          color: PdfColor.fromHex("#000000"),
                          barcode: pw.Barcode.qrCode(),
                          data: listaLlena[conta],
                          width: 25,
                          height: 25),
                    )
                  ],
                ),
              ],
            ),
          ));
          conta++;
        } else {
          list.add(tagBlank());
          contaFinal++;
        }
      }
      return list;
    }

    pdf.addPage(
      MultiPage(
          pageTheme: pageTheme,
          build: (context) => [
                pw.GridView(
                    crossAxisCount: 3,
                    childAspectRatio: 0.465,
                    crossAxisSpacing: 0.25 * PdfPageFormat.cm,
                    children: _getListData(PS))
              ]),
    );

    return saveDocument(name: 'QRCore_Generated_Label.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    String name,
    Document pdf,
  }) async {
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    if (kIsWeb) {
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = name;
      html.document.body.children.add(anchor);
      anchor.click();
      html.document.body.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
    } else {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$name');
      await file.writeAsBytes(bytes);
      return file;
    }
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static List _buildPs(String PS, List PSFirst, List PSFinal, List numTags) {
    var list = new List();
    int conta = 0;
    while (conta < PSFirst.length) {
      for (int i = int.parse(PSFirst[conta]);
          i <= int.parse(PSFinal[conta]);
          i++) {
        for (int k = 1; k <= int.parse(numTags[conta]); k++) {
          list.add((PS + i.toString()));
        }
      }
      conta++;
    }
    return list;
  }
}
