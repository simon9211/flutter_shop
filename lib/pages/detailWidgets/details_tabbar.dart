import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';

class DetailTabBar extends StatelessWidget {

  final items = ['详情', '评论'];

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(builder: (context, child, val) {
      final int index = Provide.value<DetailsInfoProvide>(context).idx;
      return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Row(
            children: items.asMap().keys.map((i){
              return InkWell(
                onTap: (){
                  Provide.value<DetailsInfoProvide>(context).tabSelectIndex(i);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(375),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: i == index? Colors.pink:Colors.black12
                      )
                      )
                  ),
                  child: Text(
                    items[i],
                    style: TextStyle(
                      color:i == index? Colors.pink:Colors.black
                    )
                  ),
                ),
              );
            }).toList(),
          ));
    });
  }
}
