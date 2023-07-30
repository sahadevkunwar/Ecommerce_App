import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_project/common/constants.dart';
import 'package:ecommerce_project/common/utils/shared_prefs.dart';
import 'package:ecommerce_project/features/auth/model/user.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  User? _user;
  User? get user => _user;

  String _token = "";
  String get token => _token;

  Future initialize() async {
    final appToken = await SharedPrefsUtils.getToken();
    final appUser = await SharedPrefsUtils.getUser();

    _token = appToken;
    _user = appUser;

    if (_user != null) {
      initializeFirebseCrashlytics(_user!);
    }
  }

  initializeFirebseCrashlytics(User user) {
    FirebaseCrashlytics.instance.setUserIdentifier(user.id);
    FirebaseCrashlytics.instance.setCustomKey("email", user.email);
    FirebaseCrashlytics.instance.setCustomKey("name", user.name);
    FirebaseCrashlytics.instance.setCustomKey("id", user.id);
  }

  Future logout() async {
    await SharedPrefsUtils.removeToken();
    await SharedPrefsUtils.removeUser();

    _token = "";
    _user = null;
  }

  Future<Either<String, void>> signUp({
    required String name,
    required String phone,
    required String address,
    required String email,
    required String password,
    File? profile,
  }) async {
    try {
      final Dio dio = Dio();
      final Map<String, dynamic> body = {
        "name": name,
        "phone": phone,
        "address": address,
        "email": email,
        "password": password,
      };
      if (profile != null) {
        body["profile"] = await MultipartFile.fromFile(profile.path);
      }
      final _ = dio.post("${Constants.baseUrl}/auth/register",
          data: FormData.fromMap(body));
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to signup");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> login(
      {required String email, required String password}) async {
    try {
      final Dio dio = Dio();
      final Map<String, dynamic> body = {"email": email, "password": password};
      final res = await dio.post("${Constants.baseUrl}/auth/login", data: body);
      final tempUser = User.fromMap(res.data["results"]);
      final String appToken = res.data["token"];
      _token = appToken;
      _user = tempUser;
      initializeFirebseCrashlytics(tempUser);
      await SharedPrefsUtils.saveToken(appToken);
      await SharedPrefsUtils.saveUser(tempUser);
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "unable to signup");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> facebookLogin() async {
    try {
      await FacebookAuth.instance.login();
      await FacebookAuth.instance.logOut();
      final result = await FacebookAuth.instance.login(permissions: []);

      if (result.status == LoginStatus.success) {
        final String facebookToken = result.accessToken!.token;
        final dio = Dio();
        final Map<String, dynamic> body = {
          "token": facebookToken,
        };
        final res = await dio.post(
            "${Constants.baseUrl}/auth/login/social/facebook",
            data: body);

        final tempUser = User.fromMap(res.data["results"]);
        final String appToken = res.data["token"];
        _token = appToken;
        _user = tempUser;
        initializeFirebseCrashlytics(tempUser);
        await SharedPrefsUtils.saveToken(appToken);
        await SharedPrefsUtils.saveUser(tempUser);
        return const Right(null);
      } else {
        return const Left("Unable to login with facebook");
      }
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "unable to signup");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> googleLogin() async {
    try {
      final googelSignin = GoogleSignIn();
      await googelSignin.signOut();
      final result = await googelSignin.signIn();
      if (result != null) {
        final googleToken = await result.authentication;
        final dio = Dio();
        final Map<String, dynamic> body = {
          "token": googleToken.accessToken,
        };
        final res = await dio
            .post("${Constants.baseUrl}/auth/login/social/google", data: body);

        final tempUser = User.fromMap(res.data["results"]);
        final String appToken = res.data["token"];
        _token = appToken;
        _user = tempUser;
        initializeFirebseCrashlytics(tempUser);
        await SharedPrefsUtils.saveToken(appToken);
        await SharedPrefsUtils.saveUser(tempUser);
        return const Right(null);
      } else {
        return const Left("Unable to login with google");
      }
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "unable to signup");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
