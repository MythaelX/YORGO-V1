import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';

import '../auth/signin_view.dart';

final List imgList = [
  {'image': 'assets/images/jogging.jpg', 'text': "Bienvenue sur Yorgo"},
  {'image': 'assets/images/escalade.jpg', 'text': "Yorgo est une app de bg"},
  {
    'image': 'assets/images/swimmer.jpg',
    'text': "Clique sur le petit bouton pour start"
  },
];

double height = 0;

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
                ),
                Positioned(
                  top: 50.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        item['text'],
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
                    ),
                  ),
                ),
              ],
            )),
          ),
        ))
    .toList();

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {
  static String routeName = '/home';
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(children: [
        Stack(
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
                      imgList.remove(0);
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
              bottom: 0,
              left: 0,
              right: 0.0,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 30),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, SigninView.routeName);
                  },
                  child: const Text('Connexion'),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
