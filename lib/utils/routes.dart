import 'package:flutter/material.dart';
import 'package:quotes_app/views/detail_page/detail_page.dart';
import 'package:quotes_app/views/editpage/editpage.dart';

import 'package:quotes_app/views/home_page/Homepage.dart';

class Routes {
  static String homePage = '/';
  static String detailPage = 'detail_page';
  static String editPage = 'edit_page';
}

Map<String, Widget Function(BuildContext context)> routes = {
  Routes.homePage: (context) => const Homepage(),
  Routes.detailPage: (context) => const DetailPage(),
  Routes.editPage: (context) => const Editpage(),
};
