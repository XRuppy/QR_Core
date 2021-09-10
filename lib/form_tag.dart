import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:manusa_qrcore/pdf_api.dart';
import 'package:universal_html/html.dart' as html;
import 'languajes.dart';

class formTag extends StatefulWidget {
  @override
  _formTagState createState() => new _formTagState();
}

class _formTagState extends State<formTag> with TickerProviderStateMixin {
  ///BOTÓN
  int _state = 0;
  Animation _animation;
  AnimationController _controller;
  GlobalKey _globalKey = GlobalKey();
  double _width = double.maxFinite;

  final _formKey = GlobalKey<FormState>();
  static List<String> psNumTagList = [null];
  static List<String> psStartList = [null];
  static List<String> psFinalList = [null];
  Uint8List uploadedImage;

  ///VARIBLES FORMULARIO
  TextEditingController telephone;
  TextEditingController ps;
  String pos_InitialTag='1';

  _startFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.png';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        final reader = new html.FileReader();

        reader.onLoadEnd.listen((e) {
          print(e);
          print('loaded: ${file.name}');
          print('type: ${reader.result.runtimeType}');
          print('file size = ${file.size}');
          print('file patch = ${file.relativePath}');
          setState(() {
            uploadedImage = reader.result;
          });
        });
        reader.readAsArrayBuffer(file);
      }
    });
  }

  _openFileManager() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      PlatformFile selectedFile = result.files.first;
      setState(() {
        uploadedImage = File(selectedFile.path).readAsBytesSync();
      });
    }
  }
void bottonSelectChange(String number){
    setState(() {
      pos_InitialTag=number;
    });
}
  Widget _botonTableTags(String texto) {
    return RaisedButton(
      child: Text(
        texto,
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blueAccent,
      elevation: 20,
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.blue),
      ),
      onPressed: () => {
        bottonSelectChange(texto)

      },
    );
  }

  Widget _rowButtonTags() {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 2.5,
      crossAxisSpacing: 1,
      children: [
        for (int i = 1; i <= 27; i++)
          _botonTableTags(i.toString())
      ],
    );
  }

  String _formatterYearActually() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    telephone = TextEditingController(text: '900 827 700');
    ps =
        TextEditingController(text: 'PS' + _formatterYearActually() + 'D00000');
  }

  @override
  void dispose() {
    telephone.dispose();
    ps.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(60))),
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
            ),
            ListView(
              children: [
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 20),
                            child: Container(
                              child: Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)
                                                .translate('titleDataTag'),
                                            style: TextStyle(
                                                color: Colors.indigo,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 70,
                                            width: 300,
                                            child: TextFormField(
                                              controller: telephone,
                                              keyboardType: TextInputType.phone,
                                              decoration: InputDecoration(
                                                  helperText:
                                                  AppLocalizations
                                                      .of(context)
                                                      .translate('helperTextTelephone'),
                                                  labelText: AppLocalizations
                                                          .of(context)
                                                      .translate('phoneNumber'),
                                                  icon: Icon(Icons.phone)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 70,
                                            width: 300,
                                            child: TextFormField(
                                              controller: ps,
                                              decoration: InputDecoration(
                                                helperText: AppLocalizations.of(
                                                    context)
                                                    .translate('helperTextPS'),
                                                  labelText:
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate('idPS'),
                                                  icon: Icon(Icons
                                                      .sensor_door_outlined)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('statement')),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('pos_Tag')+pos_InitialTag),
                                        ),
                                        SizedBox(
                                            height: 400,
                                            width: 300,
                                            child: _rowButtonTags()),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('sizeLogo')),
                                        ),
                                                           Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Center(
                                            child: RaisedButton(
                                              onPressed: () {
                                                if (kIsWeb) {
                                                  _startFilePicker();
                                                } else {
                                                  _openFileManager();
                                                }
                                              },
                                              color: Colors.indigo,
                                              elevation: 5,
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(
                                                      color: Colors.indigo)),
                                              child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'uploadLogoButton'),
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Divider(
                                            color: Colors.indigoAccent,
                                            thickness: 3,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('titleRangePS'),
                                              style: TextStyle(
                                                  color: Colors.indigo,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        ..._getPS(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Container(
                                                    key: _globalKey,
                                                    height: 48,
                                                    width: _width,
                                                    child: RaisedButton(
                                                      child: setUpButtonChild(),
                                                      animationDuration:
                                                          Duration(
                                                              milliseconds:
                                                                  1000),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      onPressed: () async {
                                                        if (_state == 0) {
                                                          animateButton();
                                                        }
                                                        final pdfFile = await PdfApi
                                                            .generateTag(
                                                                telephone.text,
                                                                ps.text,
                                                                psStartList,
                                                                psFinalList,
                                                                pos_InitialTag,
                                                                psNumTagList,
                                                                uploadedImage);
                                                        if (!kIsWeb) {
                                                          PdfApi.openFile(
                                                              pdfFile);
                                                        }
                                                      },
                                                      color:
                                                          Colors.indigoAccent,
                                                      elevation: 5,
                                                      textColor: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .indigo)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              height: MediaQuery.of(context).size.height * 0.9,
                              width: MediaQuery.of(context).size.width - 25,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getPS() {
    List<Widget> psTextFields = [];
    for (int i = 0; i < psNumTagList.length; i++) {
      psTextFields.add(Row(
        children: [
          Expanded(flex: 10, child: _PsTextFields(i)),
          Expanded(
              flex: 1, child: _addRemoveButton(i == psNumTagList.length - 1, i))
        ],
      ));
    }
    return psTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          psStartList.insert(0, null);
          psFinalList.insert(0, null);
          psNumTagList.insert(0, null);
        } else {
          psNumTagList.removeAt(index);
          psStartList.removeAt(index);
          psFinalList.removeAt(index);
        }

        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  setUpButtonChild() {
    if (_state == 0) {
      return Text(
        AppLocalizations.of(context).translate('downloadPDFButton'),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      );
    } else if (_state == 1) {
      return SizedBox(
        height: 36,
        width: 36,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void animateButton() {
    double initialWidth = _globalKey.currentContext.size.width;

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48) * _animation.value);
        });
      });
    _controller.forward();

    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });
  }
}

class _PsTextFields extends StatefulWidget {
  final int index;
  _PsTextFields(this.index);
  @override
  _PsTextFieldsState createState() => _PsTextFieldsState();
}

class _PsTextFieldsState extends State<_PsTextFields> {
  TextEditingController psFirst;
  TextEditingController psFinal;
  TextEditingController numTags;

  @override
  void initState() {
    super.initState();
    psFirst = TextEditingController();
    psFinal = TextEditingController();
    numTags = TextEditingController();
  }

  @override
  void dispose() {
    psFirst.dispose();
    psFinal.dispose();
    numTags.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      psFirst.text = _formTagState.psStartList[widget.index] ?? '';
      psFinal.text = _formTagState.psFinalList[widget.index] ?? '';
      numTags.text = _formTagState.psNumTagList[widget.index] ?? '';
      if (psFinal.text.isEmpty){
        psFinal.text = '1';
      }
    });

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: 10,
              child: TextFormField(
                controller: psFirst,
                onChanged: (v) => _formTagState.psStartList[widget.index] = v,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)
                        .translate('textfieldPSInitial'),
                    icon: Icon(Icons.code)),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: 10,
              child: TextFormField(
                controller: psFinal,
                onChanged: (v) => _formTagState.psFinalList[widget.index] = v,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)
                        .translate('textfieldPSFinal'),
                    icon: Icon(Icons.code)),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: 10,
              child: TextFormField(
                controller: numTags,
                onChanged: (v) => _formTagState.psNumTagList[widget.index] = v,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)
                        .translate('textfieldNumTag'),
                    icon: Icon(Icons.tag)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
