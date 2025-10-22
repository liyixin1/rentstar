import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:rentstar/core/route/Routes.dart';
import 'package:rentstar/core/route/route_utils.dart';
import 'package:rentstar/features/pages/common_ui/app_text.dart';
import 'package:rentstar/features/pages/common_ui/big_title.dart';
import 'package:rentstar/features/pages/common_ui/filter_menu.dart';
import 'package:rentstar/features/pages/common_ui/icon_text.dart';
import 'package:rentstar/features/repository/model/home_betterchoice_model.dart';
import 'package:rentstar/features/viewmodel/home_view_model.dart';
import 'package:rentstar/styles/app_colors.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }

}
class _HomePageState extends State<HomePage>{
  final HomeViewModel _homeVM = HomeViewModel();
  final TextEditingController _editController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    try {
      await Future.wait([
        _homeVM.getHomeBanner(),
        _homeVM.getHomeBetterChoice(),
      ]);
    } catch (e) {
      // 错误处理，可以添加提示信息
      print("加载数据失败: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
        create: (context){
          return _homeVM;
          },
        child: GestureDetector(
          onTap: (){
            // 移除当前焦点
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: AppColors.blackColor1,
            body: SafeArea(
              child: Padding(
                  padding: EdgeInsets.only(left: 16.w,right: 16.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _titleBar(),
                        22.verticalSpace,
                        _bannerView(),
                        21.verticalSpace,
                        _jinGangView(),
                        BigTitle(bigTitle: "本期优选"),
                        _betterChoice(),
                        BigTitle(bigTitle: "周边推荐",showRight: true),
                        _mapView(),
                        BigTitle(bigTitle: "精选好房"),
                        // _filterArea()
                      ],
                    ),
                  )
              ),
            ),
          )
      )
    );
  }
  // 顶部位置、搜索、扫码
  Widget _titleBar({
    ValueChanged<String>? onSubmitted
  }) {
    return Container(
      color: Colors.teal,
      padding: EdgeInsets.only(left:8.w,top: 8.h,bottom: 8.h,right: 8.w),
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(children: [
        GestureDetector(
          onTap: (){
            RouteUtils.pushForNamed(context, RoutePath.citySelector);
          },
          child: FilterMenu(
            name: "地区",
            selected: true,
            backgroundColor: AppColors.blackColor3,
            // decoration: BoxDecoration(
            //   borderRadius:BorderRadius.only(
            //       topLeft: Radius.circular(16.r),
            //       bottomLeft: Radius.circular(16.r),
            //       topRight: Radius.zero,
            //       bottomRight: Radius.zero
            //   )
            // ),
          )
        ),
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

      ],),
    );
  }
  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            bottomLeft: Radius.zero,
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r)
        ));
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


  // 轮播图
  Widget _bannerView(){
    return Consumer<HomeViewModel>(builder: (context,vm,child){
      return SizedBox(
        height: 150.h,
        width: double.infinity,
        child: vm.banner == null 
          ? Center(child: CircularProgressIndicator()) // 添加加载状态
          : Swiper(
          autoplay:true,
          pagination:const SwiperPagination(),
          itemCount: vm.banner?.length ?? 3,
          control: const SwiperControl(),
          itemBuilder: (context,index){
            return Container(
              height: 150.h,
              color: Colors.lightBlue,
              child: Image.network(
                vm.banner?[index].imgurl ?? "",
                width: double.infinity,
                height: 150.h,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  // 添加图片加载错误时的处理
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.error),
                  );
                },
              ),
            );
          },
        ),
      );
    });
  }
  // 金刚区
  Widget _jinGangView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconText(
          text: "整租",
          iconSize: Size(32.w, 30.h),
          iconPath: "assets/images/icon_home_entire.png",
          onTap: (){

          },
        ),
        IconText(
          text: "合租",
          iconSize: Size(32.w, 30.h),
          iconPath: "assets/images/icon_home_shared.png",
          onTap: (){

          },
        ),
        IconText(
          text: "资讯",
          iconSize: Size(32.w, 30.h),
          iconPath: "assets/images/icon_home_new.png",
          onTap: (){

          },
        ),
        IconText(
          text: "新房源",
          iconSize: Size(32.w, 30.h),
          iconPath: "assets/images/icon_home_inquiry.png",
          onTap: (){

          },
        ),
      ].map((widget){
        return Flexible(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: widget,
        ),
        );
    }).toList(),
    );
  }
  //  本期优选
  Widget _betterChoice(){
    return SizedBox(
      width: double.infinity,
      height: 172.h,
      child: Selector<HomeViewModel, List<HomeBetterChoiceData>?>(
        builder: (context,List<HomeBetterChoiceData>? choiceList,child){
          if (choiceList == null) {
            return Center(child: CircularProgressIndicator()); // 添加加载状态
          }
          
          var data0 = _homeVM.generalBetterChoiceData(0);
          var data1 = _homeVM.generalBetterChoiceData(1);
          var data2 = _homeVM.generalBetterChoiceData(2);
          return Row(children: [
            _betterChoiceCard(
              height: 172.h,
              width: 172.w,
              imagePath: data0?.imgurl,
              imageHeight: 172.h,
              imageWidth: 172.w,
              title: data0?.title ?? "精品装修",
              titleSize: 16.sp,
              subTitle: data0?.subtitle ?? "舒适的环境",
              subTitleSize: 12.sp,
              onTap: (){
                //   路由跳转
              }
            ),
            SizedBox(width: 8.w),
            Expanded(child: Column(children: [
              _betterChoiceCard(
                  height: 80.h,
                  width: double.infinity,
                  imagePath: data1?.imgurl,
                  imageHeight: 80.h,
                  imageWidth: double.infinity,
                  title: data1?.title ?? "温馨小屋",
                  titleSize: 16.sp,
                  titleColor: AppColors.textColorAd,
                  subTitle: data1?.subtitle ?? "惬意的生活",
                  subTitleSize: 12.sp,
                  subTitleColor: AppColors.textColorAd,
                  onTap: (){
                    //   路由跳转
                  }
              ),
              SizedBox(height: 12.h),
              _betterChoiceCard(
                  height: 80.h,
                  width: double.infinity,
                  imagePath: data2?.imgurl,
                  imageHeight: 80.h,
                  imageWidth: double.infinity,
                  title: data2?.title ?? "大牌商圈",
                  titleSize: 16.sp,
                  titleColor: AppColors.textColorAd,
                  subTitle: data2?.subtitle ?? "更多选择",
                  subTitleSize: 12.sp,
                  subTitleColor: AppColors.textColorAd,
                  onTap: (){
                    //   路由跳转
                  }
              )
            ],))
          ],);
        },
        selector: (context,vm){
          return vm.betterChoice;
        }
      ),
    );
  }
  Widget _betterChoiceCard(
  {
    double? height,
    double? width,
    String? imagePath,
    double? imageHeight,
    double? imageWidth,
    EdgeInsetsGeometry? textPadding,
    String? title,
    String? subTitle,
    double? titleSize,
    double? subTitleSize,
    Color? titleColor,
    Color? subTitleColor,
    FontWeight? titleWeight,
    GestureTapCallback? onTap
  }){
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(children: [
          Image.network(
            imagePath ?? "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
            height: imageHeight,
            width: imageWidth,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              // 添加图片加载错误时的处理
              return Container(
                color: Colors.grey[300],
                child: Icon(Icons.error),
              );
            },
          ),
          Container(
            padding: textPadding ?? EdgeInsets.only(left: 12.h,top: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: title ?? "",
                  fontSize: titleSize ?? 18.sp,
                  fontWeight: titleWeight ?? FontWeight.w500,
                  textColor: titleColor ?? Colors.black,
                ),
                AppText(
                  text: subTitle ?? "",
                  fontSize: subTitleSize ?? 12.sp,
                  textColor: subTitleColor ?? Colors.black,
                )
              ],
            ),
          )
        ],),
      ),
    );
  }
  Widget _mapView(){
    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      height: 162.h,
      width: double.infinity,
      child: Image.asset(
        "assets/images/icon_home.png",
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill
      ),
    );
  }
  // Widget _filterArea(){
  //   List<String> rentTier = ['不限','1-500元','500-1000元','1000-1500元','1500-2000元','2000-3000元','3000-5000元','5000-8000元','8000元以上'];
  //   List<String> Layout = ['不限','一室','两室','三室','四室及以上'];
  //   List<DropdownMenuItem> =
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       DropdownButton(
  //           items: items,
  //           onChanged: onChanged
  //
  //       )
  //       // DropdownMenu(
  //       //   menuHeight: 200.h,
  //       //   dropdownMenuEntries: _buildMenuList(rentTier),
  //       //   initialSelection: ,
  //       //   onSelected: (value){
  //       //
  //       //   },
  //       // )
  //       FilterMenu(name: "区域",selected: true),
  //       FilterMenu(name: "租金"),
  //       FilterMenu(name: "户型"),
  //       FilterMenu(name: "筛选"),
  //     ],
  //   );
  // }
  // List<DropdownMenuEntry<String>> _buildMenuList(List<String> data) {
  //   return data.map((String value) {
  //     return DropdownMenuEntry<String>(value: value, label: value);
  //   }).toList();
  // }
}