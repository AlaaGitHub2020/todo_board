import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_board/domain/auth/i_auth_repository.dart';
import 'package:todo_board/domain/core/errors.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/injection.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = await getIt<IAuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(
      () => throw NotAuthenticatedError(),
    );

    return FirebaseFirestore.instance.collection(Strings.fDBUsers).doc(
          user.id.getOrCrash(),
        );
  }

  Future<DocumentReference> usersFCMTokensDocument(String userID) async {
    return FirebaseFirestore.instance
        .collection(Strings.fDBUserTokens)
        .doc(userID);
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get taskCollection => collection(Strings.fDBTasks);

  CollectionReference get userFCMTokensCollection =>
      collection(Strings.fDBUserFCMTokens);

  CollectionReference taskTimerHistoryCollection(String tasksId) =>
      taskCollection.doc(tasksId).collection(Strings.fDBTimerHistory);

  deleteTaskTimerHistoryCollection(String taskId) async {
    await taskTimerHistoryCollection(taskId).get().then((snapshot) {
      for (DocumentSnapshot document in snapshot.docs) {
        document.reference.delete();
      }
    });
  }
}
