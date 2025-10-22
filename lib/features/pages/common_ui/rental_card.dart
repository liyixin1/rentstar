import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentstar/features/pages/common_ui/app_text.dart';
import 'package:rentstar/features/repository/model/home_houseres_model.dart';
import 'package:rentstar/styles/app_colors.dart';

class RentalCard extends StatelessWidget{
  final HomeHouseResData? data;
  final GestureTapCallback? onTap;

  const RentalCard({
    super.key, this.data, this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    var tagList = generateTagList();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.lineColor,width: 1.r))
        ),
        padding: EdgeInsets.symmetric(vertical: 21.h),
        width: double.infinity,
        child: Row(children: [
          Image.network(
            data?.image ?? "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
            height: 96.h,
            width: 122.w,
            fit: BoxFit.fill
          ),
          SizedBox(width: 16.w),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            AppText(
              text: data?.title ?? "",
              textColor: AppColors.textColor2b,
              fontSize: 18.sp,
              maxLines: 2,
            ),
            // SizedBox(height: 10.h),
            AppText(
              text: data?.subTitle ?? "",
              textColor: AppColors.textColorB6,
              fontSize: 12.sp,
            ),
            tagList.isEmpty ? const SizedBox() : SizedBox(
              height: 30.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: tagList,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText(
                  text: data?.rent.toString() ?? "9999",
                  textColor: AppColors.textRedColor39,
                  fontSize: 18.sp
                ),
                AppText(
                  text: "元/月",
                  textColor: AppColors.textRedColor3D,
                  fontSize: 12.sp
                )
              ],
            )
          ],),)
        ],),
      ),
    );
  }
  Widget _tagWidget(String name,Color? color){
    return Container(
      alignment: Alignment.center,
      height: 30.h,
      color: AppColors.searchBgColor,
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: AppText(
        text: name ?? "",
        textColor: color ?? AppColors.textColor86,
      ),
    );
  }
  ///生成标签列表
  List<Widget> generateTagList() {
    List<Widget> tagList = [];
    if (data?.tagList?.isEmpty == true) {
      return tagList;
    }
    data?.tagList?.forEach((tag) {
      //type 标签类型：0=hot
      tagList.add(_tagWidget(
          tag.name ?? "在线签约", tag.type == "0" ? AppColors.textColorA9 : null));
      tagList.add(SizedBox(width: 10.w));
    });
    return tagList;
  }
}
