// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Board extends Table with TableInfo<Board, BoardEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Board(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _crossAxisCountMeta =
      const VerificationMeta('crossAxisCount');
  late final GeneratedColumn<int> crossAxisCount = GeneratedColumn<int>(
      'cross_axis_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 3',
      defaultValue: const CustomExpression('3'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, crossAxisCount, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'board';
  @override
  VerificationContext validateIntegrity(Insertable<BoardEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cross_axis_count')) {
      context.handle(
          _crossAxisCountMeta,
          crossAxisCount.isAcceptableOrUnknown(
              data['cross_axis_count']!, _crossAxisCountMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BoardEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BoardEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      crossAxisCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cross_axis_count'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  Board createAlias(String alias) {
    return Board(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  bool get dontWriteConstraints => true;
}

class BoardEntity extends DataClass implements Insertable<BoardEntity> {
  final int id;
  final int crossAxisCount;
  final String name;
  const BoardEntity(
      {required this.id, required this.crossAxisCount, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cross_axis_count'] = Variable<int>(crossAxisCount);
    map['name'] = Variable<String>(name);
    return map;
  }

  BoardCompanion toCompanion(bool nullToAbsent) {
    return BoardCompanion(
      id: Value(id),
      crossAxisCount: Value(crossAxisCount),
      name: Value(name),
    );
  }

  factory BoardEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BoardEntity(
      id: serializer.fromJson<int>(json['id']),
      crossAxisCount: serializer.fromJson<int>(json['cross_axis_count']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cross_axis_count': serializer.toJson<int>(crossAxisCount),
      'name': serializer.toJson<String>(name),
    };
  }

  BoardEntity copyWith({int? id, int? crossAxisCount, String? name}) =>
      BoardEntity(
        id: id ?? this.id,
        crossAxisCount: crossAxisCount ?? this.crossAxisCount,
        name: name ?? this.name,
      );
  BoardEntity copyWithCompanion(BoardCompanion data) {
    return BoardEntity(
      id: data.id.present ? data.id.value : this.id,
      crossAxisCount: data.crossAxisCount.present
          ? data.crossAxisCount.value
          : this.crossAxisCount,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BoardEntity(')
          ..write('id: $id, ')
          ..write('crossAxisCount: $crossAxisCount, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, crossAxisCount, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BoardEntity &&
          other.id == this.id &&
          other.crossAxisCount == this.crossAxisCount &&
          other.name == this.name);
}

class BoardCompanion extends UpdateCompanion<BoardEntity> {
  final Value<int> id;
  final Value<int> crossAxisCount;
  final Value<String> name;
  const BoardCompanion({
    this.id = const Value.absent(),
    this.crossAxisCount = const Value.absent(),
    this.name = const Value.absent(),
  });
  BoardCompanion.insert({
    this.id = const Value.absent(),
    this.crossAxisCount = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<BoardEntity> custom({
    Expression<int>? id,
    Expression<int>? crossAxisCount,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (crossAxisCount != null) 'cross_axis_count': crossAxisCount,
      if (name != null) 'name': name,
    });
  }

  BoardCompanion copyWith(
      {Value<int>? id, Value<int>? crossAxisCount, Value<String>? name}) {
    return BoardCompanion(
      id: id ?? this.id,
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (crossAxisCount.present) {
      map['cross_axis_count'] = Variable<int>(crossAxisCount.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BoardCompanion(')
          ..write('id: $id, ')
          ..write('crossAxisCount: $crossAxisCount, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class CommunicationSymbol extends Table
    with TableInfo<CommunicationSymbol, CommunicationSymbolEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CommunicationSymbol(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _vocalizationMeta =
      const VerificationMeta('vocalization');
  late final GeneratedColumn<String> vocalization = GeneratedColumn<String>(
      'vocalization', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT FALSE',
      defaultValue: const CustomExpression('FALSE'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  static const VerificationMeta _childBoardIdMeta =
      const VerificationMeta('childBoardId');
  late final GeneratedColumn<int> childBoardId = GeneratedColumn<int>(
      'child_board_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL REFERENCES board(id)');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        label,
        imagePath,
        vocalization,
        color,
        isDeleted,
        createdAt,
        childBoardId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'communication_symbol';
  @override
  VerificationContext validateIntegrity(
      Insertable<CommunicationSymbolEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('vocalization')) {
      context.handle(
          _vocalizationMeta,
          vocalization.isAcceptableOrUnknown(
              data['vocalization']!, _vocalizationMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('child_board_id')) {
      context.handle(
          _childBoardIdMeta,
          childBoardId.isAcceptableOrUnknown(
              data['child_board_id']!, _childBoardIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommunicationSymbolEntity map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommunicationSymbolEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      vocalization: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vocalization']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at']),
      childBoardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_board_id']),
    );
  }

  @override
  CommunicationSymbol createAlias(String alias) {
    return CommunicationSymbol(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  bool get dontWriteConstraints => true;
}

class CommunicationSymbolEntity extends DataClass
    implements Insertable<CommunicationSymbolEntity> {
  final int id;
  final String label;
  final String imagePath;
  final String? vocalization;
  final int? color;
  final bool isDeleted;
  final int? createdAt;
  final int? childBoardId;
  const CommunicationSymbolEntity(
      {required this.id,
      required this.label,
      required this.imagePath,
      this.vocalization,
      this.color,
      required this.isDeleted,
      this.createdAt,
      this.childBoardId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    map['image_path'] = Variable<String>(imagePath);
    if (!nullToAbsent || vocalization != null) {
      map['vocalization'] = Variable<String>(vocalization);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || childBoardId != null) {
      map['child_board_id'] = Variable<int>(childBoardId);
    }
    return map;
  }

  CommunicationSymbolCompanion toCompanion(bool nullToAbsent) {
    return CommunicationSymbolCompanion(
      id: Value(id),
      label: Value(label),
      imagePath: Value(imagePath),
      vocalization: vocalization == null && nullToAbsent
          ? const Value.absent()
          : Value(vocalization),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      isDeleted: Value(isDeleted),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      childBoardId: childBoardId == null && nullToAbsent
          ? const Value.absent()
          : Value(childBoardId),
    );
  }

  factory CommunicationSymbolEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommunicationSymbolEntity(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      imagePath: serializer.fromJson<String>(json['image_path']),
      vocalization: serializer.fromJson<String?>(json['vocalization']),
      color: serializer.fromJson<int?>(json['color']),
      isDeleted: serializer.fromJson<bool>(json['is_deleted']),
      createdAt: serializer.fromJson<int?>(json['created_at']),
      childBoardId: serializer.fromJson<int?>(json['child_board_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'image_path': serializer.toJson<String>(imagePath),
      'vocalization': serializer.toJson<String?>(vocalization),
      'color': serializer.toJson<int?>(color),
      'is_deleted': serializer.toJson<bool>(isDeleted),
      'created_at': serializer.toJson<int?>(createdAt),
      'child_board_id': serializer.toJson<int?>(childBoardId),
    };
  }

  CommunicationSymbolEntity copyWith(
          {int? id,
          String? label,
          String? imagePath,
          Value<String?> vocalization = const Value.absent(),
          Value<int?> color = const Value.absent(),
          bool? isDeleted,
          Value<int?> createdAt = const Value.absent(),
          Value<int?> childBoardId = const Value.absent()}) =>
      CommunicationSymbolEntity(
        id: id ?? this.id,
        label: label ?? this.label,
        imagePath: imagePath ?? this.imagePath,
        vocalization:
            vocalization.present ? vocalization.value : this.vocalization,
        color: color.present ? color.value : this.color,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        childBoardId:
            childBoardId.present ? childBoardId.value : this.childBoardId,
      );
  CommunicationSymbolEntity copyWithCompanion(
      CommunicationSymbolCompanion data) {
    return CommunicationSymbolEntity(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      vocalization: data.vocalization.present
          ? data.vocalization.value
          : this.vocalization,
      color: data.color.present ? data.color.value : this.color,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      childBoardId: data.childBoardId.present
          ? data.childBoardId.value
          : this.childBoardId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommunicationSymbolEntity(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('imagePath: $imagePath, ')
          ..write('vocalization: $vocalization, ')
          ..write('color: $color, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('childBoardId: $childBoardId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, imagePath, vocalization, color,
      isDeleted, createdAt, childBoardId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommunicationSymbolEntity &&
          other.id == this.id &&
          other.label == this.label &&
          other.imagePath == this.imagePath &&
          other.vocalization == this.vocalization &&
          other.color == this.color &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.childBoardId == this.childBoardId);
}

class CommunicationSymbolCompanion
    extends UpdateCompanion<CommunicationSymbolEntity> {
  final Value<int> id;
  final Value<String> label;
  final Value<String> imagePath;
  final Value<String?> vocalization;
  final Value<int?> color;
  final Value<bool> isDeleted;
  final Value<int?> createdAt;
  final Value<int?> childBoardId;
  const CommunicationSymbolCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.vocalization = const Value.absent(),
    this.color = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.childBoardId = const Value.absent(),
  });
  CommunicationSymbolCompanion.insert({
    this.id = const Value.absent(),
    required String label,
    required String imagePath,
    this.vocalization = const Value.absent(),
    this.color = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.childBoardId = const Value.absent(),
  })  : label = Value(label),
        imagePath = Value(imagePath);
  static Insertable<CommunicationSymbolEntity> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<String>? imagePath,
    Expression<String>? vocalization,
    Expression<int>? color,
    Expression<bool>? isDeleted,
    Expression<int>? createdAt,
    Expression<int>? childBoardId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (imagePath != null) 'image_path': imagePath,
      if (vocalization != null) 'vocalization': vocalization,
      if (color != null) 'color': color,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (childBoardId != null) 'child_board_id': childBoardId,
    });
  }

  CommunicationSymbolCompanion copyWith(
      {Value<int>? id,
      Value<String>? label,
      Value<String>? imagePath,
      Value<String?>? vocalization,
      Value<int?>? color,
      Value<bool>? isDeleted,
      Value<int?>? createdAt,
      Value<int?>? childBoardId}) {
    return CommunicationSymbolCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      imagePath: imagePath ?? this.imagePath,
      vocalization: vocalization ?? this.vocalization,
      color: color ?? this.color,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      childBoardId: childBoardId ?? this.childBoardId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (vocalization.present) {
      map['vocalization'] = Variable<String>(vocalization.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (childBoardId.present) {
      map['child_board_id'] = Variable<int>(childBoardId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommunicationSymbolCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('imagePath: $imagePath, ')
          ..write('vocalization: $vocalization, ')
          ..write('color: $color, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('childBoardId: $childBoardId')
          ..write(')'))
        .toString();
  }
}

class ChildSymbol extends Table with TableInfo<ChildSymbol, ChildSymbolEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChildSymbol(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _boardIdMeta =
      const VerificationMeta('boardId');
  late final GeneratedColumn<int> boardId = GeneratedColumn<int>(
      'board_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES board(id)');
  static const VerificationMeta _symbolIdMeta =
      const VerificationMeta('symbolId');
  late final GeneratedColumn<int> symbolId = GeneratedColumn<int>(
      'symbol_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES communication_symbol(id)');
  @override
  List<GeneratedColumn> get $columns => [position, boardId, symbolId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'child_symbol';
  @override
  VerificationContext validateIntegrity(Insertable<ChildSymbolEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('board_id')) {
      context.handle(_boardIdMeta,
          boardId.isAcceptableOrUnknown(data['board_id']!, _boardIdMeta));
    } else if (isInserting) {
      context.missing(_boardIdMeta);
    }
    if (data.containsKey('symbol_id')) {
      context.handle(_symbolIdMeta,
          symbolId.isAcceptableOrUnknown(data['symbol_id']!, _symbolIdMeta));
    } else if (isInserting) {
      context.missing(_symbolIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {boardId, symbolId};
  @override
  ChildSymbolEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChildSymbolEntity(
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      boardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}board_id'])!,
      symbolId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}symbol_id'])!,
    );
  }

  @override
  ChildSymbol createAlias(String alias) {
    return ChildSymbol(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints =>
      const ['PRIMARY KEY(board_id, symbol_id)'];
  @override
  bool get dontWriteConstraints => true;
}

class ChildSymbolEntity extends DataClass
    implements Insertable<ChildSymbolEntity> {
  final int position;
  final int boardId;
  final int symbolId;
  const ChildSymbolEntity(
      {required this.position, required this.boardId, required this.symbolId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['position'] = Variable<int>(position);
    map['board_id'] = Variable<int>(boardId);
    map['symbol_id'] = Variable<int>(symbolId);
    return map;
  }

  ChildSymbolCompanion toCompanion(bool nullToAbsent) {
    return ChildSymbolCompanion(
      position: Value(position),
      boardId: Value(boardId),
      symbolId: Value(symbolId),
    );
  }

  factory ChildSymbolEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChildSymbolEntity(
      position: serializer.fromJson<int>(json['position']),
      boardId: serializer.fromJson<int>(json['board_id']),
      symbolId: serializer.fromJson<int>(json['symbol_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'position': serializer.toJson<int>(position),
      'board_id': serializer.toJson<int>(boardId),
      'symbol_id': serializer.toJson<int>(symbolId),
    };
  }

  ChildSymbolEntity copyWith({int? position, int? boardId, int? symbolId}) =>
      ChildSymbolEntity(
        position: position ?? this.position,
        boardId: boardId ?? this.boardId,
        symbolId: symbolId ?? this.symbolId,
      );
  ChildSymbolEntity copyWithCompanion(ChildSymbolCompanion data) {
    return ChildSymbolEntity(
      position: data.position.present ? data.position.value : this.position,
      boardId: data.boardId.present ? data.boardId.value : this.boardId,
      symbolId: data.symbolId.present ? data.symbolId.value : this.symbolId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChildSymbolEntity(')
          ..write('position: $position, ')
          ..write('boardId: $boardId, ')
          ..write('symbolId: $symbolId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(position, boardId, symbolId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChildSymbolEntity &&
          other.position == this.position &&
          other.boardId == this.boardId &&
          other.symbolId == this.symbolId);
}

class ChildSymbolCompanion extends UpdateCompanion<ChildSymbolEntity> {
  final Value<int> position;
  final Value<int> boardId;
  final Value<int> symbolId;
  final Value<int> rowid;
  const ChildSymbolCompanion({
    this.position = const Value.absent(),
    this.boardId = const Value.absent(),
    this.symbolId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChildSymbolCompanion.insert({
    required int position,
    required int boardId,
    required int symbolId,
    this.rowid = const Value.absent(),
  })  : position = Value(position),
        boardId = Value(boardId),
        symbolId = Value(symbolId);
  static Insertable<ChildSymbolEntity> custom({
    Expression<int>? position,
    Expression<int>? boardId,
    Expression<int>? symbolId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (position != null) 'position': position,
      if (boardId != null) 'board_id': boardId,
      if (symbolId != null) 'symbol_id': symbolId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChildSymbolCompanion copyWith(
      {Value<int>? position,
      Value<int>? boardId,
      Value<int>? symbolId,
      Value<int>? rowid}) {
    return ChildSymbolCompanion(
      position: position ?? this.position,
      boardId: boardId ?? this.boardId,
      symbolId: symbolId ?? this.symbolId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (boardId.present) {
      map['board_id'] = Variable<int>(boardId.value);
    }
    if (symbolId.present) {
      map['symbol_id'] = Variable<int>(symbolId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChildSymbolCompanion(')
          ..write('position: $position, ')
          ..write('boardId: $boardId, ')
          ..write('symbolId: $symbolId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Setting extends Table with TableInfo<Setting, SettingEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Setting(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'setting';
  @override
  VerificationContext validateIntegrity(Insertable<SettingEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingEntity(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  Setting createAlias(String alias) {
    return Setting(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  bool get dontWriteConstraints => true;
}

class SettingEntity extends DataClass implements Insertable<SettingEntity> {
  final String key;
  final String value;
  const SettingEntity({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingCompanion toCompanion(bool nullToAbsent) {
    return SettingCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory SettingEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingEntity(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SettingEntity copyWith({String? key, String? value}) => SettingEntity(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  SettingEntity copyWithCompanion(SettingCompanion data) {
    return SettingEntity(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingEntity(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingEntity &&
          other.key == this.key &&
          other.value == this.value);
}

class SettingCompanion extends UpdateCompanion<SettingEntity> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<SettingEntity> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return SettingCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final Board board = Board(this);
  late final CommunicationSymbol communicationSymbol =
      CommunicationSymbol(this);
  late final ChildSymbol childSymbol = ChildSymbol(this);
  late final Setting setting = Setting(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [board, communicationSymbol, childSymbol, setting];
}

typedef $BoardCreateCompanionBuilder = BoardCompanion Function({
  Value<int> id,
  Value<int> crossAxisCount,
  required String name,
});
typedef $BoardUpdateCompanionBuilder = BoardCompanion Function({
  Value<int> id,
  Value<int> crossAxisCount,
  Value<String> name,
});

final class $BoardReferences
    extends BaseReferences<_$AppDatabase, Board, BoardEntity> {
  $BoardReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<CommunicationSymbol,
      List<CommunicationSymbolEntity>> _communicationSymbolRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.communicationSymbol,
          aliasName: $_aliasNameGenerator(
              db.board.id, db.communicationSymbol.childBoardId));

  $CommunicationSymbolProcessedTableManager get communicationSymbolRefs {
    final manager = $CommunicationSymbolTableManager(
            $_db, $_db.communicationSymbol)
        .filter((f) => f.childBoardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_communicationSymbolRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<ChildSymbol, List<ChildSymbolEntity>>
      _childSymbolRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.childSymbol,
          aliasName: $_aliasNameGenerator(db.board.id, db.childSymbol.boardId));

  $ChildSymbolProcessedTableManager get childSymbolRefs {
    final manager = $ChildSymbolTableManager($_db, $_db.childSymbol)
        .filter((f) => f.boardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_childSymbolRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $BoardFilterComposer extends Composer<_$AppDatabase, Board> {
  $BoardFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get crossAxisCount => $composableBuilder(
      column: $table.crossAxisCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> communicationSymbolRefs(
      Expression<bool> Function($CommunicationSymbolFilterComposer f) f) {
    final $CommunicationSymbolFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.communicationSymbol,
        getReferencedColumn: (t) => t.childBoardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CommunicationSymbolFilterComposer(
              $db: $db,
              $table: $db.communicationSymbol,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> childSymbolRefs(
      Expression<bool> Function($ChildSymbolFilterComposer f) f) {
    final $ChildSymbolFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.childSymbol,
        getReferencedColumn: (t) => t.boardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $ChildSymbolFilterComposer(
              $db: $db,
              $table: $db.childSymbol,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $BoardOrderingComposer extends Composer<_$AppDatabase, Board> {
  $BoardOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get crossAxisCount => $composableBuilder(
      column: $table.crossAxisCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $BoardAnnotationComposer extends Composer<_$AppDatabase, Board> {
  $BoardAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get crossAxisCount => $composableBuilder(
      column: $table.crossAxisCount, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> communicationSymbolRefs<T extends Object>(
      Expression<T> Function($CommunicationSymbolAnnotationComposer a) f) {
    final $CommunicationSymbolAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.communicationSymbol,
        getReferencedColumn: (t) => t.childBoardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CommunicationSymbolAnnotationComposer(
              $db: $db,
              $table: $db.communicationSymbol,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> childSymbolRefs<T extends Object>(
      Expression<T> Function($ChildSymbolAnnotationComposer a) f) {
    final $ChildSymbolAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.childSymbol,
        getReferencedColumn: (t) => t.boardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $ChildSymbolAnnotationComposer(
              $db: $db,
              $table: $db.childSymbol,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $BoardTableManager extends RootTableManager<
    _$AppDatabase,
    Board,
    BoardEntity,
    $BoardFilterComposer,
    $BoardOrderingComposer,
    $BoardAnnotationComposer,
    $BoardCreateCompanionBuilder,
    $BoardUpdateCompanionBuilder,
    (BoardEntity, $BoardReferences),
    BoardEntity,
    PrefetchHooks Function(
        {bool communicationSymbolRefs, bool childSymbolRefs})> {
  $BoardTableManager(_$AppDatabase db, Board table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $BoardFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $BoardOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $BoardAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> crossAxisCount = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              BoardCompanion(
            id: id,
            crossAxisCount: crossAxisCount,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> crossAxisCount = const Value.absent(),
            required String name,
          }) =>
              BoardCompanion.insert(
            id: id,
            crossAxisCount: crossAxisCount,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $BoardReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {communicationSymbolRefs = false, childSymbolRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (communicationSymbolRefs) db.communicationSymbol,
                if (childSymbolRefs) db.childSymbol
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (communicationSymbolRefs)
                    await $_getPrefetchedData<BoardEntity, Board,
                            CommunicationSymbolEntity>(
                        currentTable: table,
                        referencedTable:
                            $BoardReferences._communicationSymbolRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $BoardReferences(db, table, p0)
                                .communicationSymbolRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.childBoardId == item.id),
                        typedResults: items),
                  if (childSymbolRefs)
                    await $_getPrefetchedData<BoardEntity, Board,
                            ChildSymbolEntity>(
                        currentTable: table,
                        referencedTable:
                            $BoardReferences._childSymbolRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $BoardReferences(db, table, p0).childSymbolRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.boardId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $BoardProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    Board,
    BoardEntity,
    $BoardFilterComposer,
    $BoardOrderingComposer,
    $BoardAnnotationComposer,
    $BoardCreateCompanionBuilder,
    $BoardUpdateCompanionBuilder,
    (BoardEntity, $BoardReferences),
    BoardEntity,
    PrefetchHooks Function(
        {bool communicationSymbolRefs, bool childSymbolRefs})>;
typedef $CommunicationSymbolCreateCompanionBuilder
    = CommunicationSymbolCompanion Function({
  Value<int> id,
  required String label,
  required String imagePath,
  Value<String?> vocalization,
  Value<int?> color,
  Value<bool> isDeleted,
  Value<int?> createdAt,
  Value<int?> childBoardId,
});
typedef $CommunicationSymbolUpdateCompanionBuilder
    = CommunicationSymbolCompanion Function({
  Value<int> id,
  Value<String> label,
  Value<String> imagePath,
  Value<String?> vocalization,
  Value<int?> color,
  Value<bool> isDeleted,
  Value<int?> createdAt,
  Value<int?> childBoardId,
});

final class $CommunicationSymbolReferences extends BaseReferences<_$AppDatabase,
    CommunicationSymbol, CommunicationSymbolEntity> {
  $CommunicationSymbolReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static Board _childBoardIdTable(_$AppDatabase db) => db.board.createAlias(
      $_aliasNameGenerator(db.communicationSymbol.childBoardId, db.board.id));

  $BoardProcessedTableManager? get childBoardId {
    final $_column = $_itemColumn<int>('child_board_id');
    if ($_column == null) return null;
    final manager = $BoardTableManager($_db, $_db.board)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_childBoardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<ChildSymbol, List<ChildSymbolEntity>>
      _childSymbolRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.childSymbol,
              aliasName: $_aliasNameGenerator(
                  db.communicationSymbol.id, db.childSymbol.symbolId));

  $ChildSymbolProcessedTableManager get childSymbolRefs {
    final manager = $ChildSymbolTableManager($_db, $_db.childSymbol)
        .filter((f) => f.symbolId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_childSymbolRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $CommunicationSymbolFilterComposer
    extends Composer<_$AppDatabase, CommunicationSymbol> {
  $CommunicationSymbolFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vocalization => $composableBuilder(
      column: $table.vocalization, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $BoardFilterComposer get childBoardId {
    final $BoardFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childBoardId,
        referencedTable: $db.board,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $BoardFilterComposer(
              $db: $db,
              $table: $db.board,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> childSymbolRefs(
      Expression<bool> Function($ChildSymbolFilterComposer f) f) {
    final $ChildSymbolFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.childSymbol,
        getReferencedColumn: (t) => t.symbolId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $ChildSymbolFilterComposer(
              $db: $db,
              $table: $db.childSymbol,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $CommunicationSymbolOrderingComposer
    extends Composer<_$AppDatabase, CommunicationSymbol> {
  $CommunicationSymbolOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vocalization => $composableBuilder(
      column: $table.vocalization,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $BoardOrderingComposer get childBoardId {
    final $BoardOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childBoardId,
        referencedTable: $db.board,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $BoardOrderingComposer(
              $db: $db,
              $table: $db.board,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $CommunicationSymbolAnnotationComposer
    extends Composer<_$AppDatabase, CommunicationSymbol> {
  $CommunicationSymbolAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get vocalization => $composableBuilder(
      column: $table.vocalization, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $BoardAnnotationComposer get childBoardId {
    final $BoardAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childBoardId,
        referencedTable: $db.board,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $BoardAnnotationComposer(
              $db: $db,
              $table: $db.board,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> childSymbolRefs<T extends Object>(
      Expression<T> Function($ChildSymbolAnnotationComposer a) f) {
    final $ChildSymbolAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.childSymbol,
        getReferencedColumn: (t) => t.symbolId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $ChildSymbolAnnotationComposer(
              $db: $db,
              $table: $db.childSymbol,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $CommunicationSymbolTableManager extends RootTableManager<
    _$AppDatabase,
    CommunicationSymbol,
    CommunicationSymbolEntity,
    $CommunicationSymbolFilterComposer,
    $CommunicationSymbolOrderingComposer,
    $CommunicationSymbolAnnotationComposer,
    $CommunicationSymbolCreateCompanionBuilder,
    $CommunicationSymbolUpdateCompanionBuilder,
    (CommunicationSymbolEntity, $CommunicationSymbolReferences),
    CommunicationSymbolEntity,
    PrefetchHooks Function({bool childBoardId, bool childSymbolRefs})> {
  $CommunicationSymbolTableManager(_$AppDatabase db, CommunicationSymbol table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CommunicationSymbolFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CommunicationSymbolOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CommunicationSymbolAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<String?> vocalization = const Value.absent(),
            Value<int?> color = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<int?> createdAt = const Value.absent(),
            Value<int?> childBoardId = const Value.absent(),
          }) =>
              CommunicationSymbolCompanion(
            id: id,
            label: label,
            imagePath: imagePath,
            vocalization: vocalization,
            color: color,
            isDeleted: isDeleted,
            createdAt: createdAt,
            childBoardId: childBoardId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String label,
            required String imagePath,
            Value<String?> vocalization = const Value.absent(),
            Value<int?> color = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<int?> createdAt = const Value.absent(),
            Value<int?> childBoardId = const Value.absent(),
          }) =>
              CommunicationSymbolCompanion.insert(
            id: id,
            label: label,
            imagePath: imagePath,
            vocalization: vocalization,
            color: color,
            isDeleted: isDeleted,
            createdAt: createdAt,
            childBoardId: childBoardId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $CommunicationSymbolReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {childBoardId = false, childSymbolRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (childSymbolRefs) db.childSymbol],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (childBoardId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.childBoardId,
                    referencedTable:
                        $CommunicationSymbolReferences._childBoardIdTable(db),
                    referencedColumn: $CommunicationSymbolReferences
                        ._childBoardIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (childSymbolRefs)
                    await $_getPrefetchedData<CommunicationSymbolEntity,
                            CommunicationSymbol, ChildSymbolEntity>(
                        currentTable: table,
                        referencedTable: $CommunicationSymbolReferences
                            ._childSymbolRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $CommunicationSymbolReferences(db, table, p0)
                                .childSymbolRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.symbolId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $CommunicationSymbolProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    CommunicationSymbol,
    CommunicationSymbolEntity,
    $CommunicationSymbolFilterComposer,
    $CommunicationSymbolOrderingComposer,
    $CommunicationSymbolAnnotationComposer,
    $CommunicationSymbolCreateCompanionBuilder,
    $CommunicationSymbolUpdateCompanionBuilder,
    (CommunicationSymbolEntity, $CommunicationSymbolReferences),
    CommunicationSymbolEntity,
    PrefetchHooks Function({bool childBoardId, bool childSymbolRefs})>;
typedef $ChildSymbolCreateCompanionBuilder = ChildSymbolCompanion Function({
  required int position,
  required int boardId,
  required int symbolId,
  Value<int> rowid,
});
typedef $ChildSymbolUpdateCompanionBuilder = ChildSymbolCompanion Function({
  Value<int> position,
  Value<int> boardId,
  Value<int> symbolId,
  Value<int> rowid,
});

final class $ChildSymbolReferences
    extends BaseReferences<_$AppDatabase, ChildSymbol, ChildSymbolEntity> {
  $ChildSymbolReferences(super.$_db, super.$_table, super.$_typedResult);

  static Board _boardIdTable(_$AppDatabase db) => db.board
      .createAlias($_aliasNameGenerator(db.childSymbol.boardId, db.board.id));

  $BoardProcessedTableManager get boardId {
    final $_column = $_itemColumn<int>('board_id')!;

    final manager = $BoardTableManager($_db, $_db.board)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_boardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static CommunicationSymbol _symbolIdTable(_$AppDatabase db) =>
      db.communicationSymbol.createAlias($_aliasNameGenerator(
          db.childSymbol.symbolId, db.communicationSymbol.id));

  $CommunicationSymbolProcessedTableManager get symbolId {
    final $_column = $_itemColumn<int>('symbol_id')!;

    final manager =
        $CommunicationSymbolTableManager($_db, $_db.communicationSymbol)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_symbolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $ChildSymbolFilterComposer extends Composer<_$AppDatabase, ChildSymbol> {
  $ChildSymbolFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  $BoardFilterComposer get boardId {
    final $BoardFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.boardId,
        referencedTable: $db.board,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $BoardFilterComposer(
              $db: $db,
              $table: $db.board,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $CommunicationSymbolFilterComposer get symbolId {
    final $CommunicationSymbolFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.symbolId,
        referencedTable: $db.communicationSymbol,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CommunicationSymbolFilterComposer(
              $db: $db,
              $table: $db.communicationSymbol,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $ChildSymbolOrderingComposer
    extends Composer<_$AppDatabase, ChildSymbol> {
  $ChildSymbolOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  $BoardOrderingComposer get boardId {
    final $BoardOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.boardId,
        referencedTable: $db.board,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $BoardOrderingComposer(
              $db: $db,
              $table: $db.board,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $CommunicationSymbolOrderingComposer get symbolId {
    final $CommunicationSymbolOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.symbolId,
        referencedTable: $db.communicationSymbol,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CommunicationSymbolOrderingComposer(
              $db: $db,
              $table: $db.communicationSymbol,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $ChildSymbolAnnotationComposer
    extends Composer<_$AppDatabase, ChildSymbol> {
  $ChildSymbolAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $BoardAnnotationComposer get boardId {
    final $BoardAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.boardId,
        referencedTable: $db.board,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $BoardAnnotationComposer(
              $db: $db,
              $table: $db.board,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $CommunicationSymbolAnnotationComposer get symbolId {
    final $CommunicationSymbolAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.symbolId,
        referencedTable: $db.communicationSymbol,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CommunicationSymbolAnnotationComposer(
              $db: $db,
              $table: $db.communicationSymbol,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $ChildSymbolTableManager extends RootTableManager<
    _$AppDatabase,
    ChildSymbol,
    ChildSymbolEntity,
    $ChildSymbolFilterComposer,
    $ChildSymbolOrderingComposer,
    $ChildSymbolAnnotationComposer,
    $ChildSymbolCreateCompanionBuilder,
    $ChildSymbolUpdateCompanionBuilder,
    (ChildSymbolEntity, $ChildSymbolReferences),
    ChildSymbolEntity,
    PrefetchHooks Function({bool boardId, bool symbolId})> {
  $ChildSymbolTableManager(_$AppDatabase db, ChildSymbol table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ChildSymbolFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ChildSymbolOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ChildSymbolAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> position = const Value.absent(),
            Value<int> boardId = const Value.absent(),
            Value<int> symbolId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildSymbolCompanion(
            position: position,
            boardId: boardId,
            symbolId: symbolId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int position,
            required int boardId,
            required int symbolId,
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildSymbolCompanion.insert(
            position: position,
            boardId: boardId,
            symbolId: symbolId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $ChildSymbolReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({boardId = false, symbolId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (boardId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.boardId,
                    referencedTable: $ChildSymbolReferences._boardIdTable(db),
                    referencedColumn:
                        $ChildSymbolReferences._boardIdTable(db).id,
                  ) as T;
                }
                if (symbolId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.symbolId,
                    referencedTable: $ChildSymbolReferences._symbolIdTable(db),
                    referencedColumn:
                        $ChildSymbolReferences._symbolIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $ChildSymbolProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    ChildSymbol,
    ChildSymbolEntity,
    $ChildSymbolFilterComposer,
    $ChildSymbolOrderingComposer,
    $ChildSymbolAnnotationComposer,
    $ChildSymbolCreateCompanionBuilder,
    $ChildSymbolUpdateCompanionBuilder,
    (ChildSymbolEntity, $ChildSymbolReferences),
    ChildSymbolEntity,
    PrefetchHooks Function({bool boardId, bool symbolId})>;
typedef $SettingCreateCompanionBuilder = SettingCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $SettingUpdateCompanionBuilder = SettingCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $SettingFilterComposer extends Composer<_$AppDatabase, Setting> {
  $SettingFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $SettingOrderingComposer extends Composer<_$AppDatabase, Setting> {
  $SettingOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $SettingAnnotationComposer extends Composer<_$AppDatabase, Setting> {
  $SettingAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $SettingTableManager extends RootTableManager<
    _$AppDatabase,
    Setting,
    SettingEntity,
    $SettingFilterComposer,
    $SettingOrderingComposer,
    $SettingAnnotationComposer,
    $SettingCreateCompanionBuilder,
    $SettingUpdateCompanionBuilder,
    (SettingEntity, BaseReferences<_$AppDatabase, Setting, SettingEntity>),
    SettingEntity,
    PrefetchHooks Function()> {
  $SettingTableManager(_$AppDatabase db, Setting table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SettingFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SettingOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SettingAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $SettingProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    Setting,
    SettingEntity,
    $SettingFilterComposer,
    $SettingOrderingComposer,
    $SettingAnnotationComposer,
    $SettingCreateCompanionBuilder,
    $SettingUpdateCompanionBuilder,
    (SettingEntity, BaseReferences<_$AppDatabase, Setting, SettingEntity>),
    SettingEntity,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $BoardTableManager get board => $BoardTableManager(_db, _db.board);
  $CommunicationSymbolTableManager get communicationSymbol =>
      $CommunicationSymbolTableManager(_db, _db.communicationSymbol);
  $ChildSymbolTableManager get childSymbol =>
      $ChildSymbolTableManager(_db, _db.childSymbol);
  $SettingTableManager get setting => $SettingTableManager(_db, _db.setting);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dbHash() => r'dcb2f1339b0760c6f62ae57a770fbbb9815c19d2';

/// See also [db].
@ProviderFor(db)
final dbProvider = Provider<AppDatabase>.internal(
  db,
  name: r'dbProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dbHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DbRef = ProviderRef<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
