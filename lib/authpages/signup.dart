
//import 'package:authentication/screens/authenticate/emailVerification.dart';
import 'package:gymkhana_app/home.dart';
import 'package:gymkhana_app/authpages//login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_app/constants/colours.dart';

class SignupPage extends StatefulWidget{
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email ="";
  String domain = "iiti.ac.in";
  String password = "";
  var _isobsecured = true;

  Future<void> signUp() async {
    try {
      UserCredential Credential = await _auth.createUserWithEmailAndPassword(
        email:email,
        password:password,
      );
      User? user = Credential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification(); // Send email verification
        // Show a Scaffold message when the email verification link is sent
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email verification link sent'),
            backgroundColor: Colors.blueAccent,
            duration: Duration(seconds: 2),
          ),
        );
        await user.reload();
      }
    } on FirebaseAuthException catch (e) {
      //print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign up failed: ${e.message}'),
          backgroundColor: Colors.blueAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:CupertinoColors.white,
        resizeToAvoidBottomInset: false,
        body:Form(
          key: _formKey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.,
            children: [
              Container(
                margin: EdgeInsets.only(top: 130),
                alignment: Alignment.center,
                // color: Colors.red,
                height: 220,
                child: Image.asset('assets/images/IITI.png',fit:BoxFit.fill),
              ),
              Container(
                margin: EdgeInsets.only(top: 80,left: 25,right: 25),
                // color: Colors.blueAccent,
                child: TextFormField(
                  //controller: _emailController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter an valid email";
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {
                      email=value;
                    });
                  },
                  style: TextStyle(color: TextColors.PrimaryTextColor,fontSize: 18),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail,size: 25,),
                    hintText: "Email  @iiti.ac.in",
                    hintStyle: TextStyle(color: TextColors.SecondaryTextColor,fontSize: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: TextColors.SecondaryTextColor,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: TextColors.PrimaryTextColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30,left: 25,right: 25),
                // color: Colors.blueAccent,
                child: TextFormField(
                  //  controller: _passwordController,
                  validator: (value){
                    if(value!.length < 6){
                      return "Enter a password atleast 6 characters";
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {
                      password=value;
                    });
                  },
                  obscureText: _isobsecured,
                  style: (TextStyle(color: TextColors.PrimaryTextColor,fontSize: 18)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock,size: 25,),
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              _isobsecured=!_isobsecured;
                            });
                          },
                          icon:_isobsecured ? Icon(Icons.visibility_off):Icon(Icons.visibility)
                      ),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: TextColors.SecondaryTextColor,fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: TextColors.SecondaryTextColor,
                            width: 1.5,
                          )

                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: TextColors.PrimaryTextColor,
                            width: 1.5,
                          )
                      )
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 100,left: 20,right: 20),
                  height: 50,
                  width: 380,
                  child:ElevatedButton(
                    style:ElevatedButton.styleFrom(backgroundColor:Colors.blueAccent),
                    onPressed: ()async{
                      if(_formKey.currentState!.validate()){
                        if(!email.endsWith(domain)){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:Text("Enter a valid Email",style: TextStyle(color: Colors.white,fontSize: 20)),
                            backgroundColor: Colors.blueAccent,
                            duration: Duration(seconds: 2),
                          ),
                          );
                        }
                        else{
                          signUp();
                        }

                      }
                    },
                    child: Text('Signup',style: TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.w400),),
                  )
              ),
              Container(
                margin: EdgeInsets.only(top: 80),
                // color: Colors.green,
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",style: TextStyle(color: TextColors.SecondaryTextColor),),
                    InkWell(
                      onTap: (){
                        Navigator.push(context ,MaterialPageRoute(builder: (context) {return LoginPage();}));
                      },
                      child: Text("LogIn",style: TextStyle(color: Colors.blueAccent),),
                    )

                  ],
                ),

              )

            ],
          ),
        )
    );
  }
}