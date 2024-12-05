import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_app/authpages/signup.dart';
import 'package:gymkhana_app/constants/colours.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Forgetpass extends StatefulWidget{
  @override
  State<Forgetpass> createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = "";
  Future<void>passrecovery()async{
    await _auth.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Password reset link send"),
      backgroundColor: Colors.blueAccent,
      duration: Duration(seconds: 2),
    ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:CupertinoColors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            //padding:EdgeInsets.only(top: 50,left: 120,right: 120),
            alignment: Alignment.bottomCenter,
            height: 100,
            // color: CustomColors.primaryColor,
            child: Text("Password Recovery",style: TextStyle(color:Colors.black,fontSize: 30),),
          ),
          Container(
            height: 100,
            alignment: Alignment.center,
            //  color: Colors.blueAccent,
            child: Text("Enter your Registered mail",style: TextStyle(color:Colors.black,fontSize: 25),),
          ),
          Container(
            margin:EdgeInsets.only(top: 70),
            padding: EdgeInsets.only(left: 10,right: 10),
            height: 150,
            //  color: Colors.green,
            child: Center(
              child: Form(
                //  key: _formkey,
                child: TextFormField(
                  //   controller: mailcontroller,
                  style:(TextStyle(color: TextColors.PrimaryTextColor,fontSize: 18)),
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return "please enter the Email";
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {
                      email=value;
                    });
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded,color: TextColors.SecondaryTextColor,size: 30,),
                      hintText:"Email",
                      hintStyle: TextStyle(fontSize: 20,color: TextColors.SecondaryTextColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:TextColors.SecondaryTextColor,
                            width: 1.5
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:TextColors.PrimaryTextColor,
                            width: 1.5
                        ),
                        borderRadius: BorderRadius.circular(15),
                      )

                  ),
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 30,left: 10,right: 10),
              height: 50,
              width: 380,
              child:ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor:Colors.blueAccent),
                onPressed: (){
                  passrecovery();
                  // if(_formkey.currentState!.validate()){
                  //   setState(() {
                  //    email=mailcontroller.text;
                  //  });
                  //   resetpass();
                  //  }
                },
                child: Text('Send mail',style: TextStyle(color: Colors.white,fontSize: 30),),
              )
          ),
          Container(
              margin: EdgeInsets.only(top: 30),
              alignment: Alignment.topCenter,
              height: 100,
              //color: Colors.blueAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ? ",style: TextStyle(color: TextColors.SecondaryTextColor,fontSize: 18),),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                      },child: Text("SignUP",style: TextStyle(color: Colors.blueAccent,fontSize: 20),))
                ],
              )
          )
        ],
      ),
    );
  }
}