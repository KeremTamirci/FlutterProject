import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

import '../main.dart';

import 'package:flutter/material.dart';

import '../modals/my_app_state.dart';
import '../pages/pokemon_page.dart';
import '../widgets/favorite_list_dialog.dart';
import '../widgets/grid_view_widget.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonNameList[pokemonIndex].asPascalCase),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 250,
              child: Image.network(
                pokemonimgList[pokemonIndex],
                fit: BoxFit.fitWidth,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: const Text('Change the name of your Pokemon!'),
                          content:
                              Wrap(alignment: WrapAlignment.center, children: [
                            FavoriteListDialog(appState: appState),
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
                                  appState.addPokemonName(
                                      nameToAdd, pokemonIndex);
                                }
                              },
                              child: const Text('OK'),
                            ),
                          ]));
                    },
                  );
                },
                child: Text("Change Name")),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
