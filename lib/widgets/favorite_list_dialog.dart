import '../modals/my_app_state.dart';
import '../pages/pokemon_page.dart';

import 'package:flutter/material.dart';

class FavoriteListDialog extends StatelessWidget {
  FavoriteListDialog({
    super.key,
    required this.appState,
  });

  final MyAppState appState;
  final ScrollController controllerOne = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Scrollbar(
        thumbVisibility: true,
        controller: controllerOne,
        child: ListView(
          controller: controllerOne,
          children: [
            for (var pair in appState.favorites)
              TextButton(
                  onPressed: () {
                    nameToAdd = pair;
                  },
                  child: Text(pair.asPascalCase)),
          ],
        ),
      ),
    );
  }
}
