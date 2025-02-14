import 'dart:io';

import 'package:JoDija_DataSource/model/user/base_model/base_user_module.dart';
import 'package:JoDija_DataSource/model/user/base_model/inhertid_models/user_model.dart';
import 'package:JoDija_DataSource/source/user/accountLoginLogout/auth_email_source.dart';
import 'package:JoDija_DataSource/source/user/accountLoginLogout/http/auth_http_acc.dart';
import 'package:JoDija_DataSource/utilis/models/remote_base_model.dart';
import 'package:JoDija_DataSource/utilis/result/result.dart';
 import 'package:JoDija_view/util/data_souce_bloc/base_bloc.dart';
import 'package:JoDija_view/util/data_souce_bloc/remote_base_model.dart';
import 'package:JoDija_view/util/shardeprefrance/shard_check.dart';
import 'package:mashir_service/data/logic_injicts.dart';
import 'package:mashir_service/data/model/user.dart';
import 'package:mashir_service/data/repo/auth_repo.dart';
import 'package:mashir_service/data/repo/profile_repo.dart';

class AuthBloc {
  // single ton object
  static final AuthBloc _instance = AuthBloc._internal();
  AuthBloc._internal();
  factory AuthBloc() => _instance;
  String emailKey = "email";
  String nameKey = "name";
  String passKey = "pass";
  String phone = "phone";
  String rePass = "rePass";
  DataSourceBloc<UserData> userBloc = DataSourceBloc<UserData>();
UserData? user ;
String uid  = "";
  void signUp({required Map<String, dynamic> map}) async {
    LogicAuthRepo accountSource = AuthInjects.signUp(map: map);
    userBloc.loadingState();
    var user = UserData.fromJson(map);
    user.userType = "user";
    var result = await accountSource.createAccountAndProfile(user);
    result.pick(onData: (v) {
      SharedPrefranceChecking sharedPrefranceChecking =
          SharedPrefranceChecking();
      sharedPrefranceChecking.setDataInShardRefrace(
          email: v.email!, pass: map[passKey]!, token: v.token!);
      UserData user = UserData.fromJson(v.toJson());
   this.user = user ;
      userBloc.successState(user);
    }, onError: (error) {
      userBloc.failedState(ErrorStateModel(message: error.message), () {});
    });
  }

  void signIn({required Map<String, dynamic> map}) async {
    LogicAuthRepo accountSource = AuthInjects.signIn(map: map);
    userBloc.loadingState();
    var result = await accountSource.logIn();
    result.pick(onData: (v) {
      SharedPrefranceChecking sharedPrefranceChecking =
          SharedPrefranceChecking();
      sharedPrefranceChecking.setDataInShardRefrace(
          email: v.email!, pass: map[passKey]!, token: v.token!);
      UserData user = UserData.fromJson(v.toJson());
   this.user = user ;
      userBloc.successState(user);
    }, onError: (error) {
      userBloc.failedState(ErrorStateModel(message: error.message), () {});
    });
  }

  void signeInAsAdmin({required Map<String, dynamic> map}) async {
    LogicAuthRepo accountSource = AuthInjects.signIn(map: map);
    userBloc.loadingState();
    var result = await accountSource.logIn();
    result.pick(onData: (v) {
      SharedPrefranceChecking sharedPrefranceChecking =
          SharedPrefranceChecking();
      sharedPrefranceChecking.setDataInShardRefrace(
          email: v.email!, pass: map[passKey]!, token: v.token!);
      UserData user = UserData.fromJson(v.toJson());
    this.user = user ;
      userBloc.successState(user);
    }, onError: (error) {
      userBloc.failedState(ErrorStateModel(message: error.message), () {});
    });
  }

  Future<Result<RemoteBaseModel<dynamic>, UsersBaseModel>> signeInFromTimer(
      {required Map<String, dynamic> map}) async {
    LogicAuthRepo accountSource = AuthInjects.signIn(map: map);
    userBloc.loadingState();
    var result = await accountSource.logIn();
    return result;
  }

  void signInWithGoogle() async {
    LogicAuthRepo accountSource = AuthInjects.signUpGoogle();
    userBloc.loadingState();
    var result = await accountSource.logIn();
    result.pick(onData: (v) {
      SharedPrefranceChecking sharedPrefranceChecking =
          SharedPrefranceChecking();
      sharedPrefranceChecking.setDataInShardRefrace(
          email: v.email!, pass: "google", token: v.token!);
      UserData user = UserData.fromJson(v.toJson());
    this.user = user ;
      userBloc.successState(user);
    }, onError: (error) {
      userBloc.failedState(ErrorStateModel(message: error.message), () {});
    });
  }

  void signUpWithGoogle() async {
    LogicAuthRepo accountSource = AuthInjects.signUpGoogle();
    userBloc.loadingState();
    var result = await accountSource
        .createAccountAndProfile(UserData( isDataComplate:  false ));
    result.pick(onData: (v) {
      SharedPrefranceChecking sharedPrefranceChecking =
          SharedPrefranceChecking();
      sharedPrefranceChecking.setDataInShardRefrace(
          email: v.email!, pass: "google", token: v.token!);
      UserData user = UserData.fromJson(v.toJson());
   this.user = user ;
      userBloc.successState(user);
    }, onError: (error) {
      userBloc.failedState(ErrorStateModel(message: error.message), () {});
    });
  }

  void setProfileChange({required UserData map , Object? file  , String uid ="" }) async {
    ProfileRepo accountSource = ProfileInjects.editProfile();
    userBloc.loadingState();
    var result = await accountSource.editProfile(
        id: uid , data: map , file: file);
    result.pick(onData: (v) {
      UserData user = UserData.fromJson(v.toJson());
   this.user = user ;
   this.user!.uid = uid ;
      userBloc.successState(user);
    }, onError: (error) {
      userBloc.failedState(ErrorStateModel(message: error.message), () {});
    });
  }
}
