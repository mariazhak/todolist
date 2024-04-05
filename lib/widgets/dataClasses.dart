import 'package:flutter/material.dart';

class Category{
  String title;
  Color color;
  Category({required this.color, this.title = 'Unknown'});
}

class Task {
  String name;
  String? description;
  Category category;
  bool isDone = false;

  Task({required this.name, required this.category, this.description});
}