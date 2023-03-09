import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/core/value_objects.dart';
import 'package:todo_board/domain/messaging/user_fcm_token.dart';
import 'package:todo_board/infrastructure/core/server_timestamp_converter.dart';

part 'user_fcm_token_data_transfer_object.freezed.dart';

part 'user_fcm_token_data_transfer_object.g.dart';

///Dto: data transfer object
@freezed
class UserFCMTokenDto with _$UserFCMTokenDto {
  factory UserFCMTokenDto({
    @JsonKey(ignore: true) String? id,
    String? createdAt,
    String? updatedAt,
    String? platform,
    String? fcmToken,
    @ServerTimestampConverter() FieldValue? serverTimeStamp,
  }) = _UserFCMTokenDto;

  factory UserFCMTokenDto.fromDomain(UserFCMToken userFCMToken) {
    return UserFCMTokenDto(
      id: userFCMToken.id.getOrCrash(),
      createdAt: userFCMToken.createdAt?.getOrCrash(),
      updatedAt: userFCMToken.updatedAt?.getOrCrash(),
      platform: userFCMToken.platform?.getOrCrash(),
      fcmToken: userFCMToken.fcmToken?.getOrCrash(),
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory UserFCMTokenDto.fromJson(Map<String, dynamic> json) =>
      _$UserFCMTokenDtoFromJson(json);

  factory UserFCMTokenDto.fromFireStore(DocumentSnapshot doc) {
    try {
      final log = getLogger();
      log.i("doc.data():${doc.data()}");
      Map<String, dynamic> jsonFromFireStoreObject =
          doc.data() as Map<String, dynamic>;
      return UserFCMTokenDto.fromJson(jsonFromFireStoreObject)
          .copyWith(id: doc.id);
    } catch (e) {
      final log = getLogger();
      log.e("Error:$e");
      Map<String, dynamic> emptyMap = {};
      return UserFCMTokenDto.fromJson(emptyMap);
    }
  }
}

extension UserFCMTokenDtoX on UserFCMTokenDto {
  UserFCMToken toDomain() {
    return UserFCMToken(
      id: UniqueId.fromUniqueString(id!),
      createdAt: FirebaseStringValue(createdAt),
      updatedAt: FirebaseStringValue(updatedAt),
      platform: FirebaseStringValue(platform),
      fcmToken: FirebaseStringValue(fcmToken),
    );
  }
}
