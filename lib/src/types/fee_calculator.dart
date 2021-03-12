class FeeCalculator {
  FeeCalculator({this.lamportsPerSignature});

  final int lamportsPerSignature;

  factory FeeCalculator.fromJson(Map<String, dynamic> json) {
    return FeeCalculator(
      lamportsPerSignature: json['lamportsPerSignature'],
    );
  }
}
