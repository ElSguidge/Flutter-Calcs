class Calcs {
  final String? name;
  final String? subtitle;
  final String? route;

  // CommissioningCalculators(this.name, this.subtitle, this.route, bool favorite);
  Calcs({this.name, this.subtitle, this.route});

  Calcs.fromJson(Map<String, dynamic> data)
      : name = data['name'],
        subtitle = data['subtitle'],
        route = data['route'];
}
