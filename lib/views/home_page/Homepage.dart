import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quotes_app/models/quote_model.dart';
import 'package:quotes_app/utils/qupte_utils.dart';
import 'package:quotes_app/views/screens/components.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void showQuote() {
    Random r = Random();
    String category = "art";

    List<QuoteModel> list =
        allQuotes.where((e) => e.category == category).toList();
    QuoteModel quoteModel = list[r.nextInt(list.length)];

    showDialog(
      context: (context),
      builder: (context) => SimpleDialog(
        backgroundColor: Colors.white,
        title: const Text(
          "Quote",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              quoteModel.quote,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () => showQuote(),
    );
    super.initState();
  }

  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes App"),
        backgroundColor: Colors.white.withOpacity(0.3),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isCheck = !isCheck;
              });
            },
            icon: isCheck
                ? Icon(Icons.grid_view_rounded)
                : Icon(Icons.list_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isCheck
            ? Stack(
                children: [
                  backgroundImage(), // corrected the typo here
                  Column(
                    children: [
                      Expanded(
                        child: MasonryGridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 9,
                          crossAxisSpacing: 9,
                          itemCount: allQuotes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  'detail_page',
                                  arguments: allQuotes[index],
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white10,
                                ),
                                child: Text(
                                  allQuotes[index].quote,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Stack(
                children: [
                  backgroundImage(), // corrected the typo here
                  ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 3,
                      color: Colors.black,
                    ),
                    itemCount: allQuotes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            'detail_page',
                            arguments: allQuotes[index],
                          );
                        },
                        title: Text(
                          allQuotes[index].quote,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        subtitle: Text(
                          "~ ${allQuotes[index].author}",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
