import '../main.dart';

void main() {
//  getHttp();
  print("Bu da print işte");
  print(length1.toString());
}

void getHttp() async {
  final response = await dio.get('https://dummyjson.com/products');
//  print(response);
  if (response.statusCode == 200) {
    jsonList = response.data["products"] as List;
  } else {
    print(response.statusCode);
  }
}

Future<void> getPokemon() async {
  final pokemonresponse = await dio.get('https://pokeapi.co/api/v2/pokemon');
  print(pokemonresponse.data["results"][0]);
  if (pokemonresponse.statusCode == 200) {
    pokemonList = pokemonresponse.data["results"] as List;
    //print(pokemonList);
  } else {
    print(pokemonresponse.statusCode);
  }
}

Future<void> getPokemonimg() async {
  // sprites/home/front_default
  var url;
  for (var i = 0; i < pokemonList.length; i++) {
//    await getPokemonimg(pokemonList[i]["url"]);
    url = pokemonList[i]["url"];
    final imgresponse = await dio.get(url);
    print(imgresponse.data["sprites"]["front_default"]);
    if (imgresponse.statusCode == 200) {
      pokemonimgList.add(imgresponse.data["sprites"]["front_default"]);
//    print(pokemonimgList);
    } else {
      print(imgresponse.statusCode);
    }
  }
}

Future<void> pokemonInit() async {
  await getPokemon();
  await getPokemonimg();
  pokemonimgList.shuffle();
}
