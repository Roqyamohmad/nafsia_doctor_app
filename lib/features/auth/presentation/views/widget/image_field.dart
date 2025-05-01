// ignore_for_file: unnecessary_import, use_super_parameters

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageFormField extends FormField<File?> {
  ImageFormField({
    super.key,
    required FormFieldSetter<File?> onSaved,
    required FormFieldValidator<File?> validator,
    File? initialValue,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          builder: (field) {
            final state = field as _ImageFormFieldState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: state._showImagePickerDialog,
                  child: Stack(
                    children: [
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: field.hasError ? Colors.red : Colors.grey),
                        ),
                        child: state.fileImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  state.fileImage!,
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                              ),
                      ),
                      if (state.fileImage != null)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            onPressed: () {
                              state._removeImage();
                            },
                            icon: const Icon(Icons.close, color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
                if (field.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      field.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        );

  @override
  FormFieldState<File?> createState() => _ImageFormFieldState();
}

class _ImageFormFieldState extends FormFieldState<File?> {
  bool isLoading = false;
  File? fileImage;

  @override
  void initState() {
    super.initState();
    fileImage = widget.initialValue;
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() => isLoading = true);
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        fileImage = File(image.path);
        didChange(fileImage);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
    setState(() => isLoading = false);
  }

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('التقط صورة بالكاميرا'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('اختر من المعرض'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  void _removeImage() {
    setState(() {
      fileImage = null;
      didChange(null);
    });
  }
}
