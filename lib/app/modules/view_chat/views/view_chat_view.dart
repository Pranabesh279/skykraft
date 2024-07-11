import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/models/chat/message_data.dart';
import 'package:skycraft/app/modules/view_chat/widgets/chat_Input.dart';

import '../controllers/view_chat_controller.dart';

class ViewChatView extends GetView<ViewChatController> {
  const ViewChatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        key: controller.abcKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
              padding: const EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      controller.getOpponentData()?.photoUrl ?? '',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    controller.getOpponentData()?.name ?? '',
                    style: const TextStyle(
                      color: kTitleColor,
                      fontSize: 16,
                    ),
                  )
                ],
              )),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Builder(builder: (context) {
                return StreamBuilder<List<ChatMessage>>(
                  initialData: const [],
                  stream: controller.getMessagesStream(),
                  builder: (context, snapshot) => SafeArea(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: GroupedListView<ChatMessage, String>(
                        reverse: true,
                        elements: snapshot.data!,
                        groupBy: (element) {
                          // return today or yesterday or date
                          DateTime date = element.createdAt ?? DateTime.now();
                          if (date.day == DateTime.now().day) {
                            return 'Today';
                          } else if (date.day ==
                              DateTime.now()
                                  .subtract(
                                    const Duration(days: 1),
                                  )
                                  .day) {
                            return 'Yesterday';
                          } else {
                            return DateFormat('dd MM yyyy HH:mm').format(date);
                          }
                        },
                        groupSeparatorBuilder: (String groupByValue) =>
                            Container(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              groupByValue,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ),
                        itemBuilder: (context, element) {
                          ChatMessage message = element;
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Row(
                              mainAxisAlignment:
                                  message.author == controller.user.value?.uid
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                ChatBubble(
                                  clipper: ChatBubbleClipper5(
                                    type: message.author ==
                                            controller.user.value?.uid
                                        ? BubbleType.sendBubble
                                        : BubbleType.receiverBubble,
                                  ),
                                  alignment: message.author ==
                                          controller.user.value?.uid
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  backGroundColor: message.author ==
                                          controller.user.value?.uid
                                      ? kPrimary
                                      : kGreyColor,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    child: Text(
                                      message.message,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      // ListView.builder(
                      //   reverse: true,
                      //   itemCount: snapshot.data!.length,
                      //   itemBuilder: (context, index) {
                      //     ChatMessage message = snapshot.data![index];
                      //     return Container(
                      //       margin: const EdgeInsets.symmetric(
                      //           horizontal: 10, vertical: 0),
                      //       child: Row(
                      //         mainAxisAlignment:
                      //             message.author == controller.user.value?.uid
                      //                 ? MainAxisAlignment.end
                      //                 : MainAxisAlignment.start,
                      //         children: [
                      //           ChatBubble(
                      //             clipper: ChatBubbleClipper5(
                      //               type: message.author ==
                      //                       controller.user.value?.uid
                      //                   ? BubbleType.sendBubble
                      //                   : BubbleType.receiverBubble,
                      //             ),
                      //             alignment: message.author ==
                      //                     controller.user.value?.uid
                      //                 ? Alignment.topRight
                      //                 : Alignment.topLeft,
                      //             margin: const EdgeInsets.all(10),
                      //             backGroundColor: message.author ==
                      //                     controller.user.value?.uid
                      //                 ? kPrimary
                      //                 : kGreyColor,
                      //             child: Container(
                      //               constraints: BoxConstraints(
                      //                 maxWidth:
                      //                     MediaQuery.of(context).size.width *
                      //                         0.7,
                      //               ),
                      //               padding: const EdgeInsets.symmetric(
                      //                   horizontal: 10, vertical: 5),
                      //               child: Text(
                      //                 message.message,
                      //                 style: const TextStyle(
                      //                   color: Colors.white,
                      //                 ),
                      //               ),
                      //             ),
                      //           )
                      //           // Container(
                      //           //   padding: const EdgeInsets.all(10),
                      //           //   decoration: BoxDecoration(
                      //           //     color: message.author ==
                      //           //             controller.user.value?.uid
                      //           //         ? Colors.blue
                      //           //         : Colors.grey,
                      //           //     borderRadius: BorderRadius.circular(10),
                      //           //   ),
                      //           //   child: Text(
                      //           //     message.message,
                      //           //     style: const TextStyle(
                      //           //       color: Colors.white,
                      //           //     ),
                      //           //   ),
                      //           // ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                    ),
                  ),
                );
              }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ChatInput(
                onSendPressed: (message) {
                  controller.sendMessage(message);
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
