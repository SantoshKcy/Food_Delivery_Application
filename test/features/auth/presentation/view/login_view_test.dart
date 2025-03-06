import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_application/features/auth/presentation/view/login_view.dart';
import 'package:food_delivery_application/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  late MockLoginBloc loginBloc;

  setUp(() {
    loginBloc = MockLoginBloc();
  });
  Widget loadLoginView() {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: MaterialApp(home: LoginView()),
    );
  }

  // Widget createTestWidget() {
  //   return BlocProvider<LoginBloc>(
  //     create: (context) => loginBloc,
  //     child: MaterialApp(home: LoginView()),
  //   );
  // }

  testWidgets('Check if Login button is present', (WidgetTester tester) async {
    await tester.pumpWidget(loadLoginView());

    final loginButton = find.widgetWithText(ElevatedButton, 'Login');

    expect(loginButton, findsOneWidget);
  });

  testWidgets('Validate empty email and password fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(loadLoginView());

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    expect(find.text('Please enter email'), findsOneWidget);
    expect(find.text('Please enter password'), findsOneWidget);
  });

  testWidgets('Login success', (tester) async {
    when(() => loginBloc.state)
        .thenReturn(LoginState(isLoading: true, isSuccess: true));

    await tester.pumpWidget(loadLoginView());

    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'santosh@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), 'santosh123');

    await tester.tap(find.byType(ElevatedButton).first);

    await tester.pumpAndSettle();

    expect(loginBloc.state.isSuccess, true);
  });
}
