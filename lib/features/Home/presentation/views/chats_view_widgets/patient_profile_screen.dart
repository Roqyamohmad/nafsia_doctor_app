import 'package:flutter/material.dart';

class PatientProfileScreen extends StatelessWidget {
  final String userId;

  const PatientProfileScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    // هنا المفروض تجيبي بيانات المريض من الـ API أو الكاش حسب الـ userId
    return Scaffold(
      appBar: AppBar(
        title: const Text("بيانات المريض"),
      ),
      body: Center(
        child: Text("عرض البيانات للمستخدم ID: $userId"),
      ),
    );
  }
}
