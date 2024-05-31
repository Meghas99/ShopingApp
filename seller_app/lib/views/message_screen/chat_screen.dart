import 'package:seller_app/const/const.dart';
import 'package:seller_app/views/message_screen/components/chat_bubbble.dart';
import 'package:seller_app/widgets/normal_text.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkGrey,
            )),
        title: boldText(text: chat, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return chatBubble();
              },
              itemCount: 20,
            )),
            10.heightBox,
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Enter message",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: purpleColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: purpleColor)),
                        ),
                      )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.send,
                            color: purpleColor,
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
