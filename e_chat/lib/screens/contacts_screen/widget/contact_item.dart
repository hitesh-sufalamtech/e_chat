import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../consts.dart';

class ContactItem extends StatelessWidget {
  final DocumentSnapshot item;
  final Function onTap;

  const ContactItem({
    @required this.item,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        // splashColor: Colors.transparent,
        highlightColor: kBlackColor2,
        onTap: () => onTap(context, item),
        child: Container(
          height: 70,
          child: Center(
            child: ListTile(
                // contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: CircleAvatar(
                  backgroundColor: kBlackColor3,
                  radius: 27,
                  child: (item.get('imageUrl') == null ||
                          item.get('imageUrl').toString() == '')
                      ? Icon(
                          Icons.person,
                          size: 25,
                          color: kBaseWhiteColor,
                        )
                      : null,
                  backgroundImage: (item.get('imageUrl') != null &&
                          item.get('imageUrl').toString() != '')
                      ? CachedNetworkImageProvider(item.get('imageUrl').toString())
                      : null,
                ),
                title: Text(item.get('username') ?? 'NA',
                    style: kChatItemTitleStyle)),
          ),
        ),
      ),
    );
  }
}
