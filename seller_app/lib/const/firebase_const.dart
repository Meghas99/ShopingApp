import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_app/const/const.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collections

const vendorCollection = "vendor";
const prodctsCollection = "prodects2";
const chatCollection = "chats";
const messageCollection = "messages";
const ordersCollection = "orders";
