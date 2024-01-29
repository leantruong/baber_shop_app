import 'package:flutter/material.dart';

class RouteModel {
  RouteModel({required this.path, required this.pageBuilder});
  String path;
  Widget pageBuilder;
}
