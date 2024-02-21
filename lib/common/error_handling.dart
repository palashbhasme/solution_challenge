import 'dart:convert';
import 'utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response response,
  required BuildContext buildContext,
  required VoidCallback onSuccess}){
  switch(response.statusCode){
    case 200: onSuccess();
    break;
    case 400: showSnackbar(buildContext, jsonDecode(response.body)['msg']);
    break;
    case 500: showSnackbar(buildContext, jsonDecode(response.body)['error']);
    break;
    default:showSnackbar(buildContext, (response.body));


  }

}