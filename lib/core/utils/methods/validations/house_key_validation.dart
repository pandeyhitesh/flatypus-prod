bool isValidHouseKey(String? houseKey) {
  if(houseKey ==null) return false;
  // Check if the input is null or empty
  if (houseKey.isEmpty) return false;

  // Define the regex pattern for the house key
  // FLTP- followed by 3 alphanumeric chars, hyphen, 4 alphanumeric chars
  final RegExp houseKeyPattern = RegExp(r'^FLTP-[A-Z0-9]{3}-[A-Z0-9]{4}$');

  // Check if the string matches the pattern
  return houseKeyPattern.hasMatch(houseKey.toUpperCase());
}

bool isValidInput(String? value){
  if(value==null) return false;
  if(value.isEmpty) return false;
  return true;
}