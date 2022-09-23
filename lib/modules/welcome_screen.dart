// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_system_app/layout/states.dart';
import 'package:hotel_system_app/modules/location_screen.dart';
import 'package:hotel_system_app/modules/register_screen.dart';
import 'package:hotel_system_app/shared/network/cache_helper.dart';
import '../layout/cubit.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (contxet, state) {
        var rooms = AppCubit.get(context).dahabBranch;
        return Scaffold(
          body: Stack(
            children: [
              const SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image(
                  image: NetworkImage(
                      'https://media.cntraveler.com/photos/53e303f7c2d3f39d3610f7a0/16:9/w_2560%2Cc_limit/ritz-carlton-aruba-aruba-200504-4.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black.withOpacity(0.4),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 150.0,
                    ),
                    Text(
                      'Enjoy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Your',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Dream vacation.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        height: 60.0,
                        width: 230.0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          color: Colors.white,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (rooms.isEmpty) {
                              AppCubit.get(context).insertToDatabase();
                            }
                            CacheHelper.saveData(key: 'welcome', value: true);

                            // Navigator.pushAndRemoveUntil(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => LocationScreen()),
                            //     (route) => false);
                            if(CacheHelper.getData(key: 'auth')==null){Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen(rooms)));
                            }else
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> LocationScreen()));
                            }
                          },
                          child: const Text(
                            'Book Now',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    /* const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.registerScreen);
                      },
                      child: const Text(
                        'SGIN UP',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                    ),
                  ],
                ), */
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
