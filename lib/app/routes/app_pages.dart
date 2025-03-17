// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/project_create/bindings/project_create_binding.dart';
import '../modules/project_create/views/project_create_view.dart';
import '../modules/project_detail/bindings/project_detail_binding.dart';
import '../modules/project_detail/views/project_detail_view.dart';
import '../modules/projects/bindings/projects_binding.dart';
import '../modules/projects/views/projects_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/task_create/bindings/task_create_binding.dart';
import '../modules/task_create/views/task_create_view.dart';
import '../modules/task_detail/bindings/task_detail_binding.dart';
import '../modules/task_detail/views/task_detail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROJECTS,
      page: () => const ProjectsView(),
      binding: ProjectsBinding(),
    ),
    GetPage(
      name: _Paths.PROJECT_DETAIL,
      page: () => const ProjectDetailView(),
      binding: ProjectDetailBinding(),
    ),
    GetPage(
      name: _Paths.TASK_DETAIL,
      page: () => const TaskDetailView(),
      binding: TaskDetailBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_TASK,
      page: () => CreateTaskView(),
      binding: CreateTaskBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PROJECT,
      page: () => CreateProjectView(),
      binding: CreateProjectBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
