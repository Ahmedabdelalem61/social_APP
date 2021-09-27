import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_todo/layout/social_app/social_states.dart';
import 'package:task_todo/models/shop_app/login_model/login_model.dart';
import 'package:task_todo/models/social_app/message_model.dart';
import 'package:task_todo/models/social_app/post_model.dart';
import 'package:task_todo/models/social_app/social_user_model.dart';
import 'package:task_todo/modules/news_app/settings/settings.dart';
import 'package:task_todo/modules/social_app/social_chat_screen/social_chat_screen.dart';
import 'package:task_todo/modules/social_app/social_home_screen/social_home_screen.dart';
import 'package:task_todo/modules/social_app/social_settings_screen/social_settings_screen.dart';
import 'package:task_todo/modules/social_app/social_users_screen/social_users_screen.dart';
import 'package:task_todo/shared/network/local/cashe_helper.dart';
import 'package:task_todo/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocilaUserModel model;
  List<SocialPostModel> posts = [];

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      print('uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu$uid');
      print(value.data());
      model = SocilaUserModel.fromJson(value.data());
      emit(SocialGetUserSuccesState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  void chaneNavButton(int index) {
    getUserData();
    if(index == 1)
      getUsers();
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeNavButtonState());
    }
  }

  List<Widget> screens = [
    SocialHomeScreen(),
    SocialChatScreen(),
    SocialChatScreen(),
    SocialUsersScreen(),
    SocialSettingsScreen()
  ];

  List<String> titles = ['Home', 'Chat', 'Chat', 'Users', 'Profile'];

  File profileImage;
  final picker = ImagePicker();
  File coverImage;

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ImageProfilePickerSucessState());
    } else {
      print('No image selected.');
      emit(ImageProfilePickerErrorState());
    }
  }

  Future getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(ImageCoverPickerSucessState());
    } else {
      print('No image selected.');
      emit(ImageCoverPickerErrorState());
    }
  }

  String ImageUrl = "";
  String CoverUrl = "";

  void uploadProfileImage({
    @required String name,
    @required String bio,
    @required String phone,
    String image,
    String cover,
  }) {
    emit(ProfileUpdatingSuccessState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(ImageProfileUPloadingSuccesState());
        print('the image path is ${value}');
        ImageUrl = value;
        UpdateUserData(phone: phone, name: name, bio: bio, image: value);
      }).catchError((error) {
        emit(ImageProfileUPloadingErrorState());
        print(error);
      });
    }).catchError((error) {
      emit(ImageProfileUPloadingErrorState());
      print(error);
    });
  }

  void uploadCoverImage({
    @required String name,
    @required String bio,
    @required String phone,
    String image,
    String cover,
  }) {
    emit(ProfileUpdatingSuccessState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(ImageCoverUPloadingSuccesState());
        print('the image path is ${value}');
        CoverUrl = value;
        UpdateUserData(phone: phone, name: name, bio: bio, cover: value);
      }).catchError((error) {
        emit(ImageCoverUPloadingErrorState());
        print(error);
      });
    }).catchError((error) {
      emit(ImageCoverUPloadingErrorState());
      print(error);
    });
  }

  void UpdateUserData({
    @required String name,
    @required String bio,
    @required String phone,
    String image,
    String cover,
  }) {
    SocilaUserModel userModel = SocilaUserModel(
      email: model.email,
      phone: phone,
      name: name,
      bio: bio,
      uid: model.uid,
      isEmailVerified: false,
      image: image ?? model.image,
      cover: cover ?? model.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uid)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((err) {
      emit(ProfileUpdatingErrorState());
      print(err);
    });
  }

  void update({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    uploadCoverImage(
      bio: bio,
      name: name,
      phone: phone,
    );
    uploadProfileImage(
      bio: bio,
      name: name,
      phone: phone,
    );
  }

  File PostImage;

  Future getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      PostImage = File(pickedFile.path);
      emit(ImagePostPickerSucessState());
    } else {
      print('No image selected.');
      emit(ImagePostPickerErrorState());
    }
  }

  void uploadPostImage({
    @required String post,
    @required String dateTime,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(PostImage.path).pathSegments.last}')
        .putFile(PostImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('the image path is ${value}');
        CoverUrl = value;
        uploadPost(post: post, dateTime: dateTime, imageOfPost: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
        print(error);
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
      print(error);
    });
  }

  void uploadPost({
    @required String dateTime,
    @required String post,
    String imageOfPost = '',
  }) {
    emit(SocialCreatePostUploadingState());
    SocialPostModel postModel = SocialPostModel(
        name: model.name,
        image: model.image,
        uid: model.uid,
        dateTime: dateTime,
        post: post,
        postImage: imageOfPost);
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((err) {
      emit(SocialCreatePostErrorState());
      print(err);
    });
  }

  void removePostImage() {
    PostImage = null;
    emit(SocialRemoveImagePostState());
  }


  List<String> postIds = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          postIds.add(element.id);
          posts.add(SocialPostModel.fromJson(element.data()));
          likes.add(value.docs.length);
        }).catchError((error) {});

        emit(SocialGetUserSuccesState());
      });
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  void likePost(postid) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('likes')
        .doc(model.uid)
        .set({'like': true}).then((value) {
      emit(SocialUsersLikeSuccesState());
    }).catchError((error) {
      emit(SocialUsersLikeErrorState(error.toString()));
    });
  }

  List<SocilaUserModel> users = [];

  void getUsers() {
    if(users.length==0)
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            emit(SocialGetAllUsersSuccesState());
            users.add(SocilaUserModel.fromJson(element.data()));
          });
    })
        .catchError((error) {
      emit(SocialGetAllUsersErrorState(error));
    });
  }
  void sendMessage({
  @required text,
    @required receiverId,
    @required dateTime,
}){
    MessageModel messageModel  = MessageModel(
       dateTime: dateTime,
      text: text,
      receiverId: receiverId,
      senderId: model.uid
    );
    FirebaseFirestore.instance.collection('users')
        .doc(model.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(messageModel.toMap()).then((value) {
          emit(SocialGetMessageSuccesState());
    }).catchError((error){
      emit(SocialGetMessageErrorState(error));
    });
    FirebaseFirestore.instance.collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model.uid)
        .collection('message')
        .add(messageModel.toMap()).then((value) {
      emit(SocialGetMessageSuccesState());
    }).catchError((error){
      emit(SocialGetMessageErrorState(error));
    });
  }
  List<MessageModel> messagesModel = [];
  void receiveMessage({
    @required receiverId,
}){
    FirebaseFirestore.instance.collection('users')
        .doc(model.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message').orderBy('dateTime')
        .snapshots().listen((event) {
           messagesModel = [];
          event.docs.forEach((element) {
            messagesModel.add(MessageModel.fromJson(element.data()));
            print('.........................................${element.data()}');
          });
      emit(SocialGetMessageSuccesState());
    });
  }
}
