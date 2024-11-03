import 'package:bookit/core/helper/hive/hive_keys.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../features/saved/model/hive_saved_model.dart';

class HiveHelper {
  static late Box box;

  static init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(HiveSavedModelAdapter());
    if (Hive.isBoxOpen(HiveKeys.boxName)) {
      box = Hive.box(HiveKeys.boxName);
    } else {
      box = await Hive.openBox(HiveKeys.boxName);
    }
  }
}
