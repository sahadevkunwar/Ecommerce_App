import 'package:bloc/bloc.dart';
import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';

class LoginCubit extends Cubit<CommonState> {
  final UserRepository userRepository;

  LoginCubit({required this.userRepository}) : super(CommonInitialState());

  login({required String email, required String password}) async {
    emit(CommonLoadingState());
    final res = await userRepository.login(email: email, password: password);
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState(item: null)),
    );
  }
}
