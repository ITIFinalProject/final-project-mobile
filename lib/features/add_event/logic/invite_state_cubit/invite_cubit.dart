// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'invite_state.dart';

// class InviteCubit extends Cubit<InviteState> {
//   InviteCubit() : super(InviteInitial());

//   /// ✅ إرسال دعوة للمجموعة اللي كتبنا إيميلهم
//   Future<void> sendInvites(List<String> guestEmails) async {
//     emit(InviteLoading());
//     try {
//       final firestore = FirebaseFirestore.instance;
//       final currentUser = FirebaseAuth.instance.currentUser;

//       if (currentUser == null) {
//         emit(InviteError("User not logged in"));
//         return;
//       }

//       for (String email in guestEmails) {
//         //  نبحث عن المستخدم بالإيميل
//         final query = await firestore
//             .collection('users')
//             .where('email', isEqualTo: email)
//             .get();

//         if (query.docs.isNotEmpty) {
//           final guestDoc = query.docs.first;
//           final guestId = guestDoc.id;

//           // نضيف الدعوة في كولكشن خاص باليوزر
//           await firestore
//               .collection('users')
//               .doc(guestId)
//               .collection('invites')
//               .doc(eventId)
//               .set({
//             'eventId': eventId,
//             'hostId': currentUser.uid,
//             'email': email,
//             'status': 'pending', //  pending | accepted | rejected
//             'timestamp': FieldValue.serverTimestamp(),
//           });
//         }
//       }

//       emit(InviteSuccess());
//     } catch (e) {
//       emit(InviteError("Error sending invites: $e"));
//     }
//   }

//   /// قبول أو رفض الدعوة
//   Future<void> respondToInvite(String inviteOwnerId, String eventId, bool accept) async {
//     emit(InviteLoading());
//     try {
//       final firestore = FirebaseFirestore.instance;
//       final currentUser = FirebaseAuth.instance.currentUser;

//       if (currentUser == null) {
//         emit(InviteError("User not logged in"));
//         return;
//       }

//       //  نحدّث حالة الدعوة (accept/reject)
//       await firestore
//           .collection('users')
//           .doc(currentUser.uid)
//           .collection('invites')
//           .doc(eventId)
//           .update({
//         'status': accept ? 'accepted' : 'rejected',
//       });

//       emit(InviteSuccess());
//     } catch (e) {
//       emit(InviteError("Error responding to invite: $e"));
//     }
//   }
// }
