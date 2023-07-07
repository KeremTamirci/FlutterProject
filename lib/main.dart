import 'modals/data_scraper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'modals/my_app_state.dart';
import 'pages/my_home_page.dart';

final dio = Dio();
var jsonList;
var pokemonList;
var pokemonimgList = [];
var pokemonNameList = [];
var availableNames = [];
int count = 0;
var length1 = 0;

// ListView.builder indexi veriyor bu şekilde yapınca
// Belli bir model oluşturup da yapılabilir valueları olur. (image, id, name etc.)
// uid pubdev'den bulunabilir.
// freezed_annotation package
// modals, widgets, pages
void main() {
  getHttp();
  print("Bu da print işte");
  pokemonInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MyHomePage(),
      ),
    );
  }
}
