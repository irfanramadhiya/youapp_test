import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/profile.dart';

abstract class ProfileEvent {}

class GetProfile extends ProfileEvent {
  final String xAccessToken;
  GetProfile(this.xAccessToken);
}

class UpdateProfile extends ProfileEvent {
  final Profile newProfile;
  UpdateProfile(this.newProfile);
}

String xAccessToken = "";

class ProfileBloc extends Bloc<ProfileEvent, Profile> {
  ProfileBloc() : super(Profile(username: '')) {
    on<GetProfile>((event, emit) async {
      try {
        var response = await Dio().get(
            'https://techtest.youapp.ai/api/getProfile',
            options: Options(headers: {'x-access-token': event.xAccessToken}));

        print("response success");
        xAccessToken = event.xAccessToken;

        try {
          emit(Profile.fromJson(response.data['data']));
        } catch (e) {
          print("abcd${e.toString()}");
        }
      } on DioException catch (e) {
        print("response failed: ${e.response}");
      }
    });

    on<UpdateProfile>(
      (event, emit) async {
        try {
          var response = await Dio().put(
              'https://techtest.youapp.ai/api/updateProfile',
              options: Options(headers: {'x-access-token': xAccessToken}),
              data: {
                "name": event.newProfile.name,
                "birthday": event.newProfile.birthday,
                "height": event.newProfile.height,
                "weight": event.newProfile.weight,
                "interests": event.newProfile.interests
              });

          emit(event.newProfile);
          print("response success");
        } on DioException catch (e) {
          print("response failed: ${e.response}");
        }
      },
    );
  }
}
