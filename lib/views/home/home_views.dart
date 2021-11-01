import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:video_player/video_player.dart';
import '../auth/signin_view.dart';

final List imgList = [
  {
    'image': 'assets/images/jogging.jpg',
    'title': "",
    'text': "Bienvenue sur Yorgo"
  },
  {
    'image': 'assets/images/escalade.jpg',
    'title': "C’est quoi YORGO ?",
    'text': [
      " YORGO, c’est faire du sport à plusieurs, booster sa motivation et challenger ses performances.",
      "",
      " Le tout, en 1 application !",
    ]
  },
  {
    'image': 'assets/images/escalade.jpg',
    'title': "Mais également",
    'text': ["Video Introduction"]
  },
  {
    'image': 'assets/images/swimmer.jpg',
    'title': "",
    'text': "À vous de jouer !"
  },
];

double height = 0;
double width = 0;
List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            child: ClipRRect(
                child: Stack(
              children: <Widget>[
                Image.asset(
                  item['image'],
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                ),
                Positioned.fill(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: (item['title'] == "")
                        ? Align(
                            alignment: Alignment.center,
                            child: Text(
                              item['text'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36.0,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(1),
                                    offset: Offset(3, 2),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: (height / 30), horizontal: 0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      item['title'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height / 18,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(1),
                                            offset: Offset(3, 2),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(flex: 3, child: Container()),
                                for (var item in item['text'])
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      item,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height / 28,
                                        fontWeight: FontWeight.w500,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(1),
                                            offset: Offset(3, 2),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                Expanded(flex: 2, child: Container()),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            )),
          ),
        ))
    .toList();

class HomeView extends StatefulWidget {
  static String routeName = '/home';

  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  height: height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0.0,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.map((url) {
                    int index = imgList.indexOf(url);
                    return Container(
                      width: 16.0,
                      height: 16.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color.fromRGBO(255, 255, 255, 1)
                            : Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 0,
              child: Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                margin:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, SigninView.routeName);
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff65C5F8), Color(0xff2D93CC)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20),
                      alignment: Alignment.center,
                      child: Text(
                        'Connexion',
                        style: TextStyle(
                          fontSize: 20,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(3, 2),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
