import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utilities.dart';
//import 'package:expense_manager/login/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack_36/fireauth.dart';
import 'package:hack_36/home.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _firestore = FirebaseFirestore.instance;

String _email;
String _password;
String _name;
String _username;
String _location;
String _phone;
AlertDialog alertDialog = AlertDialog(
  title: Text("Welcome"),
  content: Text("Verification link has been sent to your email"),
);

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  fireauth _fire = fireauth();
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget buildSignUp() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Sign Up',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            textStyle: TextStyle(
              color: Colors.black54,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_box,
                color: Colors.pink[300],
              ),
              hintText: 'Enter Full Name',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (String input1) => _name = input1,
          ),
        ),
      ],
    );
  }

  Widget buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_box,
                color: Colors.pink[300],
              ),
              hintText: 'Enter Username',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (String input2) => _username = input2,
          ),
        ),
      ],
    );
  }

  Widget buildPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.pink[300],
              ),
              hintText: 'Enter your Phone No.',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (String input6) => _phone = input6,
          ),
        ),
      ],
    );
  }

  Widget buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.pink[300],
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (String input3) => _email = input3,
          ),
        ),
      ],
    );
  }

  Widget buildLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Location',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            //obscureText:true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.location_city,
                color: Colors.pink[300],
              ),
              hintText: 'Enter where you live',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (String input5) => _location = input5,
          ),
        ),
      ],
    );
  }

  Widget buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.pink[300],
              ),
              hintText: 'Enter a Strong Password',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (String input4) => _password = input4,
          ),
        ),
      ],
    );
  }

  Widget buildSignUpBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 200,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: signUp,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.pink[300], //Color(0xff99ffff),
        child: Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffccffff),
                      Color(0xffd5ffee),
                      Color(0xffccffff),
                      Color(0xffcffdff),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      buildSignUp(),
                      SizedBox(
                        height: 30.0,
                      ),
                      buildName(),
                      SizedBox(
                        height: 10.0,
                      ),
                      buildEmailTF(),
                      SizedBox(
                        height: 10.0,
                      ),
                      buildPasswordTF(),
                      SizedBox(
                        height: 10.0,
                      ),
                     //buildUsername(),
                      SizedBox(
                        height: 10.0,
                      ),
                      //buildLocation(),
                      SizedBox(
                        height: 10.0,
                      ),
                      //buildPhone(),
                      SizedBox(
                        height: 10,
                      ),
                      buildSignUpBtn(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    //This function Signs the user up with firebase and handles any errors
    if (_name != null ){//&& _username != null) {
      //The try block is called only if name and username are filled
      try {
        _firestore.collection('people').add({
          'email': _email,
          'location': _location,
          'phone': _phone,
        });
        // AuthResult

        UserCredential user = await _fire.Create(_email, _password);
        await user.user.updateProfile(
          displayName: _name,
        );
        await user.user.updateEmail(_email);
        _fire.Reload();
        User curr = auth.currentUser; //await _fire.Current();

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyHomePage(title: "hey", curr:curr),),);//HomeScreen(curr: curr)));
      } catch (e) {
        //Handles any errors in the email and password and prints them as toasts
        String s = e.message;
        if (e.message == null) {
          s = "Fill in the required fields."; //Is printed instead of "null" if any of the fields are left blank
        }
        Fluttertoast.showToast(
            msg: s,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        /*setState(() {
          loader=Colors.white;
        });*/
      }
    } else {
      //Comes to else if The name or username is empty
      Fluttertoast.showToast(
        //Prints error toast
          msg: "Display name can not be empty.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }
}
