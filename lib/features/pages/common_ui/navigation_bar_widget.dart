import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentstar/features/pages/common_ui/navigation_bar_item.dart';
import 'package:rentstar/styles/app_colors.dart';

class NavigationBarWidget extends StatefulWidget{
  NavigationBarWidget({
    super.key,
    required this.tabItems,
    required this.tabLabels,
    required this.tabIcons,
    required this.tabActiveIcons,
    this.currentIndex = 0,
    this.themeData,
    this.onItemChange,
    this.bottomNavigationBarType,
    this.bottomBarIconWidth,
    this.bottomBarIconHeight
}){
    if(tabItems.length != tabLabels.length &&
      tabItems.length != tabIcons.length &&
      tabItems.length != tabActiveIcons.length){
      throw Exception("NavigationBar error");
    }
  }

  final List<Widget> tabItems;

  final List<String> tabLabels;

  final List<String> tabIcons;

  final List<String> tabActiveIcons;

  int currentIndex = 0;

  // 底部导航切换事件
  final ValueChanged<int>? onItemChange;

  final ThemeData? themeData;

  final BottomNavigationBarType? bottomNavigationBarType;

  final double? bottomBarIconWidth;
  final double? bottomBarIconHeight;

  @override
  State<StatefulWidget> createState() {
    return _NavigationBarWidgetState();
  }
}

class _NavigationBarWidgetState extends State<NavigationBarWidget>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onItemChange?.call(widget.currentIndex);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // tab页面
      body: IndexedStack(index: widget.currentIndex,children: widget.tabItems,),
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24.r,
        selectedFontSize: 14.sp,
        unselectedFontSize: 12.sp,
        selectedItemColor: AppColors.blackColor333,
        unselectedItemColor: AppColors.unblackColor333,
        backgroundColor: Colors.white,
        type: widget.bottomNavigationBarType ?? BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        onTap: (index){
          if(widget.currentIndex == index){
            return;
          }
          widget.onItemChange?.call(index);
          widget.currentIndex = index;
          setState(() {});
        },
        items: _barItemList(),
      ),
    );
  }
  List<BottomNavigationBarItem> _barItemList(){
    List<BottomNavigationBarItem> items = [];
    for(var i = 0; i < widget.tabItems.length;i++){
      items.add(
        BottomNavigationBarItem(
          activeIcon: NavigationBarItem(builder:(context){
            return _iconContainer(widget.tabActiveIcons[i]);
          }),
          icon: _iconContainer(widget.tabIcons[i]),
          label: widget.tabLabels[i]
        )
      );
    }
    return items;
  }

  Widget _iconContainer(String iconPath){
    return Container(
      padding: EdgeInsets.only(top: 8.h,bottom: 4.h),
      child: Image.asset(
        iconPath,
        width: widget.bottomBarIconWidth ?? 24.r,
        height: widget.bottomBarIconHeight ?? 24.r,
      ),
    );
  }

}