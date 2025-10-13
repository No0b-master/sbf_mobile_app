
import 'package:sbf_mobile_app/webservices.dart';



String getPath({required String path}){
  if(path.contains('drive')){
    String fileId = path.substring(path.indexOf('id')+3);
    String newLink = 'https://drive.google.com/uc?export=view&id=$fileId';
    return newLink;
  }
  else{
    return Webservices.viewDocument+path ;
  }
}