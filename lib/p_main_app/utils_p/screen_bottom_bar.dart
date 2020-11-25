import 'package:fullter_main_app/p_main_app/utils_p/app_color.dart';
import 'package:flutter/material.dart';

class ScreenBottomBar extends StatefulWidget {
  final index,selectedBottomMenu;
  ScreenBottomBar(this.index,this.selectedBottomMenu);

  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState(index,selectedBottomMenu);
}

class _BottomNavigationBarState extends State<ScreenBottomBar> {
  var screenSize, screenHeight, screenWidth;
  var indexXYZ;
  int _selectedIndex =0;
  List<BarItemsDetails> bottomNavigationBarItems = [];
  bool isBackground = true;
  BarItemsDetails _barItem ;

  _BottomNavigationBarState(index,selectedBottomMenu){
    indexXYZ=index;
    _selectedIndex = selectedBottomMenu;
  }

  /*============add items for bottom bar===========*/
  addBottomBarItems(){

    _barItem = BarItemsDetails('assets/images/tabbar_path.png','assets/images/tabbar_path_active.png',1);
    bottomNavigationBarItems.add(_barItem);

    _barItem = BarItemsDetails('assets/images/tabbar_user.png','assets/images/tabbar_user_active.png',2);
    bottomNavigationBarItems.add(_barItem);

    _barItem = BarItemsDetails('assets/images/add.png','assets/images/tabbar_chat_active.png',3);
    bottomNavigationBarItems.add(_barItem);

    _barItem = BarItemsDetails('assets/images/tabbar_chat.png','assets/images/tabbar_chat_active.png',4);
    bottomNavigationBarItems.add(_barItem);

    _barItem = BarItemsDetails('assets/images/tabbar_menu.png','assets/images/tabbar_menu_active.png',5);
    bottomNavigationBarItems.add(_barItem);
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize.height - kToolbarHeight;
    screenWidth = screenSize.width;

    if(bottomNavigationBarItems.length<=0){
      addBottomBarItems();
    }

    double _bottomBarHeightTemp = kBottomNavigationBarHeight;
    double _bottomBarWidth = screenWidth;

    Color _selectedItemColor = appColors.bottomBarSelectedItemIconColor;
    Color _unSelectedItemColor = appColors.bottomBarDisabledItemColor;

    //double _bottomBarIconSize = screenHeight/10;
    double _bottomBarIconSize = _bottomBarHeightTemp/2.15;
    double _bottomBarCenterIconSize = _bottomBarHeightTemp/5;
    double _bottomBarHeight = _bottomBarHeightTemp;           //Update app bar height according center button

    /*===========common function for bar item ===================*/
    barItems(String icon,int itemIndex,String iconSelected,int index){
      return  BottomNavigationBarItem(
      //  backgroundColor: Colors.red,
        icon: Image(image: AssetImage((itemIndex==_selectedIndex)?iconSelected:icon),
          width: index==3?_bottomBarCenterIconSize:_bottomBarIconSize,
          height:index==3?_bottomBarCenterIconSize: _bottomBarIconSize,color: (itemIndex==_selectedIndex)?_selectedItemColor:_unSelectedItemColor,
        ),
        title:SizedBox.shrink(),
      );
    }


    /*=====================get bar items=================*/
    List<BottomNavigationBarItem> getItems(){
      if(bottomNavigationBarItems!=null){
        List<BottomNavigationBarItem> items = new List();
        print(' bottomNavigationBarItems ${bottomNavigationBarItems.length}');
        for(int i=0;i<bottomNavigationBarItems.length;i++){
          print(' item $i');

          items.add(barItems(bottomNavigationBarItems[i].icon,i,bottomNavigationBarItems[i].iconSelected,bottomNavigationBarItems[i].index));
        }
        return items;
      }else{
        print('no item');
        return null;
      }
    }


    /*================on item tapped====================*/
    _onItemTapped(int index) {
     if(index==0){
       setState(() {
         _selectedIndex = index;
       });
       print('index============ $_selectedIndex');
       print('index $index');
       indexXYZ(index,false);
     }
     if(index==1){
       setState(() {
         _selectedIndex = index;
       });
       print('index============ $_selectedIndex');
       print('index $index');
       indexXYZ(index,false);
     }
     if(index==2){

       indexXYZ(index,true);
     }
     if(index==3){
       setState(() {
         _selectedIndex = index;
       });
       print('index============ $_selectedIndex');
       print('index $index');
       indexXYZ(index,false);
     }
     if(index==4){
       indexXYZ(index,true);
     }

    }


    /*=====================return navigation bar view========================*/
    return SafeArea(
        child:
        Container(
          color: appColors.bottomBarBgColor,
          height: (_bottomBarHeight+((_bottomBarHeight/3.5))),
          child: Stack(children: <Widget>[
          Container(
              height: _bottomBarHeight,
              width: _bottomBarWidth,
              color: appColors.bottomBarBgColor,
              child: Padding(
                padding: EdgeInsets.only(top: 0),
                child: BottomNavigationBar(
                  backgroundColor: appColors.bottomBarBgColor,
                  type:BottomNavigationBarType.fixed,
                  elevation: 0,
                  /*backgroundColor:  _bottomBarBg,*/
                  currentIndex: _selectedIndex,
                  selectedItemColor: _selectedItemColor,
                  unselectedItemColor: _unSelectedItemColor,
                  items:getItems(),
                  onTap:_onItemTapped,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                ),
              )
          ),

          Container(
            child:
          Align(child: new Container(
              margin: new EdgeInsets.only(top: 0.0,bottom:0.0,right:0.0),
              child:  GestureDetector(
                child:
                Container(
                  child: Image.asset(
                    'assets/images/add_border@3x.png',
                  ),
                  height: (_bottomBarHeight+((_bottomBarHeight/3.5))),
                  width: (_bottomBarHeight+((_bottomBarHeight/3.5))),
                ),
                onTap: () => setState(() {
                  _onItemTapped(2);
                }) ,
              )
          ),alignment: Alignment.topCenter,),)
        ],),));
  }
}


class BarItemsDetails{
  String icon;
  String iconSelected;
  int index;

  BarItemsDetails(String icon, String iconSelected,int index){
    this.icon = icon;
    this.iconSelected = iconSelected;
    this.index =index;
  }
}