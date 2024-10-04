import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotes_app/models/quote_model.dart';
import 'package:quotes_app/utils/extentions.dart';
import 'package:quotes_app/utils/fontstyle.dart';
import 'package:quotes_app/utils/quotes_utils.dart';
import 'package:share_plus/share_plus.dart';

class Editpage extends StatefulWidget {
  const Editpage({super.key});

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  Color bgColor = Colors.black;
  double opacity = 1;
  int quotefontSize = 16;
  int authorfontSize = 12;
  Color textcolor = Colors.black;
  Color textBackgroundColor = Colors.white;
  String quotesFont = MyFonts.Roboto.name;
  String authorFonts = MyFonts.Roboto.name; // Background color variable
  int index = 1;
  bool isedit = false;

  void setIndex(int i) {
    index = i;
    setState(() {});
  }

  void _onMenuSelected(String value) {
    switch (value) {
      case 'Edit':
        isedit = true;
        setState(() {});
        break;
      case 'Reset':
        setState(() {
          quotefontSize = 16;
          authorfontSize = 12;
          textcolor = Colors.black;
          textBackgroundColor = Colors.white;
          quotesFont = MyFonts.Roboto.name;
          authorFonts = MyFonts.Roboto.name;
        });
        break;
    }
  }

  GlobalKey key = GlobalKey();
  Future<File> share() async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
      pixelRatio: 25,
    );
    ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    Uint8List uInt8list = bytes!.buffer.asUint8List();

    Directory directory = await getTemporaryDirectory();
    File file = await File(
            "${directory.path}/QA-${DateTime.now().millisecondsSinceEpoch}.png")
        .create();
    file.writeAsBytesSync(uInt8list);

    return file;
  }

  Widget saveChild = const Icon(Icons.save_alt_rounded);

  TextStyle textStyle = googleFonts[0];
  @override
  Widget build(BuildContext context) {
    QuoteModel quote = ModalRoute.of(context)!.settings.arguments as QuoteModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Page"),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem<String>(
                  value: 'Reset',
                  child: Text('Reset'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    RepaintBoundary(
                      key: key,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          color:
                              textBackgroundColor, // Apply background color here
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                quote.quote,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: googleFonts[index].fontFamily,
                                  color: textcolor,
                                  fontSize: quotefontSize.toDouble(),
                                ),
                              ),
                            ),
                            Text(
                              "~ ${quote.author}",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: googleFonts[index].fontFamily,
                                color: textcolor,
                                fontSize: authorfontSize.toDouble(),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.h,
              Visibility(
                visible: isedit,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setIndex(0);
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                width: index == 0 ? 2.5 : 0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: const Text(
                            "Text",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setIndex(1);
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                width: index == 1 ? 5 : 0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: const Text(
                            "Theme",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isedit,
                child: IndexedStack(
                  index: index,
                  children: [
                    // Text Edit
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Quote Font Size",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (quotefontSize > 12) {
                                          quotefontSize--;
                                        }
                                      });
                                    },
                                  ),
                                  Text(quotefontSize.toString()),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        quotefontSize++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Author Font Size",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (authorfontSize > 12) {
                                          authorfontSize--;
                                        }
                                      });
                                    },
                                  ),
                                  Text(authorfontSize.toString()),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        authorfontSize++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          20.h,
                          const Text(
                            "Quote FontStyle",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              "Abc",
                              style: TextStyle(
                                  fontFamily: googleFonts[index].fontFamily),
                            ),
                          ),
                          10.h,
                          const Text("Author FontStyle",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: MyFonts.values
                                  .map((e) => TextButton(
                                      onPressed: () {
                                        setState(() {
                                          authorFonts = e.name;
                                        });
                                      },
                                      child: Text(
                                        "Abc",
                                        style: TextStyle(fontFamily: e.name),
                                      )))
                                  .toList(),
                            ),
                          ),
                          10.h,
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Pick a Text Color"),
                                    content: BlockPicker(
                                      pickerColor: textcolor,
                                      onColorChanged: (Color value) {
                                        setState(() {
                                          textcolor = value;
                                        });
                                      },
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text("Pick Text Color"),
                          ),
                        ],
                      ),
                    ),
                    // Theme Edit (background color picker via ElevatedButton and AlertDialog)
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        const Text("Pick a Background Color"),
                                    content: BlockPicker(
                                      pickerColor: textBackgroundColor,
                                      onColorChanged: (Color value) {
                                        setState(() {
                                          textBackgroundColor = value;
                                        });
                                      },
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text("Pick Background Color"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          File file = await share();
          await Share.shareXFiles([XFile(file.path)]);
        },
        child: const Icon(Icons.share),
      ),
    );
  }
}
