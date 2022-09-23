// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hotel_system_app/modules/guest_auth.dart';
import 'package:hotel_system_app/modules/home_screen.dart';
import 'package:hotel_system_app/modules/location_screen.dart';

class RoomDetailsScreen extends StatelessWidget {
  final room;
  RoomDetailsScreen(this.room);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(child: Text('Room Details',style: TextStyle(color: Colors.black),)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image(
              image: NetworkImage(
                room['image'],
              ),
            ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [

                Text(
                  room['branch'],
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  room['category'],
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 2,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Total price',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text('${room['price']} EGP / Day',
                      style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: Container(
                          height: 80,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> GuestScreen(room)));
                            },
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
