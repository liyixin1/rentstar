import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentstar/features/pages/common_ui/app_text.dart';
import 'package:rentstar/styles/app_colors.dart';

class FilterMenu extends StatefulWidget{
  final String name;
  final bool? selected;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final GestureTapCallback? onTap;
  final Decoration? decoration;

  const FilterMenu({super.key, required this.name, this.selected, this.backgroundColor, this.padding, this.onTap, this.decoration});

  @override
  State<StatefulWidget> createState() {
    return _FilterMenuState();
  }

}

class _FilterMenuState extends State<FilterMenu>{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        constraints: BoxConstraints(maxWidth: 100.w),
        // decoration: widget.decoration ?? BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(4.r))
        // ),
        padding: widget.padding ?? EdgeInsets.only(left: 14.w,right: 16.w,top: 12.h,bottom: 12.h),
        color: widget.backgroundColor ?? AppColors.searchBgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: widget.name,
              fontSize: 16.sp,
              textColor: widget.selected == true ? AppColors.titleColor3030 : AppColors.textColorAd,
            ),
            SizedBox(width: 5.w),
            Image.asset(
              widget.selected == true ? "assets/images/icon_filled_triangle_down.png" : "assets/images/icon_filled_triangle_down_grey.png",
              width: 8.w,
              height: 6.h
            )
          ],
        ),
      ),
    );
  }

}