import 'package:auto_route/annotations.dart';
import 'package:todo_board/presentation/app_language/app_language_page.dart';
import 'package:todo_board/presentation/auth/email_verification/email_verification_page.dart';
import 'package:todo_board/presentation/auth/forgot_password/forgot_password_page.dart';
import 'package:todo_board/presentation/auth/sign_in/sign_in_page.dart';
import 'package:todo_board/presentation/auth/splash/splash_page.dart';
import 'package:todo_board/presentation/completed_task_history/completed_task_history_page.dart';
import 'package:todo_board/presentation/home/home_page.dart';
import 'package:todo_board/presentation/new_task/new_task_page.dart';
import 'package:todo_board/presentation/task_timer_history/task_timer_history_page.dart';
import 'package:todo_board/presentation/user_profile/user_profile_page.dart';

@MaterialAutoRouter(
  preferRelativeImports: true,
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInPage),
    AutoRoute(page: EmailVerificationPage),
    AutoRoute(page: ForgotPasswordPage),
    AutoRoute(page: HomePage),
    AutoRoute(page: NewTaskPage),
    AutoRoute(page: TaskTimerHistoryPage),
    AutoRoute(page: CompletedTaskHistoryPage),
    AutoRoute(page: AppLanguagePage),
    AutoRoute(page: UserProfilePage),
  ],
)
class $AppRouter {}
