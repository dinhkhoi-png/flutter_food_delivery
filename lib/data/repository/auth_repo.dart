
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/signup_body_model.dart';
import '../api/api_client.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({ required this.apiClient, required this.sharedPreferences});
  registration(SignUpBody signUpBody){
    // apiClient.postData(uri, body)
  }
}