import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  SocialLoginCubit({required this.userRepository})
      : super(CommonInitialState());

  loginViaFacebook() async {
    emit(CommonLoadingState());
    final res = await userRepository.facebookLogin();
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState(item: null)),
    );
  }

  loginViaGoogle() async {
    emit(CommonLoadingState());
    final res = await userRepository.googleLogin();
    res.fold((error) => emit(CommonErrorState(message: error)),
        (data) => emit(CommonSuccessState(item: null)));
  }
}
