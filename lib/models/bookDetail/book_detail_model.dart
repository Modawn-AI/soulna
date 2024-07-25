import 'dart:ui';

class BookDetailModel {
  String title;
  String? des;
  String? image;
  Color? textColor;
  Color? backgroundColor;
  BookDetailModel(
      {required this.title,
      this.des,
      this.image,
      this.textColor,
      this.backgroundColor});
}