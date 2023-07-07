import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import '../main.dart';

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
    if (index == length1) {
      pokemonNameList.add(pokemonName);
    } else {
      pokemonNameList[index] = pokemonName;
    }
    notifyListeners();
  }
}
