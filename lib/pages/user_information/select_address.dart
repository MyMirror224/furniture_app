import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
    final TextEditingController addAddressController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Address'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
              children: List.generate(
                  address.length, (i) => builderAddress(context, i))),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Size size = MediaQuery.of(context).size;
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('Add Address'),
                      content: Container(
                        height: size.height * 0.3,
                        width: size.width * 0.8,
                        margin: const EdgeInsets.only(top: 10),
                        child: TextField(
                          maxLines: null,
                          controller: addAddressController,
                          decoration: const InputDecoration(
                            hintText: "Edit your address",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            final snackBar = SnackBar(
                              /// need to set following properties for best effect of awesome_snackbar_content
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: '!!',
                                message: 'Your Action has been canceled!',

                                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                contentType: ContentType.failure,
                              ),
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);

                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            address.add(addAddressController.text);
                            final snackBar = SnackBar(
                              /// need to set following properties for best effect of awesome_snackbar_content
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Okey',
                                message:
                                    'Your address has been added successfully',

                                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                contentType: ContentType.success,
                              ),
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectAddress()));
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget builderAddress(BuildContext context, int i) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController editAddressController = TextEditingController();
    return Container(
        height: size.height * 0.3,
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        padding: const EdgeInsets.only(top: 15, bottom: 10, left: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            if (i == 0)
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(
                    top: 10, right: 10, left: 10, bottom: 10),
                child: const Text("This's default address",
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
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
                        onPressed: () {
                          editAddressController.text = address[i];
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Edit Address'),
                                    content: Container(
                                      height: size.height * 0.3,
                                      width: size.width * 0.8,
                                      margin: const EdgeInsets.only(top: 10),
                                      child: TextField(
                                        maxLines: null,
                                        controller: editAddressController,
                                        decoration: const InputDecoration(
                                          hintText: "Edit your address",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          final snackBar = SnackBar(
                                            /// need to set following properties for best effect of awesome_snackbar_content
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: '!!',
                                              message:
                                                  'Your Action has been canceled!',

                                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                              contentType: ContentType.failure,
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(snackBar);

                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          address[i] =
                                              editAddressController.text;
                                          final snackBar = SnackBar(
                                            /// need to set following properties for best effect of awesome_snackbar_content
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: 'OwO',
                                              message:
                                                  'Your address has been edited successfully',

                                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                              contentType: ContentType.success,
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(snackBar);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SelectAddress()));
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  ));
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      const Gap(10),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Set Default Address'),
                                    content: const Text(
                                        'Do you want to set this address as default?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          final snackBar = SnackBar(
                                            /// need to set following properties for best effect of awesome_snackbar_content
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: '!!',
                                              message:
                                                  'Your Action has been canceled!',

                                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                              contentType: ContentType.failure,
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(snackBar);

                                          Navigator.pop(context);
                                        },
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          selectDefaultAddress(i);
                                          final snackBar = SnackBar(
                                            /// need to set following properties for best effect of awesome_snackbar_content
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: 'OwO',
                                              message:
                                                  'Your address has been set as default successfully',

                                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                              contentType: ContentType.success,
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(snackBar);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SelectAddress()));
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ));
                        },
                        icon: const Icon(Icons.check),
                      ),
                      const Gap(10),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Delete Address'),
                                    content:
                                        const Text("Do you want to delete?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          final snackBar = SnackBar(
                                            /// need to set following properties for best effect of awesome_snackbar_content
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: '!!',
                                              message:
                                                  'Your Action has been canceled!',

                                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                              contentType: ContentType.failure,
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(snackBar);

                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteAddress(i);
                                          final snackBar = SnackBar(
                                            /// need to set following properties for best effect of awesome_snackbar_content
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: 'OwO',
                                              message:
                                                  'Your address has been deleted successfully!',

                                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                              contentType: ContentType.success,
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(snackBar);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SelectAddress()));
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ));
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
