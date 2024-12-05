//import 'package:authentication/screens/authenticate/emailvalidator.dart';
import 'package:gymkhana_app/authpages/forgetpass.dart';
import 'package:gymkhana_app/authpages/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_app/constants/colours.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:authentication/screens/authenticate/emailvalidator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:gymkhana_app/authpages/forgetpass.dart';
import 'package:gymkhana_app/home.dart';
//import 'package:authentication/constants/signup.dart';
class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  var _isobsecured= true;
  Future<void> login()async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      if(user!.emailVerified){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) {
          return home();
        }));
      }
      else if(!user!.emailVerified){
        await user.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:Text("Email verification link sent"),
            backgroundColor: Colors.blueAccent,
            duration: Duration(seconds: 2),
          ),
        );
        await user.reload();
      }
    }
    on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.message}'),
          backgroundColor: Colors.blueAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CupertinoColors.white,
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
                child: Image.asset('assets/images/IITI.png'),
              ),
              Container(
                margin: EdgeInsets.only(top: 80,left: 25,right: 25),
                // color: Colors.blueAccent,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter an valid Email';
                    }
                    // else if(EmailValidator.validate(email)==false){
                    //   return 'Enter an valid Email';
                    // }
                    else{
                      return null;
                    }
                  },
                  onChanged:(value){
                    setState(() {
                      email = value;
                    });
                  },
                  style: TextStyle(color: TextColors.PrimaryTextColor,fontSize: 18),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail,size: 25,),
                    hintText: "Email @iiti.ac.in",
                    hintStyle: TextStyle(color: TextColors.SecondaryTextColor,fontSize: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                          color: TextColors.SecondaryTextColor,
                          width: 1.5
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
                  validator: (value){
                    if(value==null||value.length<6){
                      return "Enter passsword of atleast 6 characters";
                    }
                    else{
                      return null;
                    }
                  },
                  onChanged: (value){
                    setState(() {
                      password = value;
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
                              width: 1.5
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
                margin: EdgeInsets.only(top: 15,right: 25),
                alignment: Alignment.centerRight,
                //color:Colors.blueAccent,
                height: 20,
                child: InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) {return Forgetpass();}));
                    },
                    child: Text('Forget password ?',style: TextStyle(color: TextColors.SecondaryTextColor),)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 50,left: 20,right: 20),
                  height: 50,
                  width: 380,
                  child:ElevatedButton(
                    style:ElevatedButton.styleFrom(backgroundColor:Colors.blueAccent),
                    onPressed: ()async{
                      if(_formKey.currentState!.validate()){
                        login();
                      }
                    },
                    child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.w400),),
                  )
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                // color: Colors.green,
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",style: TextStyle(color: TextColors.SecondaryTextColor),),
                    InkWell(
                      onTap: (){
                        Navigator.push(context ,MaterialPageRoute(builder: (context) {return SignupPage();}));
                      },
                      child: Text("SignUp",style: TextStyle(color:Colors.blueAccent),),
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