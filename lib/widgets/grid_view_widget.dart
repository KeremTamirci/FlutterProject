import '../main.dart';
import 'package:flutter/material.dart';
import '../pages/details_page.dart';

var pokemonIndex = 0;

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({
    super.key,
    required this.style,
  });

  final TextStyle style;

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  void tapped(index) {
    print("Image $index tapped.");
    pokemonIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(length1, (index) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                print("Pokemon is tapped.");
                tapped(index);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailsPage()),
                );
              },
              child: SizedBox(
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
                        pokemonNameList[index].asPascalCase,
                        style: widget.style,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
