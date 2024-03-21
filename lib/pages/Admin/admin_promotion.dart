import 'package:flutter/material.dart';
import 'package:furniture_app/components/information_user_field.dart';
import 'package:furniture_app/pages/Admin/backend/backend_promotion.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class PromotionScreen extends ConsumerWidget {
  const PromotionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promoProvi = ref.watch(promotionProvider);
    final appThemeState = ref.watch(appThemeStateNotifier);
    var size = MediaQuery.of(context).size;
    return ScaffoldMessenger(
      key: promoProvi.ScaffoldKey,
      child: Scaffold(
        body: SafeArea(
          // vừa khung hình
          child: SingleChildScrollView(
            // cuộn màn hình
            //reverse: true, hiển thị các phần tử từ dưới lên
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                .onDrag, // khi cuộn màn hình thì bàn phím tự động ẩn đi
            child: Form(
              key: promoProvi.formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                      child: SizedBox(
                        child: TextFormField(
                          controller: promoProvi.nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter name promotion';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            promoProvi.name = (value!);
                          },
                          // nhập số từ bàn phím
                          decoration: promoProvi.textFormDecoration.copyWith(
                            labelText: 'name promotion',
                            hintText: 'enter name promotion',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                      child: SizedBox(
                        child: TextFormField(
                          controller: promoProvi.quantityController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Discount';
                            } else if (!value.isValidQuantity()) {
                              return 'Please enter valid Discount (1 - 90%)';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            promoProvi.quantity = int.parse(value!);
                          },
                          keyboardType: TextInputType.number,
                          decoration: promoProvi.textFormDecoration.copyWith(
                            labelText: 'Discount',
                            hintText: 'Add Discount ',
                          ),
                        ),
                      ),
                    ),
                    const InformationFields(type: "name", text: 'Start Date'),
                    Container(
                      decoration: BoxDecoration(
                        color: appThemeState.isDarkModeEnabled
                            ? const Color(0xff93b1a7)
                            : const Color(0xff93b1a7),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                DateFormat("dd/MM/yyyy")
                                    .format(promoProvi.birthDay),
                                style: const TextStyle(
                                  color: Colors.white54,
                                )),
                          ),
                          IconButton(
                            // nhóoooooo cái này
                            onPressed: () => ref
                                .read(promotionProvider.notifier)
                                .ShowDatePicker(context),
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const InformationFields(type: "name", text: 'End Date'),
                    Container(
                      decoration: BoxDecoration(
                        color: appThemeState.isDarkModeEnabled
                            ? const Color(0xff93b1a7)
                            : const Color(0xff93b1a7),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                DateFormat("dd/MM/yyyy")
                                    .format(promoProvi.birthDay),
                                style: const TextStyle(
                                  color: Colors.white54,
                                )),
                          ),
                          IconButton(
                            // nhóoooooo cái này
                            onPressed: () => ref
                                .read(promotionProvider.notifier)
                                .ShowDatePicker(context),
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              promoProvi.upLoadData();
                            },
                            child: const Text('Upload'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              promoProvi.cleanInfor();
                            },
                            child: const Text('Clean'),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9]\d{0,3}$').hasMatch(this);
  }
}
