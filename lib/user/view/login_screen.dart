import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:wagle_front/common/layout/default_layout.dart';
import 'package:wagle_front/user/repository/user_repository.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            const Text(
              "놀면서 살자",
              style: TextStyle(
                fontSize: 48,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SocialLoginButton(
              buttonType: SocialLoginButtonType.google,
              onPressed: () async {
                await ref.read(userRepositoryProvider).userLogin();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SocialLoginButton(
              buttonType: SocialLoginButtonType.apple,
              onPressed: () {
                context.push('/home');
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SocialLoginButton(
              buttonType: SocialLoginButtonType.facebook,
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            SocialLoginButton(
              buttonType: SocialLoginButtonType.twitter,
              onPressed: () {},
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
