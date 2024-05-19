

import 'package:flutter/material.dart';
import 'package:furniture_app/components/evaluateee.dart';


//import 'package:furniture_app/widgets/cartbottomnarbar.dart';
//import 'package:image/image.dart';

// class EvaluatePage extends StatelessWidget {
//   const EvaluatePage({super.key});
class EvaluatePage extends StatefulWidget {
  @override
  _ProductQualityState createState() => _ProductQualityState();
}

class _ProductQualityState extends State<EvaluatePage> {
  bool star1Selected = false;
  bool star2Selected = false;
  bool star3Selected = false;
  bool star4Selected = false;
  bool star5Selected = false;

  void selectStar(int starNumber) {
    setState(() {
      star1Selected = starNumber >= 1;
      star2Selected = starNumber >= 2;
      star3Selected = starNumber >= 3;
      star4Selected = starNumber >= 4;
      star5Selected = starNumber >= 5;
    });
  }

  late TextEditingController _textEditingController;
  List<String> _suggestedPhrases = [
    'Sản phẩm rất đẹp',
    'Sản phẩm rất chất lượng',
    'Giao hàng nhanh',
    'Shop uy tín',
  ];
  List<String> _selectedPhrases = [];

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSuggestedPhraseSelected(String phrase) {
    if (!_selectedPhrases.contains(phrase)) {
      setState(() {
        _selectedPhrases.add(phrase);
        _textEditingController.text += phrase + ', ';
      });
    }
  }

  void _onTextChanged(String text) {
    setState(() {
      _selectedPhrases.removeWhere(
          (phrase) => !_textEditingController.text.contains(phrase));
    });
  }
  // code chọn ảnh, chụp ảnh :<
  // List<String> selectedImages = [];
  // String selectedVideo = '';
  // bool isImagePickerActive = false;
  // bool isVideoPickerActive = false;

  // Future<void> pickImageFromGallery() async {
  //   if (isImagePickerActive || isVideoPickerActive) {
  //     return;
  //   }

  //   setState(() {
  //     isImagePickerActive = true;
  //   });

  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     isImagePickerActive = false;
  //   });

  //   if (pickedImage != null) {
  //     setState(() {
  //       selectedImages.add(pickedImage.path);
  //     });
  //   } else {
  //     showErrorMessage('Không thể chọn ảnh từ thư viện');
  //   }
  // }

  // bool isErrorShown = false;

  // Future<void> captureVideo() async {
  //   if (isImagePickerActive || isVideoPickerActive) {
  //     return;
  //   }

  //   if (isErrorShown) {
  //     isErrorShown = false;
  //   }

  //   setState(() {
  //     isVideoPickerActive = true;
  //   });

  //   final picker = ImagePicker();
  //   try {
  //     final capturedVideo = await picker.pickVideo(source: ImageSource.camera);

  //     setState(() {
  //       isVideoPickerActive = false;
  //     });

  //     if (capturedVideo != null) {
  //       setState(() {
  //         selectedVideo = capturedVideo.path;
  //       });
  //     } else {
  //       showErrorMessage('Không thể chụp video');
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isVideoPickerActive = false;
  //       isErrorShown = true;
  //     });
  //     showErrorMessage('Lỗi: Không có camera khả dụng');
  //   }
  // }
  // showErrorMessage(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Error'),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           child: Text('Close'),
  //           onPressed: () => Navigator.of(context).pop(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const evaluate(),
              Container(
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Image.asset(
                        'assets/images/1.png',
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Relaxing bench and table',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        RichText(
                          text: TextSpan(
                            text: 'color green, length 1m3',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 10.0,
                            ),
                            children: const [
                              TextSpan(
                                text: ' - sale 40%',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                padding: const EdgeInsets.only(
                    top: 10, right: 5, left: 5, bottom: 15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Product Quality',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                selectStar(1);
                              },
                              child: Icon(
                                Icons.star,
                                size: 20,
                                color:
                                    star1Selected ? Colors.green : Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectStar(2);
                              },
                              child: Icon(
                                Icons.star,
                                size: 20,
                                color:
                                    star2Selected ? Colors.green : Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectStar(3);
                              },
                              child: Icon(
                                Icons.star,
                                size: 20,
                                color:
                                    star3Selected ? Colors.green : Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectStar(4);
                              },
                              child: Icon(
                                Icons.star,
                                size: 20,
                                color:
                                    star4Selected ? Colors.green : Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectStar(5);
                              },
                              child: Icon(
                                Icons.star,
                                size: 20,
                                color:
                                    star5Selected ? Colors.green : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //giao diện chọn ảnh từ thư viện
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              //   padding: const EdgeInsets.only(
              //       top: 10, right: 5, left: 5, bottom: 15),
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Colors.grey.withOpacity(0.3),
              //         width: 1.0,
              //       ),
              //     ),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text(
              //         'Media Selection',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 12.0,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       const SizedBox(height: 10),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           GestureDetector(
              //             onTap: pickImageFromGallery,
              //             child: Container(
              //               width: 100,
              //               height: 100,
              //               color: Colors.grey,
              //               child: Icon(
              //                 Icons.photo_camera,
              //                 size: 50,
              //                 color: Colors.white,
              //               ),
              //             ),
              //           ),
              //           GestureDetector(
              //             onTap: captureVideo,
              //             child: Container(
              //               width: 100,
              //               height: 100,
              //               color: Colors.grey,
              //               child: Icon(
              //                 Icons.videocam,
              //                 size: 50,
              //                 color: Colors.white,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 10),
              //       const Text(
              //         'Chỉ có thể chọn 5 ảnh hoặc 1 video',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 12.0,
              //         ),
              //       ),
              //       const SizedBox(height: 10),
              //       Text('Selected Images: ${selectedImages.length}'),
              //       for (var imagePath in selectedImages)
              //         Image.file(File(imagePath)),
              //       Text(
              //           'Selected Video: ${selectedVideo.isNotEmpty ? 'Yes' : 'No'}'),
              //     ],
              //   ),
              // ),
              Container(
                padding:  const EdgeInsets.only(left: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _textEditingController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onChanged: _onTextChanged,
                      decoration: const InputDecoration(
                        hintText: 'Nhập đánh giá của bạn...',
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 0,
                      children: _suggestedPhrases.map((phrase) {
                        final isSelected = _selectedPhrases.contains(phrase);
                        return GestureDetector(
                          onTap: () => _onSuggestedPhraseSelected(phrase),
                          child: Chip(
                            label: Text(phrase,
                            style: const TextStyle(fontSize: 10.0),),
                            backgroundColor: isSelected ? const Color(0xff193d3d).withOpacity(0.5) : null,
                            
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
