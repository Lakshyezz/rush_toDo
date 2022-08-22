import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rush/constants/keysTask.dart';

class StorageService extends GetxService {
  late GetStorage _box; //variable which ll contains data from user

  //asyncronously we ll wait and check if key already present
  //  if yeh provide task key if not just empty value
  Future<StorageService> init() async {
    _box = GetStorage();
    await _box.write(taskKey, []);
    // await _box.writeIfNull(taskKey, []);

    return this;
  }

  //this will recieveandRead data from local storage from above
  //T is the generic data type depends upon the upper class
  //if string type wll put String

  T read<T>(String key) {
    return _box.read(key);
  }

//it ll not return anything just asynchronously write it according to key value pair
  void write(String key, dynamic value) async {
    await _box.write(key, value);
  }
}
