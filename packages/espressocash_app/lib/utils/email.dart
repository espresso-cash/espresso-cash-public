extension IsValidEmail on String {
  bool get isValidEmail => RegExp(r'^.+@.+\..+$').hasMatch(this);
}
