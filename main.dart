import 'data_scraper.dart';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

final dio = Dio();
var jsonList;
var pokemonList;
var pokemonimgList = [];
var pokemonNameList = [];
int _count = 0;
var length1 = 0;

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

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[];

  void getNext() {
    history.add(current);
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void toggleFavoriteList(pair) {
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void addPokemonName(pokemonName, index) {
//    pokemonNameList[index] = pokemonName;
    pokemonNameList.add(pokemonName);
    notifyListeners();
  }
}

// ...

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
            unselectedItemColor: Colors.black,
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

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ...

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asPascalCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onBackground,
    );
    var appState = context.watch<MyAppState>();
    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'You have '
            '${appState.favorites.length} favorites:',
            style: style,
          ),
        ),
        for (var pair in appState.favorites)
          TextButton.icon(
              onPressed: () {
                appState.toggleFavoriteList(pair);
              },
              icon: Icon(Icons.favorite),
              label: Text(pair.asPascalCase)),
      ],
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onBackground,
    );
    var appState = context.watch<MyAppState>();
    if (appState.history.isEmpty) {
      return Center(
        child: Text('No history yet.'),
      );
    }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'You have generated '
            '${appState.history.length} words:',
            style: style,
          ),
        ),
        for (var pair in appState.history)
          TextButton.icon(
              onPressed: () {
                appState.toggleFavoriteList(pair);
              },
              icon: appState.favorites.contains(pair)
                  ? Icon(Icons.favorite)
                  : SizedBox(),
              label: Text(pair.asPascalCase)),
      ],
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.headlineSmall!.copyWith(
      color: theme.colorScheme.primary,
    );
    var appState = context.watch<MyAppState>();
    if (_count <= pokemonimgList.length) {
      length1 = _count;
    } else {
      _count = pokemonimgList.length;
    }
    var nameToAdd = WordPair("Nameless", " ");

    return Scaffold(
      body: ColoredBox(
        color: theme.colorScheme.surfaceVariant,
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(length1, (index) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 200,
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 155,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.network(
                            pokemonimgList[index],
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          pokemonNameList.length <= index
                              ? "Nameless"
                              : pokemonNameList[index].asPascalCase,
                          style: style,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 75,
        width: 100,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _count++;
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                scrollable: true,
                title: const Text('You caught a Pokemon!'),
                content: Wrap(alignment: WrapAlignment.center, children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      pokemonimgList[length1],
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("Name your Pokemon")),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Scrollbar(
                      child: ListView(
                        children: [
                          for (var pair in appState.favorites)
                            TextButton(
                                onPressed: () {
                                  //appState.addPokemonName(pair, length1);
                                  nameToAdd = pair;
                                },
                                child: Text(pair.asPascalCase)),
                        ],
                      ),
                    ),
                  )
                ]),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                      appState.addPokemonName(nameToAdd, length1);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (nameToAdd != WordPair("Nameless", " ")) {
                        Navigator.pop(context, 'OK');
                        appState.addPokemonName(nameToAdd, length1);
                      }
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: Text("Catch"),
        ),
      ),
    );
  }
}
