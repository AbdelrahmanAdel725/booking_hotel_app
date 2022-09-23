import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_system_app/modules/register_screen.dart';
import 'package:hotel_system_app/modules/report_screen.dart';
import 'package:hotel_system_app/shared/network/cache_helper.dart';
import 'package:hotel_system_app/layout/states.dart';


import '../layout/cubit.dart';
import '../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  List rooms;
  HomeScreen(this.rooms);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  buildTopBar(context,onTap: () {
                    if (CacheHelper.getData(key: 'auth')!=null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReportScreen(rooms)),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen(rooms)),
                      );
                    }
                  }, room: rooms[2]),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(child: roomsBuilder(rooms: rooms)),
                ],
              ),
            ),
          ));
        });
  }
}
