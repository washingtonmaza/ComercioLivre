import 'package:http/http.dart' as http;

class Api {
  static Future getUsers() async {
       return await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  }
}
