import 'package:todo_as_issue/api/opensource_platform.dart';

class API {
  OpenSourcePlatform _openSourcePlatform;

  API(this._openSourcePlatform);

  set openSourcePlatform(OpenSourcePlatform openSourcePlatform) {
    _openSourcePlatform = openSourcePlatform;
  }
}
