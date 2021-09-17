class Vendedores {
  String name;
  String email;
  String city;

  Vendedores({this.name, this.email, this.city});

  Vendedores.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    city = json['city'];
  }
}
