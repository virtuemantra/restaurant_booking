import 'package:flutter/material.dart';

import '../values/dimen.dart';

Widget InputForm(String fieldName,String image,String textHint,TextEditingController textEditController){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
    child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldName,style: TextStyle(fontSize: fontSizeMedium,fontWeight: FontWeight.w600),),
        Row(
          children: [
            Image.asset(image,width: 18,),
            const SizedBox(width: 20,),
            Expanded(
              child: TextField(
                controller: textEditController,
                decoration: InputDecoration(
                  // filled: true,
                  // fillColor: Colors.white,
                  // // focusColor: Colors.white,
                  hintText: textHint,
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 2,
          decoration: const BoxDecoration(
              color: Colors.grey
          ),
        )
      ],
    ),
  );
}