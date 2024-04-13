import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:furniture_app/components/paymenttt.dart';
import 'package:furniture_app/pages/order_results_page.dart';


//import 'package:image/image.dart';

// ignore: camel_case_types
class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool showMomoInfo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          paymentttt(),
          Container(
            height: 800,
            padding: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xff193d3d),
                            shape: BoxShape.circle,
                          ),
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.shopping_cart,
                                size: 15,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn vào icon
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Cart",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff193d3d),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 3,
                          color: const Color(0xff193d3d),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff193d3d),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff193d3d),
                            shape: BoxShape.circle,
                          ),
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.location_on,
                                size: 15,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn vào icon
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff193d3d),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 3,
                          color: Color(0xff193d3d),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff193d3d),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff193d3d),
                            shape: BoxShape.circle,
                          ),
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.payment,
                                size: 15,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn vào icon
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Pay",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff193d3d),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total price",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "\$4999",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                //CartItemSampLess(),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quick payment",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xff193d3d).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(
                              'assets/images/paypal.png',
                              //color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xff193d3d).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(
                              'assets/images/vnpay.png',
                              //color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              //color: Colors.blue,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset(
                              'assets/images/momo.png',
                              //color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Other payment services",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          RoundedIconContainer(
                            icon: Icons.credit_card,
                            label: "Visa",
                          ),
                          SizedBox(width: 10),
                          RoundedIconContainer(
                            icon: Icons.phone_android,
                            label: "Samsung Pay",
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showMomoInfo = !showMomoInfo;
                              });
                            },
                            child: RoundedIconContainer(
                              icon: Icons.payment,
                              label: "Momo",
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OderRrsults(isSuccess: false),
                                ),
                              );
                            },
                            child: RoundedIconContainer(
                              icon: Icons.next_plan,
                              label: "Net back",
                            ),
                          ),
                          SizedBox(width: 10),
                          RoundedIconContainer(
                            icon: Icons.payments,
                            label: "Union pay",
                          ),
                        ],
                      ),
                      if (showMomoInfo)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Momo payment",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Enter Momo information",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "Momo ID",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Or",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Scan QR code",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.qr_code,
                                              size: 100,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(height: 10),
                                    // Container(
                                    //   width: double.infinity,
                                    //   child: ElevatedButton(
                                    //     onPressed: () {
                                    //       // Handle payment submission
                                    //     },
                                    //     child: Text("Submit"),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: ElevatedButton(
          onPressed: () {
            // Xử lý sự kiện khi nút "Continue" được nhấn
            print('Continue button pressed!');

            // Chuyển sang trang mới
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OderRrsults(isSuccess: true),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xff193d3d).withOpacity(0.5),
            elevation: 8.0,
          ),
          child: Text('pay now'),
        ),
      ),
    );
  }
}

class RoundedIconContainer extends StatelessWidget {
  final IconData icon;
  final String label;

  const RoundedIconContainer(
      {Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Icon(icon),
          SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
