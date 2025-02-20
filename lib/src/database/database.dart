import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

@DataClassName("CommunicationSymbolEntity")
class CommunicationSymbol extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get label => text()();
  TextColumn get imagePath => text()();
  TextColumn get vocalization => text().nullable()();
  IntColumn get color => integer().nullable()();
  BoolColumn get isDeleted  => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().nullable()();
  IntColumn get childBoardId => integer().nullable().references(Board, #id)();
}

@DataClassName("BoardEntity")
class Board extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get crossAxisCount => integer().withDefault(const Constant(3))();
  TextColumn get name => text()();
}

@DataClassName("ChildSymbolEntity")
class ChildSymbol extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get position => integer()();
  IntColumn get boardId => integer().references(Board, #id)();
  IntColumn get symbolId => integer().references(CommunicationSymbol, #id)();
}

@DriftDatabase(tables: [Board, CommunicationSymbol, ChildSymbol])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (m) async {
        await m.createAll();
        await into(board).insert(BoardCompanion.insert(name: "Główna"));
    });
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));

      return NativeDatabase.createInBackground(file);
    });
  }
}

@Riverpod(keepAlive: true)
AppDatabase db(Ref ref) {
  throw UnimplementedError();
}
