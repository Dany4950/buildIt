
import 'package:buildittt/utils/appTheme.dart';
import 'package:buildittt/widgets/elevatedButton.dart';
import 'package:buildittt/widgets/homeAppBar.dart';
import 'package:buildittt/widgets/landingPageText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Landingpage extends StatelessWidget {
  const Landingpage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeight*0.12,
          ),

          //app logo container 
          Center(
            child: Container(
                height: screenHeight*0.15,
                child: Image.asset(
                  'assets/images/appLogo.png',
                  fit: BoxFit.fill,
                )),
          ),

          //second photo in landing page
SizedBox(
            height: screenHeight*0.03,
          ),

Center(
            child: Container(
                height: screenHeight*0.2,
                child: Image.asset(
                  'assets/images/loadingPagePhoto.png',
                  fit: BoxFit.fill,
                )),
          ),
SizedBox(
  height:  screenHeight*0.03,
),
          //home page text white
          TextContainer(text:"Discover Endless possibilites with  " , height: screenHeight*0.09,),

          //Home page text yellow
          TextContainer(
            height: screenHeight*0.05,
            text: "Bar Code Scanner",  textStyle: TextStyle(color: Apptheme.buttonColorYellow , fontSize: 25 , fontWeight: FontWeight.bold),),
          
          //small text 
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: const Text("      Where creativity meets Innovation : Embark on a journey ")),


Text("of Limitless exploration with barcode scanner "),


//elevated button email singup 
          
          elevatedButtonYellow(
            
            text: "Continue with Email ")
        ],
      ),
    );
  }
}
