import 'package:flutter/material.dart';
//Page Import :
import 'package:yorgo/views/activity/activity_home_view.dart';
import 'package:yorgo/views/activity/my_activity_view.dart';
import 'package:yorgo/views/auth/signin_view.dart';
import 'package:yorgo/views/auth/signup_view.dart';
import 'package:yorgo/views/flux/flux_view.dart';
import 'package:yorgo/views/friend/friend_home_view.dart';
import 'package:yorgo/views/group/group_view.dart';
import 'package:yorgo/views/home/Home_main_view.dart';
import 'package:yorgo/views/home/home_views.dart';
import 'package:yorgo/views/local_sportmen/local_sportmen_view.dart';
import 'package:yorgo/views/message/message_home_view.dart';
import 'package:yorgo/views/not_found_view.dart';
import 'package:yorgo/views/profile/profile_edit_view.dart';
import 'package:yorgo/views/profile/profile_sport_create.dart';
import 'package:yorgo/views/profile/profile_create_view.dart';
import 'package:yorgo/views/profile/profile_sport_edit.dart';
import 'package:yorgo/views/setting/settingMenuView.dart';
import 'package:yorgo/widgets/map/map_search_input.dart';

Route<dynamic> routes(settings) {
  /////////////////////////// Home Menu ////////////////////////////////////////
  if (settings.name == HomeView.routeName) {
    return MaterialPageRoute(
        builder: (_) => HomeView(),
        settings: RouteSettings(name: HomeView.routeName));
  } else if (settings.name == HomeMainView.routeName) {
    return MaterialPageRoute(
      builder: (_) => HomeMainView(),
      settings: RouteSettings(name: HomeMainView.routeName),
    );
  }
  //////////////////////////////////////////////////////////////////////////////

  /////////////////////////// Auth View /////////////////////////////////////////
  else if (settings.name == SigninView.routeName) {
    return MaterialPageRoute(
      builder: (_) => SigninView(),
      settings: RouteSettings(name: SigninView.routeName),
    );
  } else if (settings.name == SignupView.routeName) {
    return MaterialPageRoute(
        builder: (_) => SignupView(),
        settings: RouteSettings(name: SignupView.routeName));
  }
  //////////////////////////////////////////////////////////////////////////////

  /////////////////////////// Activity Menu 01 /////////////////////////////////
  else if (settings.name == ActivityHomeView.routeName) {
    return MaterialPageRoute(
      builder: (_) => ActivityHomeView(),
      settings: RouteSettings(name: ActivityHomeView.routeName),
    );
  } else if (settings.name == MyActivityView.routeName) {
    return MaterialPageRoute(
      builder: (_) => MyActivityView(),
      settings: RouteSettings(name: MyActivityView.routeName),
    );
  }
  //////////////////////////////////////////////////////////////////////////////

  /////////////////////////// Message Menu 02 /////////////////////////////////
  else if (settings.name == MessageHomeView.routeName) {
    return MaterialPageRoute(
        builder: (_) => MessageHomeView(),
        settings: RouteSettings(name: MessageHomeView.routeName));
  }
  //////////////////////////////////////////////////////////////////////////////

  ////////////////////////////// Flux Menu 03 /////////////////////////////////
  else if (settings.name == FluxView.routeName) {
    return MaterialPageRoute(
        builder: (_) => FluxView(),
        settings: RouteSettings(name: FluxView.routeName));
  }
  //////////////////////////////////////////////////////////////////////////////

  ////////////////////////// Notification Menu 04 /////////////////////////////
  /////////////////////////////////////////////////////////////////////////////

  /////////////////////////// Profile Menu 05 /////////////////////////////////
  // Create
  else if (settings.name == ProfileCreateView.routeName) {
    return MaterialPageRoute(
      builder: (_) => ProfileCreateView(),
      settings: RouteSettings(name: ProfileCreateView.routeName),
    );
  } else if (settings.name == ProfileSportCreateView.routeName) {
    return MaterialPageRoute(
      builder: (_) => ProfileSportCreateView(),
      settings: RouteSettings(name: ProfileSportCreateView.routeName),
    );
    // Edit
  } else if (settings.name == ProfileEditView.routeName) {
    return MaterialPageRoute(
      builder: (_) => ProfileEditView(),
      settings: RouteSettings(name: ProfileEditView.routeName),
    );
  } else if (settings.name == ProfileSportEditView.routeName) {
    return MaterialPageRoute(
      builder: (_) => ProfileSportEditView(),
      settings: RouteSettings(name: ProfileSportEditView.routeName),
    );
  }
  ///////////////////////////////////////////////////////////////

  /////////////////////// Drawer View ///////////////////////////
  else if (settings.name == SettingMenuView.routeName) {
    return MaterialPageRoute(
      builder: (_) => SettingMenuView(),
      settings: RouteSettings(name: SettingMenuView.routeName),
    );
  } else if (settings.name == FriendHomeView.routeName) {
    return MaterialPageRoute(
      builder: (_) => FriendHomeView(),
      settings: RouteSettings(name: FriendHomeView.routeName),
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
  }
  ///////////////////////////////////////////////////////////////

  ////////////////////////// Map OSM ///////////////////////////
  else if (settings.name == "/search") {
    return MaterialPageRoute(
      builder: (_) => SearchPage(),
      settings: RouteSettings(name: "/search"),
    );
  }
  ///////////////////////////////////////////////////////////////
  else {
    return MaterialPageRoute(builder: (_) => NotFoundView());
  }
}
