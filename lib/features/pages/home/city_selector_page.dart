import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rentstar/core/route/Routes.dart';
import 'package:rentstar/core/route/route_utils.dart';
import 'package:rentstar/core/utils/json/json_model.dart';
import 'package:rentstar/features/pages/common_ui/app_text.dart';
import 'package:rentstar/features/viewmodel/city_selector_view_model.dart';
import 'package:rentstar/styles/app_colors.dart';

class CitySelectorPage extends StatefulWidget{

  const CitySelectorPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _CitySelectorPageState();
  }
}

class _CitySelectorPageState extends State<CitySelectorPage>{
  CitySelectorViewModel csVM = CitySelectorViewModel();
  final TextEditingController _editController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context){ return csVM;},
    child: Scaffold(
      backgroundColor: AppColors.blackColor1,
      body: SafeArea(child: Column(
      children: [
        _searchBar(
          onTapFinish: ()=> RouteUtils.pop(context)
        ),
        8.verticalSpace,
        _hotCityGridView()
    ],)),),);
  }



  Widget _searchBar({
    GestureTapCallback? onTapFinish,
    ValueChanged<String>? onSubmitted
  }){
    return Container(
      color: Colors.teal,
      height: 50.h,
      child: Row(children: [
        SizedBox(width: 5.h,),
        GestureDetector(
          onTap: onTapFinish,
          child: Image.asset(
            "assets/images/icon_close.png",
            width: 30.r,
            height: 30.r,
          ),
        ),
        SizedBox(width: 10.w,),
        Expanded(child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: TextField(
            textAlign: TextAlign.start,
            controller: _editController,
            style: TextStyle(color: AppColors.textColor20,fontSize: 16.sp),
            decoration: _inputDecoration(),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            onSubmitted: onSubmitted
          ),
        )),
        SizedBox(width: 10.w,)
      ],),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(15.r)));
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
        contentPadding: EdgeInsets.only(left: 10.w),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(),
        border: _inputBorder());
  }

  Widget _hotCityGridView({
    // List<City>? cityList,
    GestureTapCallback? onTap
  }){
    List<String> hotCities = [
      '北京','上海','广州',
      '深圳','西安','成都',
      '杭州','武汉','苏州',
    ];
    return Container(
      height: 180.h,
      width: double.infinity,
      padding: EdgeInsets.only(left: 8.w,right: 8.w,top: 8.h),
      alignment: Alignment.centerLeft,
      color: AppColors.blackColor2,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity, // 关键：强制宽度无限大
            child: AppText(text: '热门',fontSize: 16.sp,fontWeight: FontWeight.w500,)
          ),
          SizedBox(height: 4.h,),
          Expanded(child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 3.5,
            mainAxisSpacing: 10, // 行间距
            crossAxisSpacing: 10, // 列间距
            children: hotCities.take(9).map(
                    (item) => _gridItem(
                        name: item,
                      onTap: (){
                        RouteUtils.pushNamedAndRemoveUntil(context, RoutePath.tab);
                      }
                    )).toList(),
          ))

        ],
      ),
    );
  }
  Widget _gridItem({
    required String name,
    GestureTapCallback? onTap
  }){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration:
        BoxDecoration(
            border: BoxBorder.all(color: AppColors.lineColor,width: 1),
            color: AppColors.textBgColorFF,
            borderRadius: BorderRadius.circular(8)
        ),
        child: AppText(text: name),
      ),
    );
  }
  // // 全国城市列表
  // Widget _allCitiesListView(){
  //
  // }

}