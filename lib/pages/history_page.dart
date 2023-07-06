import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modals/my_app_state.dart';

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
