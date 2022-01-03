import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/iconCustom/sport_icons.dart';
import 'package:yorgo/models/form/profile_sport_form_model.dart';
import 'package:yorgo/models/data/sport_model.dart';
import 'package:yorgo/providers/sport_provider.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/views/home/home_main_view.dart';
import 'package:yorgo/views/profile/widget/searchBar.dart';
import 'package:yorgo/views/profile/widget/sportCategory.dart';
import 'package:yorgo/widgets/Buttons/GradientElevatedButton.dart';
import 'package:yorgo/widgets/colorTexts/textWhite.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';
import "package:collection/collection.dart";
import 'package:yorgo/widgets/progressor/dialog_progressor.dart';

class ProfileSportCreateView extends StatefulWidget {
  static String routeName = '/profil_sport_create';

  @override
  State<ProfileSportCreateView> createState() => _ProfileSportCreateViewState();
}

class _ProfileSportCreateViewState extends State<ProfileSportCreateView> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late ProfileSportForm profileSportForm;
  FormState? get form => key.currentState;
  late List<Sport>? sports;

  String filter = "";
  @override
  void initState() {
    profileSportForm = ProfileSportForm(
      sports: {},
    );

    super.initState();
  }

  Future<void> submitForm() async {
    if (form!.validate()) {
      form!.save();
      DialogBuilder(context).showLoadingIndicator('Envoi en cours ...');
      final error = await Provider.of<UserProvider>(context, listen: false)
          .profileSportCreate(profileSportForm);
      DialogBuilder(context).hideOpenDialog();
      if (error == null) {
        Navigator.pushNamed(context, HomeMainView.routeName);
      } else {
        final snackBar = SnackBar(
          content: const Text("Erreur d'envoie du formulaire"),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map? groups = getSportBycategoryFilter(filter: filter);
    return Scaffold(
      appBar: HeaderAppBar(
        text: "Mon Profil",
        backButton: true,
      ),
      body: (groups != null)
          ? Form(
              key: key,
              child: Stack(
                children: [
                  getBackground(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomScrollView(slivers: getContents(groups)),
                  ),
                  Column(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: GradientElevatedButton2(
                          function: submitForm,
                          text: "Continuer",
                          page: 2,
                          numberPage: 2,
                          colors: [Color(0xff65C5F8), Color(0xff2D93CC)],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                getBackground(),
                Center(
                    child: Container(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(strokeWidth: 15))),
              ],
            ),
    );
  }

  Container getBackground() {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(207, 227, 239, 1),
                Color.fromRGBO(195, 213, 229, 1),
                Color.fromRGBO(173, 200, 221, 1),
                Color.fromRGBO(164, 192, 216, 1),
                Color.fromRGBO(126, 166, 198, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.2, 0.3, 0.4, 1]),
        ),
        alignment: Alignment.topCenter);
  }

  Widget getButtonSportGroupByCategory(groups) {
    if (groups != null) {
      return SportCategory(
          category: "Sport de balle", listSport: groups["Sport de balle"]);
    }
    return Container();
  }

  List<Widget> getContents(Map<dynamic, dynamic>? groups) {
    final Map? categorys = Provider.of<SportProvider>(context).categorys;
    if (groups != null && categorys != null) {
      List<Widget> contents = [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                height: 10,
              ),
              TextWhite(text: "Indiquez les sports que vous pratiquez"),
              Container(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBar(
                    onChanged: (value) => {
                          setState(() {
                            filter = value;
                          })
                        }),
              )
            ],
          ),
        )
      ];
      if (groups.isNotEmpty) {
        groups.forEach((key, value) {
          contents.add(SliverList(
              delegate: SliverChildListDelegate([
            Container(
              height: 20,
            ),
            TextWhiteIcon(
              text: categorys[key].name,
              icon: SportIcons.getIconByString(categorys[key].icon),
            )
          ])));
          contents.add(SportCategory(
              category: key.toString(),
              listSport: value,
              form: profileSportForm));
        });
      }
      contents.add(SliverList(
          delegate: SliverChildListDelegate([
        Container(
          height: 100,
        )
      ])));
      return contents;
    }
    return [];
  }

  Map? getSportBycategory() {
    sports = Provider.of<SportProvider>(context).sports;

    if (sports != null) {
      final groups = groupBy(sports!, (Sport e) {
        return e.category;
      });
      return groups;
    }
    return null;
  }

  Map? getSportBycategoryFilter({required String filter}) {
    sports = Provider.of<SportProvider>(context).sports;
    if (sports != null) {
      final groups = groupBy(
          sports!
              .where((Sport sport) =>
                  sport.name.toLowerCase().contains(filter.toLowerCase()))
              .toList(), (Sport e) {
        return e.category;
      });
      return groups;
    }
    return null;
  }
}
