import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentstar/features/home/pages/home_page.dart';
import 'package:rentstar/features/listing/pages/listing_page.dart';
import 'package:rentstar/features/me/pages/me_page.dart';
import 'package:rentstar/features/news/pages/news_page.dart';

class TabPage extends StatefulWidget{
  const TabPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabPageState();
  }

}

class _TabPageState extends State<TabPage>{
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: IndexedStack(
            index: currentIndex,
            children: [
              HomePage(),
              ListingPage(),
              NewsPage(),
              MePage()
            ],
          )
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(splashColor: Colors.transparent,highlightColor: Colors.transparent),
          child: BottomNavigationBar(
          currentIndex: currentIndex,
          items: _barItemList(),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 14.sp,color: Colors.black),
          unselectedLabelStyle: TextStyle(fontSize: 12.sp,color:Colors.blueGrey),
          onTap: (index){
            currentIndex = index;
            setState(() {});
          }
      ),),
    );
  }
  List<BottomNavigationBarItem> _barItemList(){
    List<BottomNavigationBarItem> items= [
      BottomNavigationBarItem(
          label: "首页",
          icon: Image.asset("assets/images/icon_home_un.png",width: 24.r,height: 24.r),
          activeIcon: Image.asset("assets/images/icon_home.png",width: 24.r,height: 24.r)
      ),
      BottomNavigationBarItem(
          label: "房源",
          icon: Image.asset("assets/images/icon_search_house_un.png",width: 24.r,height: 24.r,),
          activeIcon: Image.asset("assets/images/icon_search_house.png",width: 24.r,height: 24.r)
      ),
      BottomNavigationBarItem(
          label: "资讯",
          icon: Image.asset("assets/images/icon_news_un.png",width: 24.r,height: 24.r,),
          activeIcon: Image.asset("assets/images/icon_news.png",width: 24.r,height: 24.r)
      ),
      BottomNavigationBarItem(
          label: "我的",
          icon: Image.asset("assets/images/icon_mine_un.png",width: 24.r,height: 24.r,),
          activeIcon: Image.asset("assets/images/icon_mine.png",width: 24.r,height: 24.r)
      )
    ];

    return items;
  }
}