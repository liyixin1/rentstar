import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentstar/styles/app_colors.dart';

enum AppTextType {
  homeBigTitle,
}


class AppText extends StatelessWidget{
  final AppTextType? type;
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLines;
  final TextOverflow? overflow;
  const AppText({
    super.key,
    this.type,
    required this.text,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.maxLines,
    this.overflow
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _style(),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
  TextStyle _style(){
    if(type == AppTextType.homeBigTitle){
      return TextStyle(
        color: textColor ?? AppColors.titleColor3030,
        fontSize: fontSize ?? 18.sp,
        fontWeight: fontWeight ?? FontWeight.w600
      );
    }else{
      return TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight
      );
    }
  }
}