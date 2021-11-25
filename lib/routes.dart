import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//Page Import :

import 'package:yorgo/views/activity/activity_search_view.dart';
import 'package:yorgo/views/activity/activity_view.dart';
import 'package:yorgo/views/auth/signin_view.dart';
import 'package:yorgo/views/auth/signup_view.dart';
import 'package:yorgo/views/flux/flux_view.dart';
import 'package:yorgo/views/friend/friend_view.dart';
import 'package:yorgo/views/group/group_view.dart';
import 'package:yorgo/views/home/Home_main_view.dart';
import 'package:yorgo/views/home/home_views.dart';
import 'package:yorgo/views/local_sportmen/local_sportmen_view.dart';
import 'package:yorgo/views/not_found_view.dart';
import 'package:yorgo/views/profile/profile_sport_create.dart';
import 'package:yorgo/views/profile/profile_view.dart';
import 'package:yorgo/views/profile/profile_create_view.dart';
import 'package:yorgo/widgets/map/map_search_input.dart';

Route<dynamic> routes(settings) {
  if (settings.name == SigninView.routeName) {
    return MaterialPageRoute(
      builder: (_) => SigninView(),
      settings: RouteSettings(name: SigninView.routeName),
    );
  } else if (settings.name == SignupView.routeName) {
    return MaterialPageRoute(
        builder: (_) => SignupView(),
        settings: RouteSettings(name: SignupView.routeName));
    //////////////////////// Profile /////////////////////////////////
  } else if (settings.name == ProfileCreateView.routeName) {
    return MaterialPageRoute(
      builder: (_) => ProfileCreateView(),
      settings: RouteSettings(name: ProfileCreateView.routeName),
    );
  } else if (settings.name == ProfileSportCreateView.routeName) {
    return MaterialPageRoute(
      builder: (_) => ProfileSportCreateView(),
      settings: RouteSettings(name: ProfileSportCreateView.routeName),
    );
  }
  ///////////////////////////////////////////////////////////////
  else if (settings.name == HomeView.routeName) {
    return MaterialPageRoute(
        builder: (_) => HomeView(),
        settings: RouteSettings(name: HomeView.routeName));
  } else if (settings.name == FluxView.routeName) {
    return MaterialPageRoute(
        builder: (_) => FluxView(),
        settings: RouteSettings(name: FluxView.routeName));
  } else if (settings.name == FriendView.routeName) {
    return MaterialPageRoute(
      builder: (_) => FriendView(),
      settings: RouteSettings(name: FriendView.routeName),
    );
  } else if (settings.name == ActivityView.routeName) {
    return MaterialPageRoute(
      builder: (_) => ActivityView(),
      settings: RouteSettings(name: ActivityView.routeName),
    );
  } else if (settings.name == FriendView.routeName) {
    return MaterialPageRoute(
      builder: (_) => FriendView(),
      settings: RouteSettings(name: FriendView.routeName),
    );
  } else if (settings.name == GroupView.routeName) {
    return MaterialPageRoute(
      builder: (_) => GroupView(),
      settings: RouteSettings(name: GroupView.routeName),
    );
  } else if (settings.name == LocalSportmenView.routeName) {
    return MaterialPageRoute(
      builder: (_) => LocalSportmenView(),
      settings: RouteSettings(name: LocalSportmenView.routeName),
    );
  } else if (settings.name == ActivitySearchView.routeName) {
    return MaterialPageRoute(
      builder: (_) => ActivitySearchView(),
      settings: RouteSettings(name: ActivitySearchView.routeName),
    );
  } else if (settings.name == HomeMainView.routeName) {
    return MaterialPageRoute(
      builder: (_) => HomeMainView(),
      settings: RouteSettings(name: HomeMainView.routeName),
    );
  } else if (settings.name == "/search") {
    return MaterialPageRoute(
      builder: (_) => SearchPage(),
      settings: RouteSettings(name: "/search"),
    );
  } else {
    return MaterialPageRoute(builder: (_) => NotFoundView());
  }
}
