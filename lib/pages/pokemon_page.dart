import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../modals/my_app_state.dart';
import '../widgets/favorite_list_dialog.dart';
import '../widgets/grid_view_widget.dart';

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
        child: GridViewWidget(style: style),
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
              builder: (BuildContext context) {
                return AlertDialog(
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
                    FavoriteListDialog(appState: appState)
                  ]),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
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
                );
              },
            );
          },
          child: Text("Catch"),
        ),
      ),
    );
  }
}
