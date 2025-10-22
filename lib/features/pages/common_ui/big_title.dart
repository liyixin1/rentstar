import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentstar/features/pages/common_ui/app_text.dart';
import 'package:rentstar/styles/app_colors.dart';

class BigTitle extends StatelessWidget{
  final String? bigTitle;
  final bool? showRight;
  final double? titleSize;
  final GestureTapCallback? onRightTap;
  final EdgeInsetsGeometry? padding;
  const BigTitle({
    super.key,
    this.bigTitle,
    this.showRight,
    this.titleSize,
    this.onRightTap,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    var title = AppText(
      type: AppTextType.homeBigTitle,
      text:bigTitle ?? "",
      fontSize: titleSize
    );
    return Container(
      padding: padding ?? EdgeInsets.only(top: 21.h,bottom: 26.h,left: 16.w),
      alignment: Alignment.centerLeft,
      child: showRight == true ? Row(
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
          title,
          const Expanded(child: SizedBox()),
          GestureDetector(
            onTap: onRightTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                    text: "更多",
                    fontSize:14.sp,
                    textColor: AppColors.textColor7d
                ),
                SizedBox(width: 6.w),
                Image.asset("assets/images/icon_right_arrow_grey.png",width: 6.w,height: 12.h,)
              ],
            ),
          )
        ],
      )
    :title);
  }

}