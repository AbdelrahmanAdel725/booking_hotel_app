import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_system_app/layout/states.dart';
import 'package:hotel_system_app/modules/home_screen.dart';

import '../layout/cubit.dart';
import '../shared/components/components.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (contxet, state) {},
        builder: (context, state) {
          var cairoBranch = AppCubit.get(context).cairoBranch;
          var alexBranch = AppCubit.get(context).alexBranch;
          var dahabBranch = AppCubit.get(context).dahabBranch;
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: Center(
                child: const Text(
                  'Our Branches',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LocationButton(
                    context: context, 
                    branchName: 'Cairo', 
                    branch: HomeScreen(cairoBranch),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  LocationButton(
                    context: context, 
                    branchName: 'Alexandria', 
                    branch: HomeScreen(alexBranch),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  LocationButton(
                    context: context, 
                    branchName: 'Dahab',
                    branch: HomeScreen(dahabBranch),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
