class NewsFeedBean {
  bool error;
  Success success;

  NewsFeedBean({this.error, this.success});

  NewsFeedBean.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    success =
        json['success'] != null ? new Success.fromJson(json['success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.success != null) {
      data['success'] = this.success.toJson();
    }
    return data;
  }
}

class Success {
  int statusCode;
  String name;
  String message;
  Data data;

  Success({this.statusCode, this.name, this.message, this.data});

  Success.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    name = json['name'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['name'] = this.name;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Feeds> feeds;

  Data({this.feeds});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['feeds'] != null) {
      feeds = new List<Feeds>();
      json['feeds'].forEach((v) {
        feeds.add(new Feeds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feeds != null) {
      data['feeds'] = this.feeds.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feeds {
  String postId;
  String postTitle;
  PostCheckin postCheckin;
  String eventId;
  String createdAt;
  bool postLiked;
  List<String> postImages;
  String profilePic;
  String profileThumbnail;
  String createdBy;
  String fullName;
  String firstName;
  String lastName;
  String uid;
  int likeCount;
  int totalComment;
  List<CommentList> commentList;

  Feeds(
      {this.postId,
      this.postTitle,
      this.postCheckin,
      this.eventId,
      this.createdAt,
      this.postLiked,
      this.postImages,
      this.profilePic,
      this.profileThumbnail,
      this.createdBy,
      this.fullName,
      this.firstName,
      this.lastName,
      this.uid,
      this.likeCount,
      this.totalComment,
      this.commentList});

  Feeds.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    postTitle = json['post_title'];
    postCheckin = json['post_checkin'] != null
        ? new PostCheckin.fromJson(json['post_checkin'])
        : null;
    eventId = json['event_id'];
    createdAt = json['created_at'];
    postLiked = json['post_liked'];
    postImages = json['post_images'].cast<String>();
    profilePic = json['profile_pic'];
    profileThumbnail = json['profile_thumbnail'];
    createdBy = json['created_by'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    uid = json['uid'];
    likeCount = json['like_count'];
    totalComment = json['total_comment'];
    if (json['comment_list'] != null) {
      commentList = new List<CommentList>();
      json['comment_list'].forEach((v) {
        commentList.add(new CommentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['post_title'] = this.postTitle;
    if (this.postCheckin != null) {
      data['post_checkin'] = this.postCheckin.toJson();
    }
    data['event_id'] = this.eventId;
    data['created_at'] = this.createdAt;
    data['post_liked'] = this.postLiked;
    data['post_images'] = this.postImages;
    data['profile_pic'] = this.profilePic;
    data['profile_thumbnail'] = this.profileThumbnail;
    data['created_by'] = this.createdBy;
    data['full_name'] = this.fullName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['uid'] = this.uid;
    data['like_count'] = this.likeCount;
    data['total_comment'] = this.totalComment;
    if (this.commentList != null) {
      data['comment_list'] = this.commentList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostCheckin {
  String latitude;
  String longitude;
  String addresses;

  PostCheckin({this.latitude, this.longitude, this.addresses});

  PostCheckin.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    addresses = json['addresses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['addresses'] = this.addresses;
    return data;
  }
}

class CommentList {
  String commentId;
  String postId;
  String commentText;
  String createdAt;
  String commentBy;
  String profilePic;
  String commentByName;
  String uid;

  CommentList(
      {this.commentId,
      this.postId,
      this.commentText,
      this.createdAt,
      this.commentBy,
      this.profilePic,
      this.commentByName,
      this.uid});

  CommentList.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    postId = json['post_id'];
    commentText = json['comment_text'];
    createdAt = json['created_at'];
    commentBy = json['comment_by'];
    profilePic = json['profile_pic'];
    commentByName = json['comment_by_name'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this.commentId;
    data['post_id'] = this.postId;
    data['comment_text'] = this.commentText;
    data['created_at'] = this.createdAt;
    data['comment_by'] = this.commentBy;
    data['profile_pic'] = this.profilePic;
    data['comment_by_name'] = this.commentByName;
    data['uid'] = this.uid;
    return data;
  }
}
