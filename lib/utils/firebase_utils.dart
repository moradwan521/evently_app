import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_data_model.dart';

abstract class FirebaseUtils {
  static CollectionReference<EventDataModel> getCollectionRef() {
    return FirebaseFirestore.instance
        .collection(EventDataModel.collectionName)
        .withConverter<EventDataModel>(
          fromFirestore: (snapshot, _) =>
              EventDataModel.fromFireStore(snapshot.data()!),
          toFirestore: (value, _) => value.toFireStore(),
        );
  }

  static Future<void> updateEvent(EventDataModel data) async {
    if (data.eventId == null) {
      throw Exception("Cannot update an event without eventId");
    }
    var collectionRef = getCollectionRef();
    await collectionRef.doc(data.eventId).update(data.toFireStore());
  }

  static Future<void> deleteEvent(String eventId) async {
    if (eventId.isEmpty) {
      throw Exception("Cannot delete event without eventId");
    }
    var collectionRef = getCollectionRef();
    await collectionRef.doc(eventId).delete();
  }

  static Future<void> addEvent(EventDataModel data) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc();
    data.eventId = docRef.id;
    docRef.set(data);
  }

  static Future<List<EventDataModel>> getDataFromFirestore() async {
    var collectionRef = getCollectionRef();
    var snapshot = await collectionRef.get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  static Stream<QuerySnapshot<EventDataModel>> getStreamData(
    String categoryId,
  ) {
    var collectionRef = getCollectionRef().where(
     "eventCategoryId",
      isEqualTo: categoryId,
    );
    return collectionRef.snapshots();
  }

  static Stream<QuerySnapshot<EventDataModel>> getStreamFavoriteData() {
    var collectionRef = getCollectionRef().where(
      "isFavorite",
      isEqualTo: true,
    );
    return collectionRef.snapshots();
  }
}
