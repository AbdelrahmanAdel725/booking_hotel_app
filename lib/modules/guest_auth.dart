// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_system_app/layout/states.dart';


import '../layout/cubit.dart';
import '../shared/components/components.dart';
import 'location_screen.dart';

class GuestScreen extends StatefulWidget {
  final room;
  GuestScreen(this.room);


  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (contxet, state) {},
      builder: (contxet, state) {
        var nameController = TextEditingController();
        var numController = TextEditingController();
        var mailController = TextEditingController();
        var formKey = GlobalKey<FormState>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            title: Text(
              'Complete your details',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40.0,
                      ),
                      defaultTextForm(
                        hint: 'Name',
                        context: context,
                        keyboardType: TextInputType.name,
                        preIcon: Icons.person,
                        controller: nameController,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Please enter your name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultTextForm(
                        hint: 'Phone number',
                        context: context,
                        keyboardType: TextInputType.number,
                        preIcon: Icons.phone,
                        controller: numController,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Please enter your phone number';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultTextForm(
                        hint: 'Email',
                        context: context,
                        keyboardType: TextInputType.emailAddress,
                        preIcon: Icons.email,
                        controller: mailController,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Please enter your email';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      defaultButton(
                          text: 'Book Now',
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                        AppCubit.get(context).UpdatePrice(price: double.parse(widget.room['price']) - (double.parse(widget.room['price'] ) * 95/100),id: widget.room['id'] );
                        if (widget.room['booked'] == "Available") {
                          AppCubit.get(context).UpdateData(
                            name: nameController.text,
                            phone: numController.text,
                            email: mailController.text,
                            id: widget.room['id'],
                          );
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LocationScreen()));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                  'Room is already Booked',
                                ),
                              );
                            },
                          );
                        }}else{}}),
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text('${widget.room['price']} EGP/Day',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          ),),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
