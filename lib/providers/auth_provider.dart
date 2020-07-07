import 'package:http/http.dart' as http;

class AuthAd{
  authenticateToken(){
    Future<http.Response> fetchToken() {
      return http.get('http://localhost:2069/api/Hello');
    }
  }
}