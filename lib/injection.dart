import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:todo_board/injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<GetIt> configureInjection(String env) async {
  return getIt.init(environment: env);
}

Future<void> setupPackageInfoService() async {
  getIt.registerSingleton<PackageInfo>(await PackageInfo.fromPlatform());
}
