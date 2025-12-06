import 'dart:io';
import 'package:axonia/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find<ChatController>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffA180F5),
      appBar: AppBar(
        backgroundColor: Color(0xffA180F5),
        elevation: 1,
        title: Text(
          "Jihad\'s AI",
          style: GoogleFonts.fredoka(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.w700,
          ),
        ),
        toolbarHeight: 40,
        centerTitle: true,
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 30,left: 40,bottom: 4),
            onPressed: () {
              Get.toNamed(Routes.ABOUT_SECESSION);
            },
            icon: const Icon(Icons.info_outline, color: Colors.white,size: 30,),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Obx(() => Column(
                  children: [
                    SizedBox(height: 2),

                    Expanded(
                      child: ListView.builder(
                        controller: controller.scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) {
                          final msg = controller.messages[index];
                          final isUser = msg["role"] == "user";
                          final String? imagePath = msg["imagePath"];

                          return Align(
                            alignment:
                            isUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(14),
                              constraints: const BoxConstraints(maxWidth: 260),
                              decoration: BoxDecoration(
                                color: isUser ? Colors.blue : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(16),
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  if (imagePath != null)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          File(imagePath),
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                  Text(
                                    msg["text"] ?? "",
                                    style: TextStyle(
                                      color: isUser ? Colors.white : Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 2),

                    if (controller.isLoading.value)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: TypingIndicator(),
                      ),

                    SizedBox(height: 2),
                  ],
                )),
              ),
            ),
          ),


          Obx(() {
            if (controller.selectedImage.value == null) {
              return const SizedBox.shrink();
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      controller.selectedImage.value!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "Image selected. Send with message.",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  IconButton(
                    onPressed: controller.clearImage,
                    icon: const Icon(Icons.close_outlined, color: Color(0xffA180F5)),
                  ),
                ],
              ),
            );
          }),

          Container(
            padding: const EdgeInsets.only(left: 13, right: 13, bottom: 25,top: 10),
            decoration: const BoxDecoration(color: Color(0xffA180F5), boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))
            ]),
            child: Row(
              children: [

                GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.image, color: Colors.white, size: 20),
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    controller: controller.input,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                      controller.sendUserMessage();
                    },
                  ),
                ),

                const SizedBox(width: 10),

                GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                    controller.sendUserMessage();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat();

    animation1 = Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.3)),
    );
    animation2 = Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.6)),
    );
    animation3 = Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _dot(animation1),
        const SizedBox(width: 6),
        _dot(animation2),
        const SizedBox(width: 6),
        _dot(animation3),
      ],
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        return Opacity(
          opacity: animation.value,
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xffA180F5),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}