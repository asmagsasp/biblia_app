import 'package:flutter/material.dart';


Widget cards(val){
  return new Card(
    color: Colors.blueGrey,
    child:new Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: new RichText(
            text: new TextSpan(
              style: new TextStyle(
                fontSize: 35.0,
                color: Colors.white
              ),
              children: <TextSpan>[
                new TextSpan(text:'$val', style: new TextStyle(fontWeight: FontWeight.bold))
              ]
            ),


        ),
      ),

    ),);
}
