import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

final List address = [
  " Số nhà: 1, Đường phố: Nguyễn Trãi,Phường: Thanh Xuân Trung,Quận: Thanh Xuân,Thành phố: Hà Nội,Mã bưu điện: 100000",
  "Số nhà: 2, Đường phố: Nguyễn Trãi,Phường: Thanh Xuân Trung,Quận: Thanh Xuân,Thành phố: Hà Nội,Mã bưu điện: 100000",
  "Số nhà: 3, Đường phố: Nguyễn Trãi,Phường: Thanh Xuân Trung,Quận: Thanh Xuân,Thành phố: Hà Nội,Mã bưu điện: 100000",
  "Số nhà: 4, Đường phố: Nguyễn Trãi,Phường: Thanh Xuân Trung,Quận: Thanh Xuân,Thành phố: Hà Nội,Mã bưu điện: 100000",
  "Số nhà: 5, Đường phố: Nguyễn Trãi,Phường: Thanh Xuân Trung,Quận: Thanh Xuân,Thành phố: Hà Nội,Mã bưu điện: 100000",
];

class SelectAddress extends StatelessWidget {
  const SelectAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Address'),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: List.generate(
                  address.length, (i) => BuilderAddress(context, i))),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget BuilderAddress(BuildContext context, int i) {
    Size size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(10),
        ),
        height: size.height * 0.3,
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 10,
        ),
        child: Column(
          children: [
            if (i == 0)
              const Text("This's default address",
                  style: TextStyle(fontSize: 20)),
            const Gap(10),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      address[i],
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      const Gap(10),
                      IconButton(
                        onPressed: () {
                          selectDefaultAddress(i);
                        },
                        icon: const Icon(Icons.check),
                      ),
                      const Gap(10),
                      IconButton(
                        onPressed: () {
                          deleteAddress(i);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void selectDefaultAddress(int i) {
    String a = address[i];
    address[i] = address[0];
    address[0] = a;
  }

  void deleteAddress(int i) {
    for (int j = i; j < address.length - 1; j++) {
      address[j] = address[j + 1];
    }
  }
}
