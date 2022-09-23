// ignore_for_file: prefer_const_constructors, duplicate_ignore
// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_system_app/shared/network/cache_helper.dart';

import '../../layout/cubit.dart';
import '../../layout/states.dart';
import '../../modules/room_details_screen.dart';
import '../../modules/welcome_screen.dart';

void signout(context)
{
  CacheHelper.removeData(key: 'auth').then((value)
  {
    if(value)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> WelcomeScreen()));
    }
  });
}

Widget myDivider()=> Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10.0),
  child:   Container(width: double.infinity,height: 2,),
);

Row buildTopBar(context,{
  required Function() onTap,
  required dynamic room,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(onPressed: (){
        Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
      SizedBox(width: 15,),
      Text(
        room['branch'],
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacer(),
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[900],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){signout(context);},
            child: Icon(
              Icons.logout,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
      ),
      SizedBox(width: 10,),
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[900],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: onTap,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget defaultButton({
  required String text,
  required Function()? onPressed,
}){
  return Container(
    height: 60.0,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}


Widget LocationButton({
  required BuildContext context,
  required String branchName,
  required Widget branch,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => branch));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              branchName,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


Widget roomBuilder({
  required room,
  required BuildContext context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image(
          height: 300.0,
          width: double.infinity,
          fit: BoxFit.cover,
          image: NetworkImage(
            room['image'],
          ),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Row(
        children: [
          Text(
            '${room['category']}: ',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            room['price'],
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(' EGP/Day',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

          Spacer(),
          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> RoomDetailsScreen(room) ));},
                child: Text('Book Now',
                  style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
          ),
        ],
      ),
      const SizedBox(
        height: 10.0,
      ),
      Container(
        width: double.infinity,
        height: 2,
        color: Colors.grey,
      ),
      SizedBox(
        height: 10.0,
      ),

    ],
  );
}


Widget  roomsBuilder({
  required rooms,
}){
  return ConditionalBuilder(
    condition: rooms.length>0,
    builder: (context)=> BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context,state){
          return ListView.separated(
            itemBuilder: (context,index)=>roomBuilder(room: rooms[index],context: context),
            separatorBuilder: (context,index)=> SizedBox(height: 5.0,),
            itemCount: rooms.length,
          );
        }),
    fallback: (context) => Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget defaultTextForm({
  required context,
  required TextInputType keyboardType,
  bool isPassword=false,
  required IconData preIcon,
  IconData? sufIcon,
  String? hint,
  String? label,
  required TextEditingController controller,
  required String? Function(String?)? validate,
  Function(String)? onSubmitted,
  Function(String)? onChanged,
  Function()? suffixOnPressed
}){
  return TextFormField(
    style: TextStyle(
      color: Colors.black,
    ),
    onFieldSubmitted: onSubmitted,
    onChanged: onChanged,
    validator: validate,
    controller: controller,
    cursorColor: Colors.black,
    keyboardType:keyboardType,
    obscureText: isPassword,
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      suffixIcon: IconButton(
        icon: Icon(sufIcon,color: Colors.grey),
        onPressed: suffixOnPressed,
      ),
      prefixIcon: Icon(preIcon, color: Colors.grey,),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey,),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent,),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      hintText: hint,
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
    ),
  );
}

