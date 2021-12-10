import 'package:flutter/material.dart';

class tabBarMenu extends StatefulWidget {
  final List<Widget> listContentTab;
  final List<String> listTab;
  final int length;

  const tabBarMenu({
    Key? key,
    required this.listContentTab,
    required this.listTab,
    required this.length,
  }) : super(key: key);

  @override
  State<tabBarMenu> createState() => _tabBarMenuState();
}

class _tabBarMenuState extends State<tabBarMenu> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.length, // length of tabs
      initialIndex: _tabIndex,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: DecoratedBox(
                //This is responsible for the background of the tabbar, does the magic
                decoration: BoxDecoration(
                  //This is for background color
                  color: Colors.white.withOpacity(0.0),
                  //This is for bottom border that is needed
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 1.5)),
                ),
                child: TabBar(
                  labelColor: Theme.of(context).colorScheme.primary,
                  labelStyle:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
                  tabs: getTabs(widget.listTab),
                  onTap: (value) {
                    setState(() {
                      _tabIndex = value;
                    });
                  },
                ),
              ),
            ),
            /*TabBarView(children: listContentTab), */

            TabsView(
              tabIndex: _tabIndex,
              children: widget.listContentTab,
            )
          ]),
    );
  }

  getTabs(List<String> listTab) {
    List<Widget> list = [];
    for (var i = 0; i < listTab.length; i++) {
      list.add(Text(
        listTab[i],
      ));
    }
    return list;
  }
}

class TabsView extends StatelessWidget {
  TabsView({Key? key, required this.tabIndex, required this.children})
      : super(key: key);

  final int tabIndex;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    var SizeConfig = MediaQuery.of(context).size;
    return Stack(
      children: getTabsViewContent(SizeConfig, children),
    );
  }

  List<Widget> getTabsViewContent(Size SizeConfig, List<Widget> children) {
    List<Widget> content = [];

    for (var i = 0; i < children.length; i++) {
      int negatif;
      if (tabIndex == i) {
        negatif = 0;
      } else if (tabIndex > i) {
        negatif = -i - 1;
      } else {
        negatif = i + 1;
      }
      content.add(AnimatedContainer(
        child: children[i],
        width: SizeConfig.width,
        transform: Matrix4.translationValues(negatif * SizeConfig.width, 0, 0),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      ));
    }
    return content;
  }
}
