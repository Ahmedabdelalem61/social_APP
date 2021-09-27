import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/social_app/social_cubit.dart';
import 'package:task_todo/layout/social_app/social_states.dart';
import 'package:task_todo/modules/social_app/social_edit_profile_screen/social_edit_profile.dart';
import 'package:task_todo/shared/components/news_component.dart';
import 'package:task_todo/shared/styles/icon_broken.dart';

class SocialSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,builder: (context,state){
        var moedel = SocialCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 210,
                child: Stack(
                  // alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160,
                      child: Image(
                        image: NetworkImage(
                            '${moedel.cover}'
                        ),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height:150 ,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        radius: 65,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              '${moedel.image}'
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('${moedel.name}',style: Theme.of(context).textTheme.headline6,),
              Text('${moedel.bio}',style: Theme.of(context).textTheme.caption,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('2k',style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 14
                            ),),
                            Text('posts',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('100',style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 14
                            ),),
                            Text('photos',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('2k',style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 14
                            ),),
                            Text('Follower',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('5',style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 14
                            ),),
                            Text('Following',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: (){},child: Text('Post photos'),)),
                  SizedBox(width: 10,),
                  OutlinedButton(
                    onPressed: (){
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(IconBroken.Edit),
                  )
                ],
              )
            ],
          ),
        );
    },
    );
  }
}
