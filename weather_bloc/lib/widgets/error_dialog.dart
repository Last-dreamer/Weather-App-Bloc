

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog(BuildContext context,String errorMessage){
  if(Platform.isIOS){
  showCupertinoDialog(
    context: context,
   barrierDismissible: false, 
    builder: (_) {
      return  CupertinoAlertDialog(
         title: const Text("Error"), 
         content: Text(errorMessage),
         actions:  [
             CupertinoButton(child:const Text('OK'), onPressed: ()=> Navigator.pop(context)),
            ]);
         });
  }else{
    showDialog(
     context: context,
     barrierDismissible: false,
     builder: (_) {
       return AlertDialog(
         title: const Text("Error"), 
         content: Text(errorMessage),
         actions:  [
               TextButton(onPressed: () => Navigator.pop(context),
                child: const Text("OK"))
                ]);
         });
  }
}