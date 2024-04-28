import 'package:flutter/material.dart';

class DetailCategoryPage extends StatefulWidget {
  static const String routeName = '/detailCategory';

  @override
  _DetailCategoryPageState createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends State<DetailCategoryPage> {
  // final _detailCategoryBloc = DetailCategoryBloc(UnDetailCategoryState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailCategory'),
      ),
      body: Center(
        child: Text('DetailCategory'),
      ),
    );
  }
}
