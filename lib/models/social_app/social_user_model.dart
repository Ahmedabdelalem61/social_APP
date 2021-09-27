class SocilaUserModel{

   String email;
   String uid;
   String phone;
   String name;
   String image;
   bool isEmailVerified ;
   String bio;
   String cover;
   SocilaUserModel({
     this.cover,
     this.image,
     this.name,
     this.email,
     this.phone,
     this.uid,
     this.isEmailVerified,
     this.bio,
   });

   SocilaUserModel.fromJson(Map<String,dynamic>json){
     email = json['email'];
     cover = json['cover'];
     uid = json['uid'];
     phone = json['phone'];
     name = json['name'];
     isEmailVerified = json['isEmailVerified'];
     image = json['image'];
     bio = json['bio'];
   }
   Map<String,dynamic> toMap(){
     return {
       'cover':cover,
       'name':name,
       'email':email,
       'phone':phone,
       'uid':uid,
       'isEmailVerified':isEmailVerified,
       'image':image,
       'bio':bio,
     };
   }

}