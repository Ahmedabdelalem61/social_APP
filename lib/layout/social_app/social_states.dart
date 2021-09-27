abstract class SocialStates{}

class SocialInitialStates extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccesState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String erorr;
  SocialGetUserErrorState(this.erorr);
}
class SocialChangeNavButtonState extends SocialStates{}

class SocialNewPostState extends SocialStates{}
class ImageProfilePickerSucessState extends SocialStates{}
class ImageProfilePickerErrorState extends SocialStates{}
class ImageCoverPickerSucessState extends SocialStates{}
class ImageCoverPickerErrorState extends SocialStates{}
class ImageCoverUPloadingSuccesState extends SocialStates{}
class ImageCoverUPloadingErrorState extends SocialStates{}
class ImageProfileUPloadingSuccesState extends SocialStates{}
class ImageProfileUPloadingErrorState extends SocialStates{}
class ImageProfiLeLoadingSuccesState extends SocialStates{}
class ImageCoverLoadingSuccesState extends SocialStates{}
class ProfileUpdatingSuccessState extends SocialStates{}
class ProfileUpdatingErrorState extends SocialStates{}

// posting states
class ImagePostPickerSucessState extends SocialStates{}
class ImagePostPickerErrorState extends SocialStates{}
class SocialCreatePostUploadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}
class SocialRemoveImagePostState extends SocialStates{}
//get users posts state
class SocialGetUsersLoadingState extends SocialStates{}
class SocialGetUsersSuccesState extends SocialStates{}
class SocialGetUsersErrorState extends SocialStates{
  final String erorr;
  SocialGetUsersErrorState(this.erorr);
}
//likes state
class SocialUsersLikeSuccesState extends SocialStates{}
class SocialUsersLikeErrorState extends SocialStates{
  final String erorr;
  SocialUsersLikeErrorState(this.erorr);
}
//chat stetes
class SocialGetAllUsersLoadingState extends SocialStates{}
class SocialGetAllUsersSuccesState extends SocialStates{}
class SocialGetAllUsersErrorState extends SocialStates{
  final String erorr;
  SocialGetAllUsersErrorState(this.erorr);
}
class SocialGetMessageLoadingState extends SocialStates{}
class SocialGetMessageSuccesState extends SocialStates{}
class SocialGetMessageErrorState extends SocialStates{
  final String erorr;
  SocialGetMessageErrorState(this.erorr);
}
