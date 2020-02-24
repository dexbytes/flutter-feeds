import 'package:feed_list_module/p_main_app/utils_p/app_dimens.dart';
import 'package:feed_list_module/p_main_app/utils_p/app_fonts.dart';
import 'package:feed_list_module/p_main_app/utils_p/custome_view.dart';
import 'package:flutter/material.dart';

class CustomLeftProfileAppBar{

  //App bar
  Widget appBarHomeProfileWithTittleAndRightIcon({Key key,double statusbarHeight,@required String title,Color titleColor,double titleFontSize,@required String profileUrl, double profileSize,String rightIcon,String notificationCount,double rightIconSize,
      Color appBarBgColor, String name,Function() onProfilePressed,Function() onNotificationPressed}) {
    return
      PreferredSize(
        preferredSize: Size(appDimens.widthFullScreen(),
            appDimens.heightDynamic(value: 85-statusbarHeight,)),
        child:  Container(
            padding: EdgeInsets.only(top: appDimens.verticalMarginPadding(value: 41,),
              bottom: appDimens.verticalMarginPadding(value: 5,),
            left: appDimens.horizontalMarginPadding(value:20 ,),
            right: appDimens.horizontalMarginPadding(value:20 ,),
            ),
           // color:Colors.red,
            color:appBarBgColor,
            child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    //Left Profile image
                    appBarUserProfile(profileUrl,profileSize,onProfilePressed , name),
                    Expanded(child: Container(
                      //color: Colors.red,
                      margin: EdgeInsets.only(left: appDimens.horizontalMarginPadding(value: 5)),
                      width: appDimens.widthFullScreen()-40,
                      child: Center(
                      child: Text(title!=null?title:"",
                        style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: appFonts.mediumFont,
                          color: titleColor,
                          fontSize:titleFontSize!=null?titleFontSize:appDimens.fontSize(value: 5),
                        ),maxLines: 1,),
                    ),),flex: 6,),

                    Expanded(
                      child: Container(
                        child: rightIcon!=null?Align(
                          alignment: Alignment.centerRight,
                      child:  Padding(
                          padding: EdgeInsets.only(right: appDimens.horizontalMarginPadding(value: 0)),
                          child:GestureDetector(
                                  onTap: () =>
                                    onNotificationPressed()
                                   ,
                                  child:Image(
                                        image: AssetImage(rightIcon),
                                        width: rightIconSize!=null?rightIconSize:appDimens.iconSquareCustom(value: 18),
                                        height: rightIconSize!=null?rightIconSize:appDimens.iconSquareCustom(value: 18),
                                      ),
                                  ))
                    ):Container(),))
                  ],
                ),
        )
      );
  }

  Widget appBarUserProfile(_profileImage,profileSize,onProfilePressed , name) => GestureDetector(
      onTap: () {
        onProfilePressed();
      },
      child: Container(
        child: customView.circularImageOrNameView(
            profileSize!=null?profileSize:appDimens.imageSquareAccordingScreen(value: 12),
            profileSize!=null?profileSize:appDimens.imageSquareAccordingScreen(value: 12),
            _profileImage , name),
      )

  );

}

final CustomLeftProfileAppBar customLeftProfileAppBar = new CustomLeftProfileAppBar();