import '../../../../configurations/configurations.dart';

final appHomeRoutes = [
  AutoRoute(
    initial: true,
    path: 'home',
    page: HomeRoute.page,
  ),
  AutoRoute(
    path: 'chat',
    page: ChatRoute.page,
  ),
  AutoRoute(
    path: 'shop',
    page: ShopRoute.page,
  ),
];