class AppValidator{

  static String? validate(String? value, String? fieldName)
  {
    if
    (value == null || value.isEmpty){
      return "$fieldName cannot be empty";
    }
      return null;
  }
}