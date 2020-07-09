import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bob Demo',
      theme: ThemeData.dark(),
      home: First(),
    );
  }
}

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(
            image: AssetImage('assets/images/bob.png'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.forward),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(title: 'Bob')),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var num = 0;
  int _page = 0;
  var act;
  @override
  Widget build(BuildContext context) {
    var cha = ['assets/Bob.flr', 'assets/Guss.flr', 'assets/pigeon.flr'];
    if (_page == 0) {
      act = ['Wave', 'Jump', 'Stand', 'Dance'];
    } else if (_page == 1) {
      act = ['success', 'idle', 'cover_eyes_in', 'look_test_1'];
    } else {
      act = ['walk', 'music_walk', 'walk', 'music_walk'];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image(image: AssetImage('assets/images/bob.png')),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Text('Bob'),
              onTap: () {
                setState(() {
                  _page = 0;
                });
              },
            ),
            ListTile(
              title: Text('Guss'),
              onTap: () {
                setState(() {
                  _page = 1;
                });
              },
            ),
            ListTile(
              title: Text('pigeon'),
              onTap: () {
                setState(() {
                  _page = 2;
                });
              },
            ),
          ],
        ),
      ),
      body: FlatButton(
        child: FlareActor(
          cha[_page],
          animation: act[num],
          fit: BoxFit.fitHeight,
        ),
        onPressed: () {
          setState(() {
            num = Random().nextInt(4);
          });
          final player = AudioCache();
          player.play('note$num.wav');
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black12,
        color: Colors.amberAccent,
        height: 50,
        animationDuration: Duration(milliseconds: 200),
        items: <Widget>[
          Image(
            image: AssetImage('assets/images/bob.png'),
            width: 40,
          ),
          Image(
            image: AssetImage('assets/images/guss.png'),
            width: 40,
          ),
          Image(
            image: AssetImage('assets/images/pigeon.png'),
            width: 40,
          )
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
          var snum = _page + 4;
          final player = AudioCache();
          player.play('note$snum.wav');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.history),
        onPressed: () {
          setState(() {
            if (num == 3) {
              num = 0;
            } else {
              num++;
            }
          });
          print(num);
          final player = AudioCache();
          player.play('note$num.wav');
        },
      ),
    );
  }
}
