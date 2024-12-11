extension IsValidPhone on String {
  bool get isValidPhone => RegExp(r'^\+[0-9]{1,4}[0-9]{6,14}$').hasMatch(this);
}
