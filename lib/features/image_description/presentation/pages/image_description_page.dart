import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/vision_api_service.dart';

class ImageDescriptionPage extends StatefulWidget {
  const ImageDescriptionPage({super.key});

  @override
  State<ImageDescriptionPage> createState() => _ImageDescriptionPageState();
}

class _ImageDescriptionPageState extends State<ImageDescriptionPage> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  String? _description;
  String? _error;
  bool _isLoading = false;

  VisionApiService get _visionService =>
      VisionApiService(apiKey: const String.fromEnvironment('OPENAI_API_KEY'));

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked = await _imagePicker.pickImage(source: source);
    if (picked == null) return;

    setState(() {
      _selectedImage = File(picked.path);
      _description = null;
      _error = null;
    });
  }

  Future<void> _generateDescription() async {
    final File? image = _selectedImage;
    if (image == null) {
      setState(() => _error = 'Please capture or select an image first.');
      return;
    }

    if (const String.fromEnvironment('OPENAI_API_KEY').isEmpty) {
      setState(() {
        _error =
            'Missing OPENAI_API_KEY. Run with --dart-define=OPENAI_API_KEY=your_key';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _description = null;
      _error = null;
    });

    try {
      final String result = await _visionService.describeImage(image);
      setState(() => _description = result);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Description with LLM'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade200,
                ),
                child: _selectedImage == null
                    ? const Center(
                        child: Text('No image selected'),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(_selectedImage!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Camera'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _isLoading ? null : _generateDescription,
              icon: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.auto_awesome),
              label: Text(_isLoading ? 'Generating...' : 'Generate Description'),
            ),
            const SizedBox(height: 12),
            if (_description != null)
              Text(
                _description!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
