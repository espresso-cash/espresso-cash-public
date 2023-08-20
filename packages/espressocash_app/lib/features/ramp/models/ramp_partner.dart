enum RampPartner {
  kado(title: 'Kado Money', minimumAmount: r'$3'),
  rampNetwork(title: 'Ramp Network', minimumAmount: r'$7'),
  coinflow(title: 'Coinflow', minimumAmount: r'$20'),
  guardarian(title: 'Guardarian', minimumAmount: r'$5');

  const RampPartner({required this.title, required this.minimumAmount});

  final String title;
  final String minimumAmount;
}
