import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import '../auth/signin_view.dart';

// On défini le carousel avec son titre, texte, image son format (3 formats possibles)
final List imgList = [
  {
    'image': 'assets/images/fond4.jpg',
    'title': "Bienvenue sur Yorgo",
    'text': [],
    'format': 0,
  },
  {
    'image': 'assets/images/fond2.jpg',
    'title': "YORGO c’est quoi  ?",
    'text': [
      " YORGO, c’est faire du sport à plusieurs, booster sa motivation et challenger ses performances.",
      "",
      " Le tout, en 1 application !",
    ],
    'format': 1,
  },
  {
    'image': 'assets/images/fond3.jpg',
    'title': "Mais également",
    'text': [],
    'format': 2,
  },
  {
    'image': 'assets/images/swimmer.jpg',
    'title': "À vous de jouer !",
    'text': [],
    'format': 0,
  },
];

//Varriables Globales
double height = 0;
double width = 0;
late VideoPlayerController? _controller;
late Future<void> _initializeVideoPlayerFuture;

//initialisation du Slider
List<Widget> imageSliders = imgList.map((item) {
  // style d'affichage 1 (le titre au centre) :
  var format1 = [
    Expanded(flex: 1, child: Container()),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Align(
        alignment: Alignment.center,
        child: AutoSizeText(
          item['title'],
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
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
    Expanded(flex: 1, child: Container()),
  ];
  // style d'affichage 2 (le titre en Haut) + texte au centre :
  var format2 = [
    Padding(
      padding: EdgeInsets.symmetric(vertical: height / 9, horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: AutoSizeText(
                item['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
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
          for (var itemText in item['text'])
            AutoSizeText(
              itemText,
              maxLines: 4,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w400,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(1),
                    offset: Offset(3, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  ];
  // style d'affichage 3 (le titre en Haut) + video :
  var format3 = [
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: (height / 60), horizontal: 0),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                item['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height / 15,
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
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: AspectRatio(
                aspectRatio: width / height,
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          VideoPlayer(_controller!),
                          VideoProgressIndicator(_controller!,
                              allowScrubbing: true),
                        ],
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ];
  return Container(
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
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                children: [
                  if (item['format'] == 0)
                    ...format1
                  else if (item['format'] == 1)
                    ...format2
                  else if (item['format'] == 2)
                    ...format3,
                ],
              ),
            ),
          ),
        ],
      )),
    ),
  );
}).toList();

class HomeView extends StatefulWidget {
  static String routeName = '/home';

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  int _current = 0; //permet de savoir la page ou se situe utilisateur

  //Init de la vidéo sur le slider
  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/videos/video_intro.mp4');
    _initializeVideoPlayerFuture = _controller!.initialize();
    _controller!.setLooping(true);
    super.initState();
  }

  //dispose pour le slider
  @override
  void dispose() {
    _controller!.dispose();
    _controller = null;
    super.dispose(); //Super should be called at the very end of dispose
  }

  //Creation de la page en Stack
  @override
  Widget build(BuildContext context) {
    // on récupère la taille pour rester responsible
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
                      if (index == 2) {
                        _controller!.play();
                      } else if (_current == 2) {
                        _controller!.pause();
                      }
                      _current = index;
                    });
                  }),
            ),
            Positioned(
              bottom: 70,
              left: 0,
              right: 0.0,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.map((url) {
                    int index = imgList.indexOf(url);
                    return Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
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
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                        borderRadius: BorderRadius.circular(5.0)),
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
