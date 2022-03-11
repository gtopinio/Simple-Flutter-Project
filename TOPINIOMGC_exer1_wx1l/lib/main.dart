/*
  This is a simple profiling app that shows the author's basic information (e.g., hobbies, name, age)

  @author Mark Genesis C. Topinio
  @created_date 2022-02-24 16:30

*/
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//MyApp builds the main widget tree of the application. It also includes the title, theme, and creates
//an instance of Hobbies() to show the list of the author's hobbies
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Profiling App',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 77, 200, 248),
            foregroundColor: Color.fromARGB(255, 8, 39, 95),
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 32, 32, 32)),
      home: const Hobbies(),
    );
  }
}

//Hobbies, along with _HobbiesState, is a Stateful widget that builds the rows of the author's hobbies.
//It also makes the app interactive as the user can tap/toggle a row or heart icon of that row to choose and save a hobby.
//Saved hobbies are then showed to another page of the application
class Hobbies extends StatefulWidget {
  const Hobbies({Key? key}) : super(key: key);

  @override
  _HobbiesState createState() => _HobbiesState();
}

class _HobbiesState extends State<Hobbies> {
  //There are 10 suggestions in the hobbies list
  final _suggestions = <String>[
    "meditating",
    "playing Genshin Impact",
    "cycling",
    "playing the piano",
    "feeding pets",
    "playing chess",
    "scrolling through social media",
    "watching anime",
    "posting on Reddit",
    "studying",
    "doing push-ups",
    "listening to lo-fi music",
  ];
  final _saved =
      <String>{}; //This is to store the list of hobbies chosen by the user
  final _biggerFont = const TextStyle(
    fontSize: 20,
    fontFamily: 'PT Sans',
    color: Colors.white,
  ); //The font size for the list of hobbies

  void _pushSaved() {
    //This is to show another page called "My Profile", which shows the author's description and the saved hobbies from the main page
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            //This is to populate the ListView for the 'My Profile' page using the chosen hobby/ies
            (hobby) {
              return ListTile(
                title: Text(
                  hobby,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'My Profile',
                  style: TextStyle(
                      fontFamily: 'Slabo',
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              body: Column(children: [
                Column(children: const <Widget>[
                  Text(
                    "Mark Genesis C. Topinio",
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Concert One',
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "\n2019-04643",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PT Sans',
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "\nYou can call me Gen. I'm currently taking up BS Computer Science. I'm also from Cabatuan, Isabela. I'm 21 years old. I love listening to philosophical and mental health topics, especially from Alan Watts. Fun Fact: I share the same birthday with my sibling and father.",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'PT Sans',
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "\nMy hobby/ies is/are:",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'PT Sans',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ]),
                Expanded(
                  child: ListView(children: divided),
                )
              ]));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Profiling App',
          style: TextStyle(
            fontFamily: 'Slabo',
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ), //This is the title for the 1st page shown in the app
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Hobbies',
          ),
        ],
      ),
      body:
          _buildSuggestions(), //The body of the main page shows the list of hobbies
    );
  }

  //This allows the main interaction between the user and the list of hobbies
  //If the user taps an unchosen hobby from the list, the icon next to it becomes red, and the string is saved
  //into the list of chosen hobbies (i.e., _saved). If the chosen hobby is tapped again, it will not be saved and the
  //heart icon's color is removed.
  Widget _buildRow(String hobby) {
    final alreadySaved = _saved.contains(hobby);
    return ListTile(
      title: Text(
        hobby,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : Colors.white,
        semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(hobby);
          } else {
            _saved.add(hobby);
          }
        });
      },
    );
  }

  //This creates a scrollable, linear array of widgets along with some padding
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        return _buildRow(_suggestions[index]);
      },
    );
  }
}


/*
  References:
    CMSC 23 - Base Code (Institute of Computer Science (ICS) - UPLB)

    Flutter - Dart API docs (https://api.flutter.dev/)
*/