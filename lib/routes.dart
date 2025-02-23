import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:yorgo/models/data/activity_model.dart';
import 'package:yorgo/views/activity/activity_category_view.dart';
import 'package:yorgo/views/activity/activity_create_alone.dart';
import 'package:yorgo/views/activity/activity_create_group.dart';
import 'package:yorgo/views/activity/activity_details.dart';
//Page Import :
import 'package:yorgo/views/activity/my_activity_view.dart';
import 'package:yorgo/views/auth/signin_view.dart';
import 'package:yorgo/views/auth/signup_view.dart';
import 'package:yorgo/views/flux/flux_search_content.dart';
import 'package:yorgo/views/friend/friend_home_view.dart';
import 'package:yorgo/views/group/group_view.dart';
import 'package:yorgo/views/home/Home_main_view.dart';
import 'package:yorgo/views/home/home_views.dart';
import 'package:yorgo/views/local_sportmen/local_sportmen_view.dart';
import 'package:yorgo/views/message/message_new.dart';
import 'package:yorgo/views/message/message_sportsmen_room_view.dart';
import 'package:yorgo/views/not_found_view.dart';
import 'package:yorgo/views/profile/profile_edit_view.dart';
import 'package:yorgo/views/profile/profile_other_view.dart';
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
  else if (settings.name == ActivityCreateAloneView.routeName) {
    return MaterialPageRoute(
      builder: (_) => ActivityCreateAloneView(),
      settings: RouteSettings(name: ActivityCreateAloneView.routeName),
    );
  } else if (settings.name == ActivityCreateGroupView.routeName) {
    return MaterialPageRoute(
      builder: (_) => ActivityCreateGroupView(),
      settings: RouteSettings(name: ActivityCreateGroupView.routeName),
    );
  } else if (settings.name == MyActivityView.routeName) {
    return MaterialPageRoute(
      builder: (_) => MyActivityView(),
      settings: RouteSettings(name: MyActivityView.routeName),
    );
  } else if (settings.name == ActivityDetailsView.routeName) {
    final args = settings.arguments as ActivityArguments;
    return MaterialPageRoute(
      builder: (_) => ActivityDetailsView(
        idActivity: args.idActivity,
        activity: args.activity,
      ),
      settings: RouteSettings(name: ActivityDetailsView.routeName),
    );
  } else if (settings.name == ActivityCategoryView.routeName) {
    final args = settings.arguments as ActivityCategoryArguments;
    return MaterialPageRoute(
      builder: (_) => ActivityCategoryView(
        nameCategory: args.nameCategory,
        idCategory: args.idCategory,
        initMapActivityByDate: args.initMapActivityByDate,
      ),
      settings: RouteSettings(name: ActivityCategoryView.routeName),
    );
  }
  //////////////////////////////////////////////////////////////////////////////

  /////////////////////////// Message Menu 02 /////////////////////////////////
  else if (settings.name == MessageNewView.routeName) {
    return MaterialPageRoute(
        builder: (_) => MessageNewView(),
        settings: RouteSettings(name: MessageNewView.routeName));
  } else if (settings.name == MessageSportsmenRoom.routeName) {
    final args = settings.arguments as PrivateRoomArguments;
    return MaterialPageRoute(
      builder: (_) => MessageSportsmenRoom(
        channel: args.channel,
        friend: args.friend,
        room_id: args.room_id,
      ),
      settings: RouteSettings(name: MessageSportsmenRoom.routeName),
    );
  }
  //////////////////////////////////////////////////////////////////////////////

  ////////////////////////////// Flux Menu 03 /////////////////////////////////
  else if (settings.name == FluxSearchContentView.routeName) {
    return MaterialPageRoute(
        builder: (_) => FluxSearchContentView(),
        settings: RouteSettings(name: FluxSearchContentView.routeName));
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
  } else if (settings.name == ProfileOtherView.routeName) {
    final args = settings.arguments as IdArguments;
    return MaterialPageRoute(
      builder: (_) => ProfileOtherView(id: args.id),
      settings: RouteSettings(name: ProfileOtherView.routeName),
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
    final args = settings.arguments as FriendArguments;
    return MaterialPageRoute(
      builder: (_) => FriendHomeView(tabIndex: args.tabIndex),
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

//argument
class IdArguments {
  final int id;

  IdArguments(this.id);
}

class FriendArguments {
  final int tabIndex;
  FriendArguments(this.tabIndex);
}

class ActivityCategoryArguments {
  final int idCategory;
  final String nameCategory;
  final Map<String, List<Activity>> initMapActivityByDate;
  ActivityCategoryArguments(
      this.idCategory, this.nameCategory, this.initMapActivityByDate);
}

class ActivityArguments {
  final int idActivity;
  final Activity activity;

  ActivityArguments(this.idActivity, this.activity);
}

class PrivateRoomArguments {
  final WebSocketChannel channel;
  final dynamic friend;
  final int room_id;
  PrivateRoomArguments(this.channel, this.friend, this.room_id);
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
