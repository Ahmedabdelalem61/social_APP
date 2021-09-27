class SocialPostModel{

  String uid;
  String name;
  String image;
  String postImage;
  String dateTime;
  String post;
  SocialPostModel({
    this.name,
    this.image,
    this.uid,
    this.post,
    this.dateTime,
    this.postImage
  });

  SocialPostModel.fromJson(Map<String,dynamic>json){
    uid = json['uid'];
    postImage = json['postImage'];
    name = json['name'];
    image = json['image'];
    dateTime = json['dateTime'];
    post = json['post'];
  }
  Map<String,dynamic> toMap(){
    return {
      'uid':uid,
      'postImage':postImage,
      'name':name,
      'image':image,
      'dateTime':dateTime,
      'post':post,
    };
  }

}