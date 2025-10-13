bool isStringSimilar(String input, String output){

  print(input);
  print(output);
  if(output =='All'){
    return true ;
  }

  String formattedInputString = input.toLowerCase().replaceAll(' ', '') ;
  String formattedOutputString = output.toLowerCase().replaceAll(' ', '') ;
  if(formattedInputString == formattedOutputString){
    return true;
  }
  else {
    return false;
  }
}