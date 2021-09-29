
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/social_app/social_cubit.dart';
import 'package:task_todo/layout/social_app/social_states.dart';
import 'package:task_todo/models/social_app/post_model.dart';
import 'package:task_todo/shared/styles/icon_broken.dart';

class SocialHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,builder:(context,state){
        return ConditionalBuilder(
          condition:SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).model != null,
          builder: (context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children:[
                        Card(
                          elevation: 10,
                          clipBehavior:Clip.antiAlias ,
                          child: Image(
                            image: NetworkImage(
                                'https://image.freepik.com/free-photo/social-media-audience-person-filming-through-smartphone_53876-129002.jpg'
                            ),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height:150 ,
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10,bottom: 3),
                          child: Text('Communicate with your friends',
                            style:Theme.of(context).textTheme.subtitle1.copyWith(
                                color: Colors.white
                            ) ,),
                        ),
                      ]
                  ),
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>buildPost(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context,index)=>SizedBox(height: 5,),
                    itemCount: SocialCubit.get(context).posts.length)
              ],
            ),
          ),
          fallback: (context)=>Center(
            child: CircularProgressIndicator(),
          ),
        );
    } ,
    );
  }
  Widget buildPost(SocialPostModel modelpost,context,index)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Card(
      elevation: 10,
      clipBehavior:Clip.antiAlias ,
      child: Padding(
        padding: const EdgeInsets.all( 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      modelpost.image
                  ),
                  radius: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(modelpost.name.characters.toUpperCase().toString(),style: TextStyle(
                            height: 1.4,
                          ),),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.check_circle,color: Colors.blue,size: 16,)
                        ],
                      ),
                      Text('2 sep 2021 at 12 AM',style: Theme.of(context).textTheme.caption.copyWith(
                        height: 1.4,
                      ),),
                    ],
                  ),
                ),
                IconButton(icon: Icon(Icons.more_horiz), onPressed: (){

                })
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: .8),
              child: Container(
                child: Divider(
                  color: Colors.grey[300],
                  height: 1,
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text('${modelpost.post}',
              style:Theme.of(context).textTheme.caption ,),
            // Container(
            //   width: double.infinity,
            //   child: Wrap(
            //     children: [
            //       Container(
            //         height:25,
            //         child: MaterialButton(onPressed: (){},
            //           minWidth: 1,
            //           padding: EdgeInsets.zero,
            //           child: Text('#ECPC_problem_Solving',style:Theme.of(context).textTheme.caption.copyWith(
            //             color: Colors.blue,
            //
            //           )),
            //         ),
            //       ),
            //       Container(
            //         height:25,
            //         child: MaterialButton(onPressed: (){},
            //           minWidth: 1,
            //           padding: EdgeInsets.zero,
            //           child: Text('#ECPC_problem_Solving',style:Theme.of(context).textTheme.caption.copyWith(
            //             color: Colors.blue,
            //
            //           )),
            //         ),
            //       ),
            //       Container(
            //         height:25,
            //         child: MaterialButton(onPressed: (){},
            //           minWidth: 1,
            //           padding: EdgeInsets.zero,
            //           child: Text('#ECPC',style:Theme.of(context).textTheme.caption.copyWith(
            //             color: Colors.blue,
            //
            //           )),
            //         ),
            //       ),
            //       Container(
            //         height:25,
            //         child: MaterialButton(onPressed: (){},
            //           minWidth: 1,
            //           padding: EdgeInsets.zero,
            //           child: Text('#problem_Solving',style:Theme.of(context).textTheme.caption.copyWith(
            //             color: Colors.blue,
            //
            //           )),
            //         ),
            //       ),
            //
            //     ],
            //   ),
            // ),
            if(modelpost.postImage!='')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: .8),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        '${modelpost.postImage}'
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                height: 160,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(child: InkWell(

                    child: Row(
                      children: [
                        Icon(IconBroken.Heart,color: Colors.red,),
                        SizedBox(width : 5),
                        Text('${SocialCubit.get(context).likes[index]}',style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                    onTap: (){},
                  ),
                  ),
                  Expanded(child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(IconBroken.Chat,color: Colors.amber,),
                          SizedBox(width : 5),
                          Text('0 comment',style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                      onTap: (){}
                  ),
                  ),
                ],
              ),
            ),
            Container(
              child: Divider(
                color: Colors.grey[300],
                height: 1,
              ),
            ),
            //////////////////
            Row(
              children: [
                InkWell(

                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).model.image}'
                        ),
                        radius: 15,
                      ),
                      SizedBox(width : 5),
                      Text('write a comment ...',style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                  onTap: (){},
                ),
                Spacer(),
                Row(
                  children: [
                    IconButton(icon:Icon(IconBroken.Heart),
                      color: Colors.red,
                    onPressed: (){
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postIds[index]);
                    },),
                    Text('Like',style: Theme.of(context).textTheme.caption,),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),

    ),
  );
}
