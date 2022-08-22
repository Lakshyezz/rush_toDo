import 'package:get/get.dart';
import 'package:rush/detail/widgets/controller.dart';
import 'package:rush/provider/task/provider.dart';

import '../../dataTask/services/storage/repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
