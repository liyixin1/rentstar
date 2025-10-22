import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentstar/styles/app_colors.dart';

class IconText extends StatelessWidget{
  const IconText({
    super.key,
    this.iconSize,
    this.text,
    this.iconPath,
    this.middleMargin,
    this.textStyle,
    this.onTap

  });
  final Size? iconSize;
  final String? text;
  final String? iconPath;
  final double? middleMargin;
  final TextStyle? textStyle;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath ?? "",width: iconSize?.width,height: iconSize?.height,),
          SizedBox(height: middleMargin ?? 4.h,),
          Text(
            text ?? "",
            style: textStyle ?? TextStyle(color: AppColors.textColor5e,fontSize: 14.sp),
          )
        ],
      ),
    );
  }
}