import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_app/const/const.dart';
//import 'package:d_mart_seller/services/store_services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/views/message_screen/chat_screen.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/normal_text.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

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
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),

      body: StreamBuilder(
          stream: StoreServices.getMessage(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(data.length, (index) {
                        var t = data[index]['created_on'] == null
                            ? DateTime.now()
                            : data[index]['created_on'].toDate();
                        var time = intl.DateFormat("h:nma").format(t);

                        return ListTile(
                          onTap: () {
                            Get.to(() => const ChatScreen());
                          },
                          leading: const CircleAvatar(
                              backgroundColor: purpleColor,
                              child: Icon(
                                Icons.person,
                                color: white,
                              )),
                          title: boldText(
                              text: "${data[index]['sender_name']}",
                              color: fontGrey),
                          subtitle: normalText(
                              text: "${data[index]['last_msg']}",
                              color: darkGrey),
                          trailing: normalText(text: time, color: darkGrey),
                        );
                      }),
                    )),
              );
            }
          }),
      // body: Padding(
      //   padding: const EdgeInsets.all(8),
      //   child: SingleChildScrollView(
      //       child: Column(
      //           children: List.generate(
      //               20,
      //               (index) => ListTile(
      //                     onTap: () {
      //                       Get.to(() => const ChatScreen());
      //                     },
      //                     leading: const CircleAvatar(
      //                       backgroundColor: purpleColor,
      //                       child: Icon(Icons.person),
      //                     ),
      //                     title: boldText(text: "Username", color: fontGrey),
      //                     subtitle: boldText(
      //                         text: "last message....", color: fontGrey),
      //                   )))),
    );
  }
}
