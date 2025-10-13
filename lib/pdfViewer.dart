import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFview extends StatefulWidget {
  final String url ;

  const PDFview({Key? key, required this.url}) : super(key: key);

  @override
  _PDFviewState createState() => _PDFviewState();
}

class _PDFviewState extends State<PDFview> {
  bool _isLoading = true;
  String remotePDFpath = "";

  @override
  void initState() {
    super.initState();
    // loadDocument();
    createFileOfPdfUrl(widget.url).then((f) {
      setState(() {
        remotePDFpath = f.path;
        _isLoading = false;
      });
    });
  }
  // loadDocument() async {
  //   document = await PDFDocument.fromURL(widget.url);
  //
  //   setState(() => _isLoading = false);
  // }


  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: Center(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                alignment: Alignment.bottomCenter,
                children:[
                  PDFView(
                    filePath: remotePDFpath,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: false,
                    backgroundColor: Colors.grey,


                    onError: (error) {
                      print(error.toString());
                    },
                    onPageError: (page, error) {
                      print('$page: ${error.toString()}');
                    },

                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery. of(context). size. width/2,

                      height: 50,
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          'Back',style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold
                        ),
                        ),
                      ),
                    ),
                  )



                ]
            ))
    ));
  }

  Future<File> createFileOfPdfUrl(String fileUrl) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {

      var url = fileUrl;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
