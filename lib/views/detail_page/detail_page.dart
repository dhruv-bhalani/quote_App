import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:quotes_app/models/quote_model.dart';
import 'package:quotes_app/utils/extentions.dart';
import 'package:quotes_app/utils/fontstyle.dart';
import 'package:quotes_app/utils/routes.dart';
import 'package:quotes_app/views/screens/components.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.sizeOf(context);
    QuoteModel quote = ModalRoute.of(context)!.settings.arguments as QuoteModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 400,
          width: 400,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: s.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    quote.quote,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.editPage, arguments: quote);
        },
        child: const Icon(Icons.edit_sharp),
      ),
    );
  }
}
