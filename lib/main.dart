import 'modals/data_scraper.dart';
import 'pages/history_page.dart';
import 'pages/favorites_page.dart';
import 'pages/pokemon_page.dart';
import 'pages/generator_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'modals/my_app_state.dart';

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

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = HistoryPage();
        break;
      case 3:
        page = TestPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: theme.colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Center(
          child: mainArea,
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: theme.colorScheme.primary,
          ), // sets the inactive color of the `BottomNavigationBar`
          child: BottomNavigationBar(
            backgroundColor: theme.colorScheme.primary,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.catching_pokemon),
                label: 'Pokémon',
              ),
            ],
            currentIndex: selectedIndex,
            unselectedItemColor: Colors.black87,
            showUnselectedLabels: true,
            selectedItemColor: Colors.yellow[700],
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
        ),
      );
    });
  }
}
