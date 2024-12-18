import 'package:flutter/material.dart';

import '../../constanats/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({required this.title})
  {}
   late String title;
  @override
  Widget build(BuildContext context) {
    return  AppBar(
      backgroundColor:AppColors.appBarColor,
      title:Text(title,style:const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500
      ),) ,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
