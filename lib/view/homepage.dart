import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getx_jsonplaceholder/controller/api_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? cityId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ApiController>();
    return Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => controller.isLoading.value
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // ElevatedButton(
                      //     onPressed: () => Get.to(() => const Test2()),
                      //     child: const Text("load")),
                      StatefulBuilder(
                        builder: (context, setState) => Container(
                            height: 62,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: DropdownButtonHideUnderline(
                              child: GFDropdown(
                                  padding: const EdgeInsets.all(15),
                                  borderRadius: BorderRadius.circular(10),
                                  border: const BorderSide(
                                      color: Colors.black12, width: 1),
                                  // dropdownButtonColor: c.onError,
                                  hint: Row(children: [
                                    const Icon(
                                      Icons.folder_special_outlined,
                                      color: Colors.cyan,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 1,
                                      height: 100,
                                      child: Divider(
                                        thickness: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text("Speciality")
                                  ]),
                                  onChanged: (changedValue) {
                                    setState(() {
                                      cityId = changedValue.toString();
                                      debugPrint(cityId);
                                    });
                                  },
                                  value: cityId,
                                  items: controller.specialityList[0].data!
                                      .map((value) {
                                    return DropdownMenuItem(
                                      value: value.id,
                                      child: Text(value.name.toString()),
                                    );
                                  }).toList()),
                            )),
                      ),
                      Text(
                          "Data Status = ${controller.specialityList[0].status.toString()}"),
                      Center(
                          child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.specialityList[0].data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(controller
                                  .specialityList[0].data![index].name
                                  .toString()),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        },
                      )),
                    ],
                  ),
                ),
        ));
  }
}
