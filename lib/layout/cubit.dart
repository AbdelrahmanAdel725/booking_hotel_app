import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_system_app/layout/states.dart';
import 'package:sqflite/sqflite.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  Database? database;

  List<Map> alexBranch = [];
  List<Map> cairoBranch = [];
  List<Map> dahabBranch = [];
  List<Map> users = [];
  List<Map>? rooms;

  void createDatabase() {
    openDatabase(
      'hotel.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE hotel (id INTEGER PRIMARY KEY, category TEXT, date TEXT, branch TEXT, price TEXT, booked TEXT, image TEXT, guestName TEXT, guestNum TEXT, guestMail TEXT, guestsNum TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppDatabaseCreatedState());
    });
  }

  createUsersDatabase() async {
    await database!
        .execute(
            'CREATE TABLE guests (id INTEGER PRIMARY KEY, email TEXT, password TEXT,)')
        .then((value) {
      print('table created');
    });
  }

  void getFromDatabase(database) {
    alexBranch = [];
    cairoBranch = [];
    dahabBranch = [];
    database!.rawQuery('SELECT * FROM hotel').then((value) => {
          value.forEach((element) {
            if (element['branch'] == 'Alex')
              alexBranch.add(element);
            else if (element['branch'] == 'Cairo')
              cairoBranch.add(element);
            else
              dahabBranch.add(element);
          }),
          emit(AppGetFromDatabaseState()),
          print(value),
        });
  }

  void discount({
    String? user,
    double? num,
  }) async {
    await database!.rawQuery('SELECT * FROM hotel').then((value) {
      value.forEach((element) {
        if (element['guestName'] == user) {
          element['price'] = element['price'] ?? 0 * 95 / 100 - num!;
        }
      });
    });
  }

  void getUsersData(database) {
    database!.rawQuery('SELECT * FROM guests').then((value) => {
          value.forEach((element) {
            users.add(element);
          }),
          emit(AppGetFromDatabaseState()),
          print(value),
        });
  }

  void insertToDatabase() {
    database!.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO hotel(category, date, branch, price, booked, image, guestName, guestNum, guestMail, guestsNum) VALUES("Single", "", "Alex", "240", "Available", "https://i.pinimg.com/originals/ee/4c/20/ee4c2087d7dc0aa9df1c50874458af16.jpg", "", "", "", "")');
      await txn.rawInsert(
          'INSERT INTO hotel(category, date, branch, price, booked, image, guestName, guestNum, guestMail, guestsNum) VALUES("Double", "", "Alex", "500", "Available", "https://cdn.traveltripper.io/site-assets/512_863_12597/media/2018-02-22-041437/large_DDBDB.jpg", "", "", "", "")');
      await txn.rawInsert(
          'INSERT INTO hotel(category, date, branch, price, booked, image, guestName, guestNum, guestMail, guestsNum) VALUES("Suite", "", "Alex", "1000", "Available", "https://www.citiesoutlook.org/wp-content/uploads/Five-Tips-For-Renting-A-Hotel-Suite.jpg", "", "", "", "")');
      await txn.rawInsert(
          'INSERT INTO hotel(category, date, branch, price, booked, image, guestName, guestNum, guestMail, guestsNum) VALUES("Single", "", "Cairo", "100", "Available", "https://webbox.imgix.net/images/owvecfmxulwbfvxm/c56a0c0d-8454-431a-9b3e-f420c72e82e3.jpg?auto=format,compress&fit=crop&crop=entropy", "", "", "", "")');
      await txn.rawInsert(
          'INSERT INTO hotel(category, date, branch, price, booked, image, guestName, guestNum, guestMail, guestsNum) VALUES("Double", "", "Cairo", "300", "Available", "https://cdn.traveltripper.io/site-assets/512_855_12327/media/2018-02-27-080006/large_ex-double-2.jpg", "", "", "", "")');
      await txn.rawInsert(
          'INSERT INTO hotel(category, date, branch, price, booked, image, guestName, guestNum, guestMail, guestsNum) VALUES("Suite", "", "Cairo", "600", "Available", "https://galeriemagazine.com/wp-content/uploads/2019/03/243f89e0-8235-11e7-a767-bc310e55dd10_1320x770_154749-1024x597.jpg", "", "", "", "")');
      await txn.rawInsert(
          'INSERT INTO hotel(category, date, branch, price, booked, image, guestName, guestNum, guestMail, guestsNum) VALUES("Single", "", "Dahab", "400", "Available", "https://23c133e0c1637be1e07d-be55c16c6d91e6ac40d594f7e280b390.ssl.cf1.rackcdn.com/u/phhk/home/1a-Superior-Single-Room-min1.jpg", "", "", "", "")');
      await txn.rawInsert(
          'INSERT INTO hotel(category, date, branch, price, booked, image, guestName, guestNum, guestMail, guestsNum) VALUES("Double", "", "Dahab", "700", "Available", "https://www.elliotparkhotel.com/wp-content/uploads/2018/05/double-queen-eph-01-1440x973.jpg", "", "", "", "")');
      await txn.rawInsert(
          'INSERT INTO hotel(category, date, branch, price, booked, image, guestName, guestNum, guestMail, guestsNum) VALUES("Suite", "", "Dahab", "1200", "Available", "https://i.pinimg.com/originals/81/ef/62/81ef62819041b3586be39e96fc36bb66.jpg", "", "", "", "")')
          .then((value) {
            print('$value inserted successfully');
        emit(AppInsertToDatabaseState());
        getFromDatabase(database);
          }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  removeDb() {
    deleteDatabase('todo.db').then((value) {
      print('Db deleted');
    });
  }


  void UpdateData({
    required String name,
    required String phone,
    required String email,
    required int id,
  }) async {
    await database!.rawUpdate(
        'UPDATE hotel SET guestName = ?, guestNum = ?, guestMail = ?, booked = ? WHERE id = ?',
        [name, phone, email, "Booked", id]).then((value) {
      emit(AppUpdateDatabaseState());
      getFromDatabase(database);
    });
  }

  void DeleteData({
    required int id,
  }) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getFromDatabase(database);
      emit(AppDeleteFromDatabaseState());
    });
  }

  Future UpdatePrice({
    required double price,
    required int id,
  }) async {
    await database!.rawUpdate(
        'UPDATE hotel SET price = ? WHERE id = ?',
        [price,id]).then((value) {
      emit(AppUpdateDatabaseState());
    });}
  }

