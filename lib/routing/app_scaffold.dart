import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatefulWidget{
  StatefulNavigationShell navigationShell;
  AppScaffold({super.key, required this.navigationShell});
  @override
  State<StatefulWidget> createState() {

    return _AppScaffoldState();
  }
}
class _AppScaffoldState extends State<AppScaffold>{
  int pageIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: widget.navigationShell,
       bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            print("Index: $index");
            widget.navigationShell.goBranch(index);
            setState(() {
              pageIndex = index;
            });
          },
          currentIndex: pageIndex,
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home ${pageIndex}"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings")
        ]),
    );
  }
}