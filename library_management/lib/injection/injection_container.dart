import 'package:get_it/get_it.dart';
import 'package:library_management/features/authentication/auth_dependency_injection.dart';
import 'package:library_management/helper/api_provider.dart';
import 'package:library_management/features/Book/book_dependency_injection.dart';
import 'package:library_management/features/Member/member_dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(
    () => APIProvider(sharedPreferences: sharedPreferences),
  );
  sl.registerLazySingleton(() => sharedPreferences);

  await registerAuth(sl);
  await registerBook(sl);
  await registerMember(sl);
}
