// NewsCommentsPage cods

// -->  BEFORE PAGINATION CODE
// body: Container(
//     width: getSize(context),
//     height: MediaQuery.of(context).size.height,
//     child: Column(
//       children: [
//         Expanded(
//           child: StreamBuilder(
//             stream: MessagesFirestoreService.getStream(
//                 widget.item.newsID.toString(), false),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Icon(
//                     FontAwesomeIcons.exclamation,
//                     size: 30,
//                     color: Colors.red,
//                   ),
//                 );
//               } else if (snapshot.hasData) {
//                 final QuerySnapshot querySnapshot = snapshot.data;
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   padding: EdgeInsets.only(top: 20),
//                   itemCount: querySnapshot.size,
//                   itemBuilder: (context, index) {
//                     final item = MessageEntity.fromMap(
//                         querySnapshot.docs[index].data());
//                     return MessageItem(
//                         item, querySnapshot.docs[index].reference.id);
//                   },
//                 );
//               }
//               return SizedBox();
//             },
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             if (!loginControl()) {
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   CupertinoPageRoute(
//                     builder: (context) => LoginPage(),
//                   ),
//                   (route) => false);
//             }
//           },
//           child: Container(
//             color: Colors.white,
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).padding.bottom + 8,
//               top: 8,
//               right: 8,
//               left: 8,
//             ),
//             child: Container(
//               width: getSize(context),
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(100)),
//               child: Row(
//                 children: [
//                   Expanded(
//                       child: TextField(
//                     enabled: loginControl(),
//                     focusNode: _focusNode,
//                     controller: _messageController,
//                     maxLines: 1,
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: loginControl()
//                             ? 'Yorumla'
//                             : 'Yorumlamak için giriş yapmalısınız'),
//                   )),
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           getImage();
//                         },
//                         icon: Icon(
//                           imagePath == null ? Icons.image : Icons.check,
//                           color: loginControl()
//                               ? AppColors.secondaryColor
//                               : Colors.grey.shade300,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () => sendMessage(),
//                         icon: Icon(
//                           Icons.send,
//                           color: loginControl()
//                               ? AppColors.secondaryColor
//                               : Colors.grey.shade300,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     )),

//
// Future<void> getCommentCount() async {
//   try {
//     MessagesFirestoreService.getStream(widget.item.newsID.toString())
//         .forEach((element) {
//       commentCount = element.size;
//       setState(() {});
//     });
//   } catch (e) {}
// }

// class _MessageItemState extends State<MessageItem> {
//   String displayNameUser = " ";

//   @override
//   void initState() {
//     super.initState();
//     getUser(widget.item.userUid);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       child: Container(
//         margin: EdgeInsets.only(
//           bottom: 20,
//           left: 20,
//           right: 20,
//         ),
//         padding: EdgeInsets.symmetric(
//           vertical: 10,
//           horizontal: 10,
//         ),
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: Colors.grey.shade400, width: 1)),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               radius: 25,
//               backgroundColor: RandomColor().randomColor(),
//               child: Text('${displayNameUser[0].toUpperCase()}'),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 12.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             // "$displayNameUser",
//                             "${widget.item.documentId}",
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             softWrap: true,
//                             style: GoogleFonts.openSans(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       widget.item.message,
//                       maxLines: 5,
//                       overflow: TextOverflow.ellipsis,
//                       softWrap: true,
//                       style: GoogleFonts.openSans(
//                           color: Colors.black, fontWeight: FontWeight.w300),
//                     ),
//                     widget.item.messageImageUrl != null
//                         ? Align(
//                             alignment: Alignment.centerRight,
//                             child: Image.network(
//                               widget.item.messageImageUrl,
//                               height: 100,
//                               fit: BoxFit.fitHeight,
//                             ),
//                           )
//                         : SizedBox(),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: Text(
//                           '${DateFormat.yMMMMd('tr_TR').format(widget.item.messageDate)}, ${DateFormat.Hm().format(widget.item.messageDate)}',
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           softWrap: true,
//                           style: GoogleFonts.openSans(
//                               color: Colors.grey.shade500,
//                               fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> getUser(String uid) async {
//     try {
//       UserFirestoreService.getUserStream(uid).forEach((element) {
//         displayNameUser = UserEntity.fromMap(element.docs[0].data()).name;
//         setState(() {});
//       });
//     } catch (e) {
//       debugPrint('!!! getUser catch: ' + e);
//     }
//   }
// }

/*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GalleryPhotoViewWrapper(
                                      galleryItems: [widget.item.messageImageUrl],
                                      backgroundDecoration:
                                      const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      initialIndex: 0,
                                      scrollDirection: verticalGallery
                                          ? Axis.vertical
                                          : Axis.horizontal,
                                    ),
                              ),
                            );*/

// 21AGUST21
//    PAGINATION CODE
              // haveCommentData
              //     ? Expanded(
              //         child: fetchLoadingData
              //             ? Center(
              //                 child: CircularProgressIndicator(
              //                   backgroundColor: AppColors.secondaryColor,
              //                 ),
              //               )
              //             : ListView.builder(
              //                 reverse: true,
              //                 shrinkWrap: true,
              //                 controller: scrollController,
              //                 padding: EdgeInsets.only(top: 20),
              //                 itemCount: messageList.length,
              //                 itemBuilder: (context, index) {
              //                   final data = messageList[index].data();
              //                   final item = CommentEntity.fromMap(data);
              //                   if (FirebaseAuth.instance.currentUser.uid
              //                           .compareTo(item.userUid) ==
              //                       0) {
              //                     item.key = 1;
              //                   } else {
              //                     item.key = 2;
              //                   }
              //                   return SwipeTo(
              //                     onLeftSwipe: () {
              //                       if (!_focusNode.hasFocus) {
              //                         hasSwipeReply = true;
              //                         replyFromParentCommentItem = item;
              //                         _focusNode.requestFocus();
              //                       } else {
              //                         hasSwipeReply = false;
              //                         replyFromParentCommentItem = null;
              //                         _focusNode.unfocus();
              //                       }
              //                     },
              //                     child: MessageItem(item),
              //                   );
              //                 },
              //               ))
              //     : Expanded(
              //         child: Center(
              //           child: Text('yorum yok...'),
              //         ),
              //       ),

  //             Future<void> fetchData() async {
  //   try {
  //     Query query = firestoreInstance
  //         .collection('comments') // CHANGE FROM COLLECTION NAME -> MESSAGES
  //         .where('newsId', isEqualTo: widget.item.newsID.toString())
  //         .orderBy('messageDate', descending: true)
  //         .limit(fetchingDataPerPage);
  //     fetchLoadingData = true;
  //     QuerySnapshot snapshots = await query.get();
  //     messageList = snapshots.docs;
  //     lastDocument = messageList.last;
  //     // debugPrint(snapshots.docs[snapshots.docs.length - 1].data()['message']);
  //     fetchLoadingData = false;
  //   } on Exception catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Future<void> fetchMoreData() async {
  //   try {
  //     if (!fetchLoadingMoreDataIsAvaliable) {
  //       debugPrint('ALERT: no more item');
  //     }

  //     if (fetchLoadingMoreData) {
  //       return;
  //     }

  //     Query query = firestoreInstance
  //         .collection('comments') // CHANGE FROM COLLECTION NAME -> MESSAGES
  //         .where('newsId', isEqualTo: widget.item.newsID.toString())
  //         .orderBy('messageDate', descending: true)
  //         .startAfter([lastDocument.data()['messageDate']]).limit(
  //             fetchingDataPerPage);
  //     fetchLoadingMoreData = true;
  //     QuerySnapshot snapshots = await query.get();
  //     messageList.addAll(snapshots.docs);
  //     if (snapshots.docs.length < fetchingDataPerPage) {
  //       fetchLoadingMoreDataIsAvaliable = false;
  //     }
  //     lastDocument = snapshots.docs[snapshots.docs.length - 1];
  //     fetchLoadingMoreData = false;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Future<bool> hasData() async {
  //   try {
  //     var snapshot = await firestoreInstance
  //         .collection('comments') // CHANGE FROM COLLECTION NAME -> MESSAGES
  //         .where('newsId', isEqualTo: widget.item.newsID.toString())
  //         .orderBy('messageDate', descending: false)
  //         .limit(fetchingDataPerPage)
  //         .get();

  //     return snapshot.docs.isNotEmpty ? true : false;
  //   } catch (e) {
  //     debugPrint('ERR: hasData? ' + e.toString());
  //   }
  // }