import 'dart:io';
import 'package:feed_list_module/p_main_app/screens_p/news_feed_bean/news_feed_bean.dart';
import 'package:feed_list_module/p_main_app/utils_p/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../utils_p/app_color.dart';
import '../utils_p/app_dimens.dart';
import '../utils_p/custome_view.dart';
class FeedsScreen extends StatefulWidget {
  @override
  _FeedsScreen createState() => _FeedsScreen();
}
class _FeedsScreen extends State<FeedsScreen>
    with WidgetsBindingObserver {

 List<Feeds> mFeedsList = new List();

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  _FeedsScreen(){
    getFeeds();
  }

  /*Pul To refresh*/
  void _onRefresh() async {
  }

  void _onLoading() async {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //getDeviceInfo();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // user returned to our app
    } else if (state == AppLifecycleState.inactive) {
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      // user is about quit our app temporally
    }
  }

  @override
  Widget build(BuildContext context) {
    //Get Screen size
    appDimens.appDimensFind(context: context);
    /* NewsFeed Card  */
    /*  Post Comment Section  */
    Widget postCommentSection(String postId, bool postLiked, int currentIndex) {

      return Container(
          margin: EdgeInsets.only(
              top: appDimens.verticalMarginPadding(value: 14)),
          child: Padding(
            padding: EdgeInsets.only(
              left: 0,
            ),
            child: Row(
              children: <Widget>[
                Container(
                    height: appDimens.heightDynamic(value: 28),
                    width: appDimens.widthDynamic(value: 28),
                    decoration: BoxDecoration(
                      color: postLiked
                          ? appColors.iconColor[400]
                          : appColors.appBgColor[300],
                      shape: BoxShape.rectangle,
                      borderRadius:
                      BorderRadius.all(Radius.circular(appDimens.heightDynamic(value: 35))),
                    ),
                    child: GestureDetector(
                      child: Center(
                        child: Image(
                          image: postLiked
                              ? AssetImage(
                              "assets/images/smile.png")
                              : AssetImage(
                              "assets/images/smile.png"),
                          width:appDimens.heightDynamic(value: 25),
                          height: appDimens.heightDynamic(value: 25),
                        ),
                      ),
                      onTap: () {
                        if (postId != null && postId.length > 0) {
                          bool isLike = !postLiked;
                         // likeComment(postId, isLike, currentIndex);
                        }
                      },
                    )),

              ],
            ),
          ));
    }
    /* Profile view */
    Widget profileSection(
        {Key key,
          String fullName,
          String image,
          String time,
          String createdBy,
          String chatUid,
          String postId,
          int currentIndex,
          rowAllData}) {
      if (time != null) {
       // time = new ProjectUtil().getTimeAgo(timestamp: int.parse(time));
        time = "10:05 PM";
      }

      return GestureDetector(
        onTap: () {

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                customView.circularImageOrNameView(
                appDimens.widthDynamic(value: 37),
                appDimens.widthDynamic(value: 37),
                image,
                fullName),
            Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.only(
                    left: appDimens.horizontalMarginPadding(value: 13)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 1),
                      child: Text(
                        fullName != null ? fullName : "",
                        style: TextStyle(
                          fontFamily:
                          appFonts.defaultFont,
                          fontWeight: FontWeight.w500,
                          fontSize: appDimens.fontSize(value: 16),
                          color: appColors.textNormalColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Text(
                        time != null ? "$time" : "",
                        style: TextStyle(
                          fontFamily:
                          appFonts.defaultFont,
                          fontWeight: FontWeight.w400,
                          fontSize: appDimens.fontSize(value: 12),
                          color: appColors.textNormalColor[300],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      );
    }

    /* Horizontal Divider */
    Widget divider() {
      return Divider(
        color: appColors.appDividerColor[600],
        height: 1.0,
      );
    }

    Widget newsFeedCard(index) {
      if (mFeedsList != null && index < mFeedsList.length) {
        int currentIndex = index;
        Feeds mFeeds = mFeedsList[index];
        String fullName = "",
            firstName = "",
            lastName = "",
            postTitle = "",
            userImage,
            postTime = "",
            createdBy = "",
            chatUid,
            postReactionCount = "",
            postCommentCount = "",
            postId;
        bool postLiked = false;
        List<String> postImages = new List();
        List<CommentList> commentList = new List();
        if (mFeeds != null) {
          try {
            firstName = mFeeds.firstName != null
                ? customView.getDecodedValue((mFeeds.firstName.trim()))
                : mFeeds.firstName;

            lastName = mFeeds.lastName != null
                ? customView.getDecodedValue((mFeeds.lastName.trim()))
                : mFeeds.lastName;

            fullName = (firstName != null &&
                firstName != '' &&
                lastName != null &&
                lastName != '')
                ? customView.getDecodedValue(firstName + " " + lastName)
                : (firstName != null && firstName != '')
                ? customView.getDecodedValue(firstName)
                : (lastName != null && lastName != '')
                ? customView.getDecodedValue(lastName)
                : '';
            createdBy = mFeeds.createdBy != null ? mFeeds.createdBy : null;
            chatUid = mFeeds.uid != null ? mFeeds.uid : null;
            postId = mFeeds.postId;
            postLiked = mFeeds.postLiked!=null ? mFeeds.postLiked:false;
            //postTime = mFeeds.createdAt;
            postTime = "10:30 AM";
            postTitle = mFeeds.postTitle != null
                ? customView.getDecodedValue((mFeeds.postTitle.trim()))
                : "";

            userImage = mFeeds.profileThumbnail != null
                ? mFeeds.profileThumbnail
                : null;
            postReactionCount =
            mFeeds.likeCount != null ? mFeeds.likeCount.toString() : "0";
            postCommentCount = mFeeds.totalComment != null
                ? mFeeds.totalComment.toString()
                : "0";
            if (mFeeds.postImages != null && mFeeds.postImages.length > 0) {
              postImages.addAll(mFeeds.postImages);
            } else {
              postImages = new List();
            }

            if (mFeeds.commentList != null && mFeeds.commentList.length > 0) {
              commentList.addAll(mFeeds.commentList);
            } else {
              commentList = new List();
            }
          } catch (e) {
            print(e);
          }
        }
        return mFeeds != null
            ? Card(
            elevation: 0.8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            margin: EdgeInsets.only(
              left: appDimens.horizontalMarginPadding(value: 20),
              right: appDimens.horizontalMarginPadding(value: 20),
              bottom: appDimens.verticalMarginPadding(value: 7),
              top: appDimens.verticalMarginPadding(value: 7),
            ),
            child: Container(
              padding: EdgeInsets.all(appDimens.horizontalMarginPadding(value: 14)),
              decoration: BoxDecoration(
                color: appColors.white,
                borderRadius:
                BorderRadius.all(Radius.circular(appDimens.horizontalMarginPadding(value: 20))),
              ),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  //News posted user profile
                  profileSection(
                      fullName: fullName,
                      image: userImage,
                      time: postTime,
                      chatUid: chatUid,
                      createdBy: createdBy,
                      postId: postId,
                      currentIndex: currentIndex,
                      rowAllData: mFeeds),

                  (postTitle != null && postTitle != '')
                      ? Padding(
                    padding: EdgeInsets.only(
                        top: appDimens.verticalMarginPadding(value: 15)),
                    child: Text(
                      postTitle,
                      style: TextStyle(
                          fontFamily: appFonts.mediumFont,
                          //fontWeight: FontWeight.w400,
                          fontSize: appDimens.fontSize(value: 14),
                          color: appColors.textNormalColor),
                    ),
                  )
                      : Container(),
                  (postImages != null && postImages.length > 0)
                      ? Container(
                    margin: EdgeInsets.only(top: appDimens.heightDynamic(value: 10)),
                    child: Container(height: appDimens.heightDynamic(value: 200),child: Image(image: NetworkImage(postImages[0]),fit: BoxFit.cover,),) /*postedImageSection1(postImages)*/,
                  )
                      : Container(),

                  Padding(
                      padding: EdgeInsets.only(
                          top: appDimens.verticalMarginPadding(value: 8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage(
                                    "assets/images/smile.png"),
                                width: appDimens.horizontalMarginPadding(value: 25),
                                height: appDimens.horizontalMarginPadding(value: 25),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: appDimens.horizontalMarginPadding(value: 4)),
                                child: Text(
                                  "$postReactionCount Reactions",
                                  style: TextStyle(
                                      fontFamily: appFonts.defaultFont,
                                      fontWeight: FontWeight.w400,
                                      fontSize: appDimens.fontSize(value: 12),
                                      color: appColors.textNormalColor),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage(
                                    "assets/images/sms.png"),
                                width: appDimens.horizontalMarginPadding(value: 25),
                                height: appDimens.horizontalMarginPadding(value: 25),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: appDimens.horizontalMarginPadding(value: 4)),
                                child: Text(
                                  "$postCommentCount Comments",
                                  style: TextStyle(
                                      fontFamily: appFonts.defaultFont,
                                      fontWeight: FontWeight.w400,
                                      fontSize: appDimens.fontSize(value: 12),
                                      color: appColors.textNormalColor),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),

                  Padding(
                    padding: EdgeInsets.only(
                        top: appDimens.verticalMarginPadding(value: 14)),
                    child: divider(),
                  ),

                  (commentList != null && commentList.length > 0)
                      ? Padding(
                    padding: EdgeInsets.only(
                        top: appDimens.verticalMarginPadding(value: 14)),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: (commentList != null &&
                          commentList.length > 0)
                          ? commentList.length
                          : 0,
                      itemBuilder: (context, index) {
                        String commentText = "",
                            commentBy = "",
                            chatUid,
                            commentByName = "",
                            profilePic;
                        try {
                          CommentList mCommentList =
                          commentList[index];
                          if (mCommentList != null) {
                            chatUid = mCommentList.uid != null
                                ? mCommentList.uid
                                : null;
                            postId = mCommentList.postId != null
                                ? mCommentList.postId
                                : null;
                            commentText =
                            mCommentList.commentText != null
                                ? customView.getDecodedValue((mCommentList
                                .commentText
                                .trim()))
                                : "";

                            commentBy = mCommentList.commentBy != null
                                ? customView.getDecodedValue((mCommentList
                                .commentBy
                                .trim()))
                                : "";

                            commentByName =
                            mCommentList.commentByName != null
                                ? customView.getDecodedValue((mCommentList
                                .commentByName
                                .trim()))
                                : "";
                            profilePic =
                            mCommentList.profilePic != null
                                ? mCommentList.profilePic
                                : null;
                          }
                        } catch (e) {
                          print(e);
                        }
                        return Padding(
                          padding: EdgeInsets.only(
                              top: appDimens.verticalMarginPadding(value: 2)),
                          child: Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: customView.circularImageOrNameView(
                                      appDimens.widthDynamic(
                                          value: 37),
                                      appDimens.widthDynamic(
                                          value: 37),
                                      profilePic,
                                      commentByName),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: appDimens.horizontalMarginPadding(
                                            value: 9)),
                                    decoration: BoxDecoration(
                                      color: appColors
                                          .appBgColor[300],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(appDimens.widthDynamic(value: 10))),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: appDimens.horizontalMarginPadding(
                                                value: 8),
                                            right: appDimens.horizontalMarginPadding(
                                                value: 8),
                                            top: appDimens.horizontalMarginPadding(
                                                value: 6),
                                            bottom: appDimens.horizontalMarginPadding(
                                                value: 6)),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            GestureDetector(
                                                onTap: () {
                                                },
                                                child: Text(
                                                  commentByName,
                                                  style: TextStyle(
                                                      fontFamily: appFonts.defaultFont,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500,
                                                      color: appColors.textNormalColor[
                                                      500],
                                                      fontSize: appDimens.fontSize(
                                                          value:
                                                          12)),
                                                  maxLines: 1,
                                                  textAlign:
                                                  TextAlign.left,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                )),
                                            Padding(
                                              padding:
                                              EdgeInsets
                                                  .only(top: 2),
                                              child: Text(
                                                commentText,
                                                textAlign:
                                                TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily:
                                                    appFonts.defaultFont,
                                                    fontWeight:
                                                    FontWeight
                                                        .w400,
                                                    decoration:
                                                    TextDecoration
                                                        .none,
                                                    color: appColors.textNormalColor[
                                                    400],
                                                    fontSize: appDimens.fontSize(
                                                        value:
                                                        12)),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            padding:
                            EdgeInsets.only(top: 5, bottom: 5),
                          ),
                        );
                      },
                    ),
                  )
                      : Container(),

                  postCommentSection(postId, postLiked, currentIndex),
                ],
              ),
            ))
            : Container();
      } else {
        return Container();
      }
    }

    Widget listView(mFeedsList) {
      return (mFeedsList != null && mFeedsList.length > 0)
          ? ListView.builder(
          //controller: _controller,
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: (mFeedsList != null && mFeedsList.length > 0)
              ? mFeedsList.length
              : 0,
          itemBuilder: (context, index) {
            return newsFeedCard(index);
          })
          : customView.noDataFound(
          appDimens.heightFullScreen() / 1.25);
    }

    Widget centerItemsViewPull = SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: null,
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: listView(mFeedsList));

    //Main view
    return Scaffold(
        backgroundColor: appColors.appBgColor[100],
        appBar: PreferredSize(
            child: AppBar(
              brightness: (Platform.isIOS) ? Brightness.light : Brightness.dark,
              backgroundColor:
                  appColors.primaryColor,
            ),
            preferredSize: Size.fromHeight(0.0)),
        body: Container(child: Stack(
          children: <Widget>[
            Center(
                child: centerItemsViewPull),
          ],
        ),));
  }

    //Move to next screen
  void moveToLoginScreen() {
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginWithEmailScreen())
    );*/
  }


  //Get feeds
  void getFeeds() {
    mFeedsList = new List();
    Feeds mFeeds = Feeds();
    mFeeds.firstName = "John";
    mFeeds.lastName = "Shinha";
    mFeeds.postTitle = "Hello all";
    mFeeds.profileThumbnail = "https://images.unsplash.com/flagged/photo-1573740144655-bbb6e88fb18a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";
    mFeeds.likeCount = 5;
    mFeeds.postImages = ["https://rtcstorage01.z29.web.core.windows.net/article/nature_photographer_norway_lofoten_archipelago_2U8VRFW_e8477f21-fa1f-41af-8a1b-d722aff4fdb4.jpg","https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTutQWu2axdkXoxUk6WxaxUMbUFMgUdZA53fTgpXipjG3UJB9Vq"];
    mFeeds.uid = "1abcd";
    mFeeds.postId = "1abcd";
    mFeedsList.add(mFeeds);

    mFeeds = Feeds();
    mFeeds.firstName = "Rock";
    mFeeds.lastName = "Mike";
    mFeeds.postTitle = "Hi, all";
    mFeeds.profileThumbnail = "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";
    mFeeds.likeCount = 50;
    mFeeds.postImages = ["https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60","https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTc4EbWT212m5yviwWOjoR8y5VcMXWDIOUeYvC2zLAk3qQGKTNe"];
    mFeeds.uid = "1abcd";
    mFeeds.postId = "1abcd";
    mFeedsList.add(mFeeds);

    mFeeds = Feeds();
    mFeeds.firstName = "John";
    mFeeds.lastName = "Shinha";
    mFeeds.postTitle = "Hello all";
    mFeeds.profileThumbnail = "https://images.unsplash.com/flagged/photo-1573740144655-bbb6e88fb18a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";
    mFeeds.likeCount = 5;
    mFeeds.postImages = ["https://rtcstorage01.z29.web.core.windows.net/article/nature_photographer_norway_lofoten_archipelago_2U8VRFW_e8477f21-fa1f-41af-8a1b-d722aff4fdb4.jpg","https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTutQWu2axdkXoxUk6WxaxUMbUFMgUdZA53fTgpXipjG3UJB9Vq"];
    mFeeds.uid = "1abcd";
    mFeeds.postId = "1abcd";
    mFeedsList.add(mFeeds);

    mFeeds = Feeds();
    mFeeds.firstName = "Rock";
    mFeeds.lastName = "Mike";
    mFeeds.postTitle = "Hi, all";
    mFeeds.profileThumbnail = "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";
    mFeeds.likeCount = 50;
    mFeeds.postImages = ["https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60","https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTc4EbWT212m5yviwWOjoR8y5VcMXWDIOUeYvC2zLAk3qQGKTNe"];
    mFeeds.uid = "1abcd";
    mFeeds.postId = "1abcd";
    mFeedsList.add(mFeeds);

  }
  }


