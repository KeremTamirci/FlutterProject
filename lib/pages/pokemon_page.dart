import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../modals/my_app_state.dart';

var nameToAdd = WordPair("Nameless", " ");

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
    if (count <= pokemonimgList.length) {
      length1 = count;
    } else {
      count = pokemonimgList.length;
    }
    nameToAdd = WordPair("Nameless", " ");

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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(60))),
          onPressed: () {
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
                      //appState.addPokemonName(nameToAdd, length1);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (nameToAdd != WordPair("Nameless", " ")) {
                        Navigator.pop(context, 'OK');
                        appState.addPokemonName(nameToAdd, length1);
                        setState(() {
                          count++;
                        });
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
