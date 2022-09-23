// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_system_app/shared/network/cache_helper.dart';
import 'package:hotel_system_app/layout/states.dart';

import '../layout/cubit.dart';

class ReportScreen extends StatelessWidget {
  List rooms;
  ReportScreen(this.rooms);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.arrow_back_ios),),
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Center(
              child: const Text(
                'Rooms report',
                style: TextStyle(color: Colors.black),
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Room ${rooms[index]['id']}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          rooms[index]['category'],
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          rooms[index]['booked'],
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (contxet, index)=> const SizedBox(
                  height: 10.0,
                ),
                itemCount: rooms.length,
            ),
          ),
        );
      },
    );
  }
}
