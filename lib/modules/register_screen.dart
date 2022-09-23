import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_system_app/modules/location_screen.dart';
import 'package:hotel_system_app/modules/report_screen.dart';
import 'package:hotel_system_app/shared/network/cache_helper.dart';
import 'package:hotel_system_app/layout/states.dart';


import '../layout/cubit.dart';
import '../shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List rooms;
  RegisterScreen(this.rooms);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                  ),
                  padding: const EdgeInsets.only(left: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          'Please register to continue',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextForm(
                          context: context,
                          keyboardType: TextInputType.emailAddress,
                          preIcon: Icons.email_outlined,
                          hint: 'Email',
                          controller: emailController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          context: context,
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          preIcon: Icons.lock_outline,
                          hint: 'Password',
                          controller: passwordController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        defaultButton(
                          text: 'register',
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                            CacheHelper.saveData(key: 'auth', value: true);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (contxet) => ReportScreen(rooms)),
                                (route) => false);
                          }else{}},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
