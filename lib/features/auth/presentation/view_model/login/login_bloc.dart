import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_application/core/common/snackbar/my_snackbar.dart';
import 'package:food_delivery_application/features/auth/domain/use_case/login_usecase.dart';
import 'package:food_delivery_application/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:food_delivery_application/features/home/presentation/view/home_view.dart';
import 'package:food_delivery_application/features/home/presentation/view_model/home_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeBloc _homeBloc; // Replaced HomeCubit with HomeBloc
  final LoginUseCase _loginUseCase;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeBloc homeBloc, // Changed type to HomeBloc
    required LoginUseCase loginUseCase,
  })  : _registerBloc = registerBloc,
        _homeBloc = homeBloc,
        _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _registerBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<NavigateHomeScreenEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _homeBloc, // Replaced HomeCubit with HomeBloc
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<LoginCustomerEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final result = await _loginUseCase(
          LoginParams(
            email: event.email,
            password: event.password,
          ),
        );

        result.fold(
          (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
            showMySnackBar(
              context: event.context,
              message: "Invalid Credentials",
              color: Colors.red,
            );
          },
          (token) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            showMySnackBar(context: event.context, message: "Login Successful");

            add(
              NavigateHomeScreenEvent(
                context: event.context,
                destination: HomeView(),
              ),
            );
            //_homeBloc.add(SetTokenEvent(token)); // If HomeBloc needs token management
          },
        );
      },
    );
  }
}
