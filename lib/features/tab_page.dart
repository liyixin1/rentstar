import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentstar/features/pages/common_ui/navigation_bar_widget.dart';
import 'package:rentstar/features/pages/home/home_page.dart';
import 'package:rentstar/features/pages/listing/listing_page.dart';
import 'package:rentstar/features/pages/me/me_page.dart';
import 'package:rentstar/features/pages/news/news_page.dart';

class TabPage extends StatefulWidget{
  const TabPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabPageState();
  }

}

class _TabPageState extends State<TabPage>{
  int currentIndex = 0;
  final List<Widget> tabItems = [];
  final List<String> tabLabels = ["首页","房源","资讯","我的"];
  final List<String> tabIcons = [
    "assets/images/icon_home_un.png",
    "assets/images/icon_search_house_un.png",
    "assets/images/icon_news_un.png",
    "assets/images/icon_mine_un.png"
  ];
  final List<String> tabActiveIcons = [
    "assets/images/icon_home.png",
    "assets/images/icon_search_house.png",
    "assets/images/icon_news.png",
    "assets/images/icon_mine.png"
  ];
  @override
  void initState() {
    super.initState();
    initTabPage();
  }

  // @override
  // void dispose() {
  //   WebSocketInstance.instance.close();
  //   super.dispose();
  // }

  void initTabPage(){
    tabItems.add(HomePage());
    tabItems.add(ListingPage());
    tabItems.add(NewsPage());
    tabItems.add(MePage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: NavigationBarWidget(
        tabItems:tabItems,
        tabLabels:tabLabels,
        tabIcons:tabIcons,
        tabActiveIcons:tabActiveIcons
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //         child: IndexedStack(
  //           index: currentIndex,
  //           children: [
  //             HomePage(),
  //             ListingPage(),
  //             NewsPage(),
  //             MePage()
  //           ],
  //         )
  //     ),
  //     bottomNavigationBar: Theme(
  //         data: Theme.of(context)
  //             .copyWith(splashColor: Colors.transparent,highlightColor: Colors.transparent),
  //         child: BottomNavigationBar(
  //         currentIndex: currentIndex,
  //         items: _barItemList(),
  //         type: BottomNavigationBarType.fixed,
  //         selectedLabelStyle: TextStyle(fontSize: 14.sp,color: Colors.black),
  //         unselectedLabelStyle: TextStyle(fontSize: 12.sp,color:Colors.blueGrey),
  //         onTap: (index){
  //           currentIndex = index;
  //           setState(() {});
  //         }
  //     ),),
  //   );
  // }
  // List<BottomNavigationBarItem> _barItemList(){
  //   List<BottomNavigationBarItem> items= [
  //     BottomNavigationBarItem(
  //         label: "首页",
  //         icon: Image.asset("assets/images/icon_home_un.png",width: 24.r,height: 24.r),
  //         activeIcon: Image.asset("assets/images/icon_home.png",width: 24.r,height: 24.r)
  //     ),
  //     BottomNavigationBarItem(
  //         label: "房源",
  //         icon: Image.asset("assets/images/icon_search_house_un.png",width: 24.r,height: 24.r,),
  //         activeIcon: Image.asset("assets/images/icon_search_house.png",width: 24.r,height: 24.r)
  //     ),
  //     BottomNavigationBarItem(
  //         label: "资讯",
  //         icon: Image.asset("assets/images/icon_news_un.png",width: 24.r,height: 24.r,),
  //         activeIcon: Image.asset("assets/images/icon_news.png",width: 24.r,height: 24.r)
  //     ),
  //     BottomNavigationBarItem(
  //         label: "我的",
  //         icon: Image.asset("assets/images/icon_mine_un.png",width: 24.r,height: 24.r,),
  //         activeIcon: Image.asset("assets/images/icon_mine.png",width: 24.r,height: 24.r)
  //     )
  //   ];
  //
  //   return items;
  // }
}