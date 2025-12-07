import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  final TextEditingController input = TextEditingController();
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final ScrollController scrollController = ScrollController();
  final Rx<File?> selectedImage = Rx<File?>(null);

  static const String _apiKey = "AIzaSyDQE8B6qCXnoMpRApQS2yc-fb-thDOLvoA";
  late final GenerativeModel _model;

  @override
  void onInit() {
    super.onInit();
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _apiKey,
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }

  void sendUserMessage() {
    if (input.text.isEmpty && selectedImage.value == null) return;

    final userMsg = input.text;
    final imageFile = selectedImage.value;

    messages.add({
      "role": "user",
      "text": userMsg,
      "imagePath": imageFile?.path
    });

    input.clear();
    selectedImage.value = null;
    _scrollToBottom();

    getAiReply(userMsg, imageFile);
  }

  Future<void> getAiReply(String userMsg, File? imageFile) async {
    isLoading.value = true;
    _scrollToBottom();

    final List<Part> parts = [];

    if (imageFile != null) {
      try {
        final imageBytes = await imageFile.readAsBytes();
        parts.add(DataPart(
          'image/jpeg',
          imageBytes,
        ));
      } catch (e) {
        print('Error reading image file: $e');
        messages.add({"role": "ai", "text": "Error: Could not read image file."});
        isLoading.value = false;
        return;
      }
    }

    if (userMsg.isNotEmpty) {
      parts.add(TextPart(userMsg));
    }

    final content = [Content('user', parts)];

    try {
      final response = await _model.generateContent(content);

      isLoading.value = false;
      _scrollToBottom();

      final aiReply = response.text ?? "No response";

      if (aiReply.isNotEmpty) {
        messages.add({"role": "ai", "text": aiReply});
      } else {
        messages.add({"role": "ai", "text": "Error: AI response was empty."});
      }

    } catch (e) {
      isLoading.value = false;
      print('Exception: $e');
      messages.add({"role": "ai", "text": "Error: API call failed. Check your API key and network."});
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}