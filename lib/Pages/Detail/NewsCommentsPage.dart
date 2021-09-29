import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:senviki_app/Model/FakeNewsEntity.dart';
import 'package:senviki_app/Model/CommentEntity.dart';
import 'package:senviki_app/Model/UserEntity.dart';
import 'package:senviki_app/Pages/Auth/LoginPage.dart';
import 'package:senviki_app/Service/CommentsFirestore.dart';
import 'package:senviki_app/Service/UserFirestore.dart';
import 'package:senviki_app/Utility/Colors.dart';
import 'package:senviki_app/Utility/util.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path/path.dart';
import 'package:swipe_to/swipe_to.dart';

class NewsCommentsPage extends StatefulWidget {
  FakeNewsEntity item;
  NewsCommentsPage(this.item);
  @override
  _NewsCommentsPageState createState() => _NewsCommentsPageState();
}

class _NewsCommentsPageState extends State<NewsCommentsPage> {
  var firestoreInstance = FirebaseFirestore.instance;
  static List<DocumentSnapshot> messageList = [];
  bool fetchLoadingData = true;
  bool fetchLoadingMoreData = false;
  bool fetchLoadingMoreDataIsAvaliable = true;
  DocumentSnapshot lastDocument;
  int fetchingDataPerPage = 10;

  TextEditingController _messageController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  ScrollController scrollController = ScrollController();

  final picker = ImagePicker();
  File image;
  String imagePath;

  bool uploadingImage = false;

  bool hasSwipeReply = false;
  CommentEntity replyFromParentCommentItem;
  String parentCommentAuthorName;

  bool haveCommentData = false;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('tr');

    // scrollController.addListener(() {
    //   var maxScroll = scrollController.position.maxScrollExtent;
    //   var currentScroll = scrollController.position.pixels;
    //   if (currentScroll == maxScroll) {
    //     if (haveCommentData) {
    //       fetchMoreData().whenComplete(() {
    //         setState(() {});
    //       });
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            FontAwesomeIcons.chevronLeft,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Yorumlar',
          style: GoogleFonts.openSans(
              color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
          width: getSize(context),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: CommentsFirestoreService.getStream(
                      widget.item.newsID.toString(), true),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Icon(
                          FontAwesomeIcons.exclamation,
                          size: 30,
                          color: Colors.red,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final QuerySnapshot querySnapshot = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        reverse: true,

                        padding: EdgeInsets.only(top: 20),
                        itemCount: querySnapshot.size,
                        itemBuilder: (context, index) {
                          final item = CommentEntity.fromMap(
                              querySnapshot.docs[index].data());
                          if (FirebaseAuth.instance.currentUser.uid
                                  .compareTo(item.userUid) ==
                              0) {
                            item.key = 1;
                          } else {
                            item.key = 2;
                          }

                          return SwipeTo(
                              onLeftSwipe: () {
                                if (!_focusNode.hasFocus) {
                                  hasSwipeReply = true;
                                  replyFromParentCommentItem = item;
                                  _focusNode.requestFocus();
                                } else {
                                  hasSwipeReply = false;
                                  replyFromParentCommentItem = null;
                                  _focusNode.unfocus();
                                }
                              },
                              child: MessageItem(item));
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),


              InkWell(
                onTap: () {
                  if (!loginControl()) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false);
                  }
                },
                child: Column(
                  children: [
                    hasSwipeReply
                        ? commentReplyViewItem(
                            replyFromParentCommentItem, context)
                        : SizedBox(),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 8,
                        top: 8,
                        right: 8,
                        left: 8,
                      ),
                      child: Container(
                        width: getSize(context),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(100)),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              enabled: loginControl(),
                              focusNode: _focusNode,
                              controller: _messageController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: loginControl()
                                      ? 'Yorumla'
                                      : 'Yorumlamak için giriş yapmalısınız'),
                            )),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    getImage();
                                  },
                                  icon: uploadingImage
                                      ? CircularProgressIndicator(
                                          backgroundColor:
                                              AppColors.secondaryColor,
                                        )
                                      : Icon(
                                          imagePath == null
                                              ? Icons.image
                                              : Icons.check,
                                          color: loginControl()
                                              ? AppColors.secondaryColor
                                              : Colors.grey.shade300,
                                        ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      sendComment().whenComplete(() {
                                    setState(() {
                                      haveCommentData = true;
                                    });
                                    
                                  }),
                                  icon: Icon(
                                    Icons.send,
                                    color: loginControl()
                                        ? AppColors.secondaryColor
                                        : Colors.grey.shade300,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  bool loginControl() {
    if (FirebaseAuth.instance.currentUser.isAnonymous) {
      return false;
    } else
      return true;
  }

  

  Future<String> uploadImage() async {
    var res = await FirebaseStorage.instance
        .ref('${FirebaseAuth.instance.currentUser.uid}${DateTime.now()}')
        .putFile(image);
    return res.ref.getDownloadURL();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        imagePath = basename(pickedFile.path);
        // debugPrint(imagePath.toString());
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future<void> sendComment() async {
    String uploadedImageUrl;
    // FIXME: yorum sonrası güncel verilerin çekilmesi
    // fetchLoadingMoreDataIsAvaliable = true;
    if (loginControl() && _messageController.text.isNotEmpty) {
      if (imagePath != null) {
        setState(() {
          uploadingImage = true;
        });
        try {
          uploadImage()
              .then((value) => uploadedImageUrl = value)
              .whenComplete(() {
            CommentsFirestoreService.createMessage(
              CommentEntity(
                newsId: widget.item.newsID.toString(),
                message: _messageController.text,
                messageDate: DateTime.now(),
                messageImageUrl:
                    uploadedImageUrl == null ? null : uploadedImageUrl,
                userUid: FirebaseAuth.instance.currentUser.uid.toString(),
                parentComment:
                    hasSwipeReply ? replyFromParentCommentItem : null,
              ),
            ).whenComplete(() {
              image.delete();
              imagePath = null;
              disposeAfterSendMessage();
              setState(() {
                uploadingImage = false;
                haveCommentData = true;
                messageList.clear();
                // FIXME:
                // fetchLoadingMoreDataIsAvaliable = false;
              });
            });
          });
          // debugPrint(uploadedImageUrl);
        } catch (e) {
          debugPrint('CATCH: ' + e.toString());
        } on FirebaseStorage catch (e) {
          debugPrint('FIREBASESTORAGE CATCH:' + e.toString());
        }
      } else if (imagePath == null) {
        CommentsFirestoreService.createMessage(CommentEntity(
          newsId: widget.item.newsID.toString(),
          message: _messageController.text,
          messageDate: DateTime.now(),
          messageImageUrl: uploadedImageUrl == null ? null : uploadedImageUrl,
          userUid: FirebaseAuth.instance.currentUser.uid.toString(),
          parentComment: hasSwipeReply ? replyFromParentCommentItem : null,
        )).whenComplete(() {
          disposeAfterSendMessage();
          setState(() {
            // FIXME:
            // fetchLoadingMoreDataIsAvaliable = true;
            haveCommentData = true;
            messageList.clear();
          });
        });
      }
    } else {
      _focusNode.unfocus();
    }
  }

  disposeAfterSendMessage() {
    _messageController.clear();
    replyFromParentCommentItem = null;
    hasSwipeReply = false;
    _focusNode.unfocus();
  }

  commentReplyViewItem(
      CommentEntity replyFromParentCommentItem, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            FontAwesomeIcons.share,
            size: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('_reply_user_name'),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(right: 10, left: 10),
            decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(0),
                )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  replyFromParentCommentItem.message,
                  style: MyTheme.bodyTextMessage
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.times,
                      color: AppColors.backgroundColor.withOpacity(.5)),
                  iconSize: 25,
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.only(right: 5, left: 15),
                  constraints: BoxConstraints(),
                  onPressed: () {
                    replyFromParentCommentItem = null;
                    hasSwipeReply = false;
                    _messageController.clear();
                    _focusNode.unfocus();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getUser(String uid) async {
    try {
      UserFirestoreService.getUserStream(uid).forEach((element) {
        return UserEntity.fromMap(element.docs[0].data()).name;
      });
    } catch (e) {
      debugPrint('GETUSER CATCH: ' + e);
    }
  }
}

class MessageItem extends StatefulWidget {
  CommentEntity item;
  MessageItem(this.item);
  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  String displayNameUser = " ";
  String displayReplyNameUser = " ";

  var firestoreInstance = FirebaseFirestore.instance;
  bool fetchLoadingData = true;
  bool fetchLoadingMoreData = false;
  bool fetchLoadingMoreDataIsAvaliable = true;
  DocumentSnapshot lastDocument;
  int fetchingDataPerPage = 5;
  static List<DocumentSnapshot> repliesList = [];

  bool haveReplies = false;
  bool showReplies = false;

  @override
  void initState() {
    super.initState();
    getUser(widget.item.userUid);
    if (widget.item.parentComment != null) {
      if (widget.item.parentComment.userUid != null) {
        if (widget.item.parentComment.userUid.isNotEmpty) {
          if (widget.item.parentComment.userUid.length > 0) {
            getReplyUser(widget.item.parentComment.userUid);
          }
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        children: [
          widget.item.key == 2
              ? buildCommentItem(context)
              : buildMeCommentItem(context)
        ],
      ),
    );
  }

  Widget functionDate(DateTime gelenDeger) {
    try {
      if (gelenDeger != null) {
        DateTime now = gelenDeger;
        DateTime yeni =
            new DateTime(now.year, now.month, now.day, now.hour, now.minute);
        DateFormat dateFormat = DateFormat("dd.MM .yyyy HH:mm");
        String tarihSaat = dateFormat.format(yeni);
        return Text(
          tarihSaat,
          style: MyTheme.bodyTextTime,
        );
      }
      if (gelenDeger == null) {
        return Text("Boş");
      }
    } catch (Exception) {
      return Text("Boş");
    }
  }

  bool verticalGallery = false;

  Future<void> getUser(String uid) async {
    try {
      UserFirestoreService.getUserStream(uid).forEach((element) {
        displayNameUser = UserEntity.fromMap(element.docs[0].data()).name;
        setState(() {});
      });
    } catch (e) {
      debugPrint('!!! getUser catch: ' + e);
    }
  }

  Future<void> getReplyUser(String uid) async {
    try {
      UserFirestoreService.getUserStream(uid).forEach((element) {
        displayReplyNameUser = UserEntity.fromMap(element.docs[0].data()).name;
        setState(() {});
      });
    } catch (e) {
      debugPrint('!!! getUser catch: ' + e);
    }
  }

  buildMeCommentItem(BuildContext context) {
    return widget.item.parentComment == null
        ? Container(
            margin: EdgeInsets.only(top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6),
                      decoration: BoxDecoration(
                          color: showReplies
                              ? AppColors.secondaryColor.withOpacity(.4)
                              : Colors.blue.withOpacity(0.9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(0),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.item.message,
                            style: MyTheme.bodyTextMessage
                                .copyWith(color: Colors.white),
                          ),
                          widget.item.messageImageUrl != null
                              ? InkWell(
                                  onTap: () {
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
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Image.network(
                                        widget.item.messageImageUrl,
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.done_all,
                        size: 20,
                        color: MyTheme.bodyTextTime.color,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      functionDate(widget.item.messageDate)
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: getSize(context) * 0.6,
                          // constraints: BoxConstraints(
                          //     maxWidth:
                          //         MediaQuery.of(context).size.width * 0.6),
                          decoration: BoxDecoration(
                              color: AppColors.secondaryColor.withOpacity(.9),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(FontAwesomeIcons.share,
                                      color: AppColors.secondaryColor),
                                  Text(
                                    widget.item.parentComment.message,
                                    style: MyTheme.bodyTextMessage
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                              widget.item.parentComment.messageImageUrl != null
                                  ? InkWell(
                                      onTap: () {},
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Image.network(
                                            widget.item.messageImageUrl,
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          padding: EdgeInsets.all(10),
                          // constraints: BoxConstraints(
                          //     maxWidth:
                          //         MediaQuery.of(context).size.width * 0.6),
                          width: getSize(context) * 0.6,
                          decoration: BoxDecoration(
                              color: showReplies
                                  ? AppColors.secondaryColor.withOpacity(.4)
                                  : Colors.blue.withOpacity(0.9),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(0),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.item.message,
                                style: MyTheme.bodyTextMessage
                                    .copyWith(color: Colors.white),
                              ),
                              widget.item.messageImageUrl != null
                                  ? InkWell(
                                      onTap: () {},
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Image.network(
                                            widget.item.messageImageUrl,
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.done_all,
                        size: 20,
                        color: MyTheme.bodyTextTime.color,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      functionDate(widget.item.messageDate)
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  buildCommentItem(BuildContext context) {
    return widget.item.parentComment == null
        ? Container(
            margin: EdgeInsets.only(top: 10, left: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: Text(
                        '${displayNameUser[0].toUpperCase()}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6),
                      decoration: BoxDecoration(
                          color: Colors.grey[300].withOpacity(0.4),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(12),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$displayNameUser",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            widget.item.message,
                            style: MyTheme.bodyTextMessage
                                .copyWith(color: Colors.grey[800]),
                          ),
                          widget.item.messageImageUrl != null
                              ? InkWell(
                                  onTap: () {
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
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Image.network(
                                        widget.item.messageImageUrl,
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Icon(
                        Icons.done_all,
                        size: 20,
                        color: MyTheme.bodyTextTime.color,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      functionDate(widget.item.messageDate)
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 10, left: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: Text(
                        '${displayNameUser[0].toUpperCase()}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.6),
                          decoration: BoxDecoration(
                              color: Colors.grey[300].withOpacity(0.4),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(12),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "___",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.share,
                                    color: Colors.grey.shade400,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      widget.item.message,
                                      style: MyTheme.bodyTextMessage
                                          .copyWith(color: Colors.grey[800]),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Text(
                                "$displayNameUser",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                widget.item.message,
                                style: MyTheme.bodyTextMessage
                                    .copyWith(color: Colors.grey[800]),
                              ),
                              widget.item.messageImageUrl != null
                                  ? InkWell(
                                      onTap: () {
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
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Image.network(
                                            widget.item.messageImageUrl,
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Icon(
                        Icons.done_all,
                        size: 20,
                        color: MyTheme.bodyTextTime.color,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      functionDate(widget.item.messageDate)
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

class MyTheme {
  MyTheme._();
  static Color kPrimaryColor = Color(0xff7C7B9B);
  static Color kPrimaryColorVariant = Color(0xff686795);
  static Color kAccentColor = Color(0xffFCAAAB);
  static Color kAccentColorVariant = Color(0xffF7A3A2);
  static Color kUnreadChatBG = Color(0xffEE1D1D);

  static final TextStyle kAppTitle = GoogleFonts.grandHotel(fontSize: 36);

  static final TextStyle heading2 = TextStyle(
    color: Color(0xff686795),
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );

  static final TextStyle chatSenderName = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );

  static final TextStyle bodyText1 = TextStyle(
      color: Color(0xffAEABC9),
      fontSize: 14,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w500);

  static final TextStyle bodyTextMessage =
      TextStyle(fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.w600);

  static final TextStyle bodyTextTime = TextStyle(
    color: Color(0xffAEABC9),
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
}
