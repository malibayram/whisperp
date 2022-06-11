import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:whisperp/models/user_model.dart';
import 'package:whisperp/ui/constants.dart';
import 'package:flutter/material.dart';

import 'components/chat_input_field.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserModel;
    final colRef = FirebaseFirestore.instance.collection('messages');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const BackButton(),
            CircleAvatar(
              child: ClipOval(
                child: kIsWeb
                    ? Image.network(user.photoURL)
                    : CachedNetworkImageBuilder(
                        url: user.photoURL,
                        builder: (image) {
                          return Image.file(image);
                        },
                      ),
              ),
            ),
            const SizedBox(width: kDefaultPadding * 0.75),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName,
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  "Online",
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_phone),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.security),
            onPressed: () {},
          ),
          const SizedBox(width: kDefaultPadding / 2),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: FutureBuilder<String>(
          future: Future.microtask(() async {
            final uid = FirebaseAuth.instance.currentUser?.uid;

            final doc1 = await colRef.doc("${user.uid}::$uid").get();

            if (doc1.exists) return doc1.id;

            final doc2 = await colRef.doc("$uid::${user.uid}").get();

            if (doc2.exists) return doc2.id;

            await colRef.doc("$uid::${user.uid}").set({
              'participants': [uid, user.uid],
              'timestamp': FieldValue.serverTimestamp(),
            });

            // KISS - SOLID - DRY - WET

            return "$uid::${user.uid}";
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final docId = snapshot.data!;
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: colRef
                    .doc(docId)
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .endBefore([
                  Timestamp.fromDate(DateTime(2022, 1, 1)),
                ]).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              return Text(docs[index].data()['text']);
                            },
                          ),
                        ),
                        ChatInputField(messagesDocId: docId),
                      ],
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
