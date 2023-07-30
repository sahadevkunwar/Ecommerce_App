import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartUpCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  StartUpCubit({required this.userRepository}) : super(CommonInitialState());

  fetchStartUpData() async {
    emit(CommonLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    await userRepository.initialize();
    ({bool isLoggedIn}) startUpResult =
        (isLoggedIn: userRepository.token.isNotEmpty);
    emit(CommonSuccessState<({bool isLoggedIn})>(item: startUpResult));
  }
}
