import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:rentstar/features/home/home_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }

}
class _HomePageState extends State<HomePage>{
  var model = HomeViewModel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context){
      return model;
    },builder: (BuildContext context,Widget? child){
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150.h,
                  width: double.infinity,
                  child: Swiper(
                    autoplay:true,
                    pagination:const SwiperPagination(),
                    itemCount: 3,
                    control: const SwiperControl(),
                    itemBuilder: (context,index){
                      return Container(
                        height: 150.h,
                        color: Colors.lightBlue,
                        // child: Image.asset(name),
                      );
                    },

                  ),
                )
              ],
            ),
          )
        ),
      );
    },);
  }

}