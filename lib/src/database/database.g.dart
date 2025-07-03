// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class BoardTb extends Table with TableInfo<BoardTb, BoardEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  BoardTb(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'board_tb';
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
  BoardTb createAlias(String alias) {
    return BoardTb(attachedDatabase, alias);
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

  BoardTbCompanion toCompanion(bool nullToAbsent) {
    return BoardTbCompanion(
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
  BoardEntity copyWithCompanion(BoardTbCompanion data) {
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

class BoardTbCompanion extends UpdateCompanion<BoardEntity> {
  final Value<int> id;
  final Value<int> crossAxisCount;
  final Value<String> name;
  const BoardTbCompanion({
    this.id = const Value.absent(),
    this.crossAxisCount = const Value.absent(),
    this.name = const Value.absent(),
  });
  BoardTbCompanion.insert({
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

  BoardTbCompanion copyWith(
      {Value<int>? id, Value<int>? crossAxisCount, Value<String>? name}) {
    return BoardTbCompanion(
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
    return (StringBuffer('BoardTbCompanion(')
          ..write('id: $id, ')
          ..write('crossAxisCount: $crossAxisCount, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class CommunicationSymbolTb extends Table
    with TableInfo<CommunicationSymbolTb, CommunicationSymbolEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CommunicationSymbolTb(this.attachedDatabase, [this._alias]);
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
      $customConstraints: 'NULL REFERENCES board_tb(id)');
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
  static const String $name = 'communication_symbol_tb';
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
  CommunicationSymbolTb createAlias(String alias) {
    return CommunicationSymbolTb(attachedDatabase, alias);
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

  CommunicationSymbolTbCompanion toCompanion(bool nullToAbsent) {
    return CommunicationSymbolTbCompanion(
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
      CommunicationSymbolTbCompanion data) {
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

class CommunicationSymbolTbCompanion
    extends UpdateCompanion<CommunicationSymbolEntity> {
  final Value<int> id;
  final Value<String> label;
  final Value<String> imagePath;
  final Value<String?> vocalization;
  final Value<int?> color;
  final Value<bool> isDeleted;
  final Value<int?> createdAt;
  final Value<int?> childBoardId;
  const CommunicationSymbolTbCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.vocalization = const Value.absent(),
    this.color = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.childBoardId = const Value.absent(),
  });
  CommunicationSymbolTbCompanion.insert({
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

  CommunicationSymbolTbCompanion copyWith(
      {Value<int>? id,
      Value<String>? label,
      Value<String>? imagePath,
      Value<String?>? vocalization,
      Value<int?>? color,
      Value<bool>? isDeleted,
      Value<int?>? createdAt,
      Value<int?>? childBoardId}) {
    return CommunicationSymbolTbCompanion(
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
    return (StringBuffer('CommunicationSymbolTbCompanion(')
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

class ChildSymbolTb extends Table
    with TableInfo<ChildSymbolTb, ChildSymbolEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChildSymbolTb(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _hiddenMeta = const VerificationMeta('hidden');
  late final GeneratedColumn<bool> hidden = GeneratedColumn<bool>(
      'hidden', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT FALSE',
      defaultValue: const CustomExpression('FALSE'));
  static const VerificationMeta _boardIdMeta =
      const VerificationMeta('boardId');
  late final GeneratedColumn<int> boardId = GeneratedColumn<int>(
      'board_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES board_tb(id)');
  static const VerificationMeta _symbolIdMeta =
      const VerificationMeta('symbolId');
  late final GeneratedColumn<int> symbolId = GeneratedColumn<int>(
      'symbol_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES communication_symbol_tb(id)');
  @override
  List<GeneratedColumn> get $columns => [position, hidden, boardId, symbolId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'child_symbol_tb';
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
    if (data.containsKey('hidden')) {
      context.handle(_hiddenMeta,
          hidden.isAcceptableOrUnknown(data['hidden']!, _hiddenMeta));
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
      hidden: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}hidden'])!,
      boardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}board_id'])!,
      symbolId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}symbol_id'])!,
    );
  }

  @override
  ChildSymbolTb createAlias(String alias) {
    return ChildSymbolTb(attachedDatabase, alias);
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
  final bool hidden;
  final int boardId;
  final int symbolId;
  const ChildSymbolEntity(
      {required this.position,
      required this.hidden,
      required this.boardId,
      required this.symbolId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['position'] = Variable<int>(position);
    map['hidden'] = Variable<bool>(hidden);
    map['board_id'] = Variable<int>(boardId);
    map['symbol_id'] = Variable<int>(symbolId);
    return map;
  }

  ChildSymbolTbCompanion toCompanion(bool nullToAbsent) {
    return ChildSymbolTbCompanion(
      position: Value(position),
      hidden: Value(hidden),
      boardId: Value(boardId),
      symbolId: Value(symbolId),
    );
  }

  factory ChildSymbolEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChildSymbolEntity(
      position: serializer.fromJson<int>(json['position']),
      hidden: serializer.fromJson<bool>(json['hidden']),
      boardId: serializer.fromJson<int>(json['board_id']),
      symbolId: serializer.fromJson<int>(json['symbol_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'position': serializer.toJson<int>(position),
      'hidden': serializer.toJson<bool>(hidden),
      'board_id': serializer.toJson<int>(boardId),
      'symbol_id': serializer.toJson<int>(symbolId),
    };
  }

  ChildSymbolEntity copyWith(
          {int? position, bool? hidden, int? boardId, int? symbolId}) =>
      ChildSymbolEntity(
        position: position ?? this.position,
        hidden: hidden ?? this.hidden,
        boardId: boardId ?? this.boardId,
        symbolId: symbolId ?? this.symbolId,
      );
  ChildSymbolEntity copyWithCompanion(ChildSymbolTbCompanion data) {
    return ChildSymbolEntity(
      position: data.position.present ? data.position.value : this.position,
      hidden: data.hidden.present ? data.hidden.value : this.hidden,
      boardId: data.boardId.present ? data.boardId.value : this.boardId,
      symbolId: data.symbolId.present ? data.symbolId.value : this.symbolId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChildSymbolEntity(')
          ..write('position: $position, ')
          ..write('hidden: $hidden, ')
          ..write('boardId: $boardId, ')
          ..write('symbolId: $symbolId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(position, hidden, boardId, symbolId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChildSymbolEntity &&
          other.position == this.position &&
          other.hidden == this.hidden &&
          other.boardId == this.boardId &&
          other.symbolId == this.symbolId);
}

class ChildSymbolTbCompanion extends UpdateCompanion<ChildSymbolEntity> {
  final Value<int> position;
  final Value<bool> hidden;
  final Value<int> boardId;
  final Value<int> symbolId;
  final Value<int> rowid;
  const ChildSymbolTbCompanion({
    this.position = const Value.absent(),
    this.hidden = const Value.absent(),
    this.boardId = const Value.absent(),
    this.symbolId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChildSymbolTbCompanion.insert({
    required int position,
    this.hidden = const Value.absent(),
    required int boardId,
    required int symbolId,
    this.rowid = const Value.absent(),
  })  : position = Value(position),
        boardId = Value(boardId),
        symbolId = Value(symbolId);
  static Insertable<ChildSymbolEntity> custom({
    Expression<int>? position,
    Expression<bool>? hidden,
    Expression<int>? boardId,
    Expression<int>? symbolId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (position != null) 'position': position,
      if (hidden != null) 'hidden': hidden,
      if (boardId != null) 'board_id': boardId,
      if (symbolId != null) 'symbol_id': symbolId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChildSymbolTbCompanion copyWith(
      {Value<int>? position,
      Value<bool>? hidden,
      Value<int>? boardId,
      Value<int>? symbolId,
      Value<int>? rowid}) {
    return ChildSymbolTbCompanion(
      position: position ?? this.position,
      hidden: hidden ?? this.hidden,
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
    if (hidden.present) {
      map['hidden'] = Variable<bool>(hidden.value);
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
    return (StringBuffer('ChildSymbolTbCompanion(')
          ..write('position: $position, ')
          ..write('hidden: $hidden, ')
          ..write('boardId: $boardId, ')
          ..write('symbolId: $symbolId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class SettingTb extends Table with TableInfo<SettingTb, SettingEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SettingTb(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'setting_tb';
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
  SettingTb createAlias(String alias) {
    return SettingTb(attachedDatabase, alias);
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

  SettingTbCompanion toCompanion(bool nullToAbsent) {
    return SettingTbCompanion(
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
  SettingEntity copyWithCompanion(SettingTbCompanion data) {
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

class SettingTbCompanion extends UpdateCompanion<SettingEntity> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingTbCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingTbCompanion.insert({
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

  SettingTbCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return SettingTbCompanion(
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
    return (StringBuffer('SettingTbCompanion(')
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
  late final BoardTb boardTb = BoardTb(this);
  late final CommunicationSymbolTb communicationSymbolTb =
      CommunicationSymbolTb(this);
  late final ChildSymbolTb childSymbolTb = ChildSymbolTb(this);
  late final SettingTb settingTb = SettingTb(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [boardTb, communicationSymbolTb, childSymbolTb, settingTb];
}

typedef $BoardTbCreateCompanionBuilder = BoardTbCompanion Function({
  Value<int> id,
  Value<int> crossAxisCount,
  required String name,
});
typedef $BoardTbUpdateCompanionBuilder = BoardTbCompanion Function({
  Value<int> id,
  Value<int> crossAxisCount,
  Value<String> name,
});

final class $BoardTbReferences
    extends BaseReferences<_$AppDatabase, BoardTb, BoardEntity> {
  $BoardTbReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<CommunicationSymbolTb,
      List<CommunicationSymbolEntity>> _communicationSymbolTbRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.communicationSymbolTb,
          aliasName: $_aliasNameGenerator(
              db.boardTb.id, db.communicationSymbolTb.childBoardId));

  $CommunicationSymbolTbProcessedTableManager get communicationSymbolTbRefs {
    final manager = $CommunicationSymbolTbTableManager(
            $_db, $_db.communicationSymbolTb)
        .filter((f) => f.childBoardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_communicationSymbolTbRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<ChildSymbolTb, List<ChildSymbolEntity>>
      _childSymbolTbRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.childSymbolTb,
              aliasName: $_aliasNameGenerator(
                  db.boardTb.id, db.childSymbolTb.boardId));

  $ChildSymbolTbProcessedTableManager get childSymbolTbRefs {
    final manager = $ChildSymbolTbTableManager($_db, $_db.childSymbolTb)
        .filter((f) => f.boardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_childSymbolTbRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $BoardTbFilterComposer extends Composer<_$AppDatabase, BoardTb> {
  $BoardTbFilterComposer({
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

  Expression<bool> communicationSymbolTbRefs(
      Expression<bool> Function($CommunicationSymbolTbFilterComposer f) f) {
    final $CommunicationSymbolTbFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.communicationSymbolTb,
        getReferencedColumn: (t) => t.childBoardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CommunicationSymbolTbFilterComposer(
              $db: $db,
              $table: $db.communicationSymbolTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> childSymbolTbRefs(
      Expression<bool> Function($ChildSymbolTbFilterComposer f) f) {
    final $ChildSymbolTbFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.childSymbolTb,
        getReferencedColumn: (t) => t.boardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $ChildSymbolTbFilterComposer(
              $db: $db,
              $table: $db.childSymbolTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $BoardTbOrderingComposer extends Composer<_$AppDatabase, BoardTb> {
  $BoardTbOrderingComposer({
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

class $BoardTbAnnotationComposer extends Composer<_$AppDatabase, BoardTb> {
  $BoardTbAnnotationComposer({
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

  Expression<T> communicationSymbolTbRefs<T extends Object>(
      Expression<T> Function($CommunicationSymbolTbAnnotationComposer a) f) {
    final $CommunicationSymbolTbAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.communicationSymbolTb,
        getReferencedColumn: (t) => t.childBoardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CommunicationSymbolTbAnnotationComposer(
              $db: $db,
              $table: $db.communicationSymbolTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> childSymbolTbRefs<T extends Object>(
      Expression<T> Function($ChildSymbolTbAnnotationComposer a) f) {
    final $ChildSymbolTbAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.childSymbolTb,
        getReferencedColumn: (t) => t.boardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $ChildSymbolTbAnnotationComposer(
              $db: $db,
              $table: $db.childSymbolTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $BoardTbTableManager extends RootTableManager<
    _$AppDatabase,
    BoardTb,
    BoardEntity,
    $BoardTbFilterComposer,
    $BoardTbOrderingComposer,
    $BoardTbAnnotationComposer,
    $BoardTbCreateCompanionBuilder,
    $BoardTbUpdateCompanionBuilder,
    (BoardEntity, $BoardTbReferences),
    BoardEntity,
    PrefetchHooks Function(
        {bool communicationSymbolTbRefs, bool childSymbolTbRefs})> {
  $BoardTbTableManager(_$AppDatabase db, BoardTb table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $BoardTbFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $BoardTbOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $BoardTbAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> crossAxisCount = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              BoardTbCompanion(
            id: id,
            crossAxisCount: crossAxisCount,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> crossAxisCount = const Value.absent(),
            required String name,
          }) =>
              BoardTbCompanion.insert(
            id: id,
            crossAxisCount: crossAxisCount,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map(
                  (e) => (e.readTable(table), $BoardTbReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {communicationSymbolTbRefs = false, childSymbolTbRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (communicationSymbolTbRefs) db.communicationSymbolTb,
                if (childSymbolTbRefs) db.childSymbolTb
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (communicationSymbolTbRefs)
                    await $_getPrefetchedData<BoardEntity, BoardTb,
                            CommunicationSymbolEntity>(
                        currentTable: table,
                        referencedTable: $BoardTbReferences
                            ._communicationSymbolTbRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $BoardTbReferences(db, table, p0)
                                .communicationSymbolTbRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.childBoardId == item.id),
                        typedResults: items),
                  if (childSymbolTbRefs)
                    await $_getPrefetchedData<BoardEntity, BoardTb,
                            ChildSymbolEntity>(
                        currentTable: table,
                        referencedTable:
                            $BoardTbReferences._childSymbolTbRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $BoardTbReferences(db, table, p0).childSymbolTbRefs,
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

typedef $BoardTbProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    BoardTb,
    BoardEntity,
    $BoardTbFilterComposer,
    $BoardTbOrderingComposer,
    $BoardTbAnnotationComposer,
    $BoardTbCreateCompanionBuilder,
    $BoardTbUpdateCompanionBuilder,
    (BoardEntity, $BoardTbReferences),
    BoardEntity,
    PrefetchHooks Function(
        {bool communicationSymbolTbRefs, bool childSymbolTbRefs})>;
typedef $CommunicationSymbolTbCreateCompanionBuilder
    = CommunicationSymbolTbCompanion Function({
  Value<int> id,
  required String label,
  required String imagePath,
  Value<String?> vocalization,
  Value<int?> color,
  Value<bool> isDeleted,
  Value<int?> createdAt,
  Value<int?> childBoardId,
});
typedef $CommunicationSymbolTbUpdateCompanionBuilder
    = CommunicationSymbolTbCompanion Function({
  Value<int> id,
  Value<String> label,
  Value<String> imagePath,
  Value<String?> vocalization,
  Value<int?> color,
  Value<bool> isDeleted,
  Value<int?> createdAt,
  Value<int?> childBoardId,
});

final class $CommunicationSymbolTbReferences extends BaseReferences<
    _$AppDatabase, CommunicationSymbolTb, CommunicationSymbolEntity> {
  $CommunicationSymbolTbReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static BoardTb _childBoardIdTable(_$AppDatabase db) =>
      db.boardTb.createAlias($_aliasNameGenerator(
          db.communicationSymbolTb.childBoardId, db.boardTb.id));

  $BoardTbProcessedTableManager? get childBoardId {
    final $_column = $_itemColumn<int>('child_board_id');
    if ($_column == null) return null;
    final manager = $BoardTbTableManager($_db, $_db.boardTb)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_childBoardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<ChildSymbolTb, List<ChildSymbolEntity>>
      _childSymbolTbRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.childSymbolTb,
              aliasName: $_aliasNameGenerator(
                  db.communicationSymbolTb.id, db.childSymbolTb.symbolId));

  $ChildSymbolTbProcessedTableManager get childSymbolTbRefs {
    final manager = $ChildSymbolTbTableManager($_db, $_db.childSymbolTb)
        .filter((f) => f.symbolId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_childSymbolTbRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $CommunicationSymbolTbFilterComposer
    extends Composer<_$AppDatabase, CommunicationSymbolTb> {
  $CommunicationSymbolTbFilterComposer({
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

  $BoardTbFilterComposer get childBoardId {
    final $BoardTbFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childBoardId,
        referencedTable: $db.boardTb,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $BoardTbFilterComposer(
              $db: $db,
              $table: $db.boardTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> childSymbolTbRefs(
      Expression<bool> Function($ChildSymbolTbFilterComposer f) f) {
    final $ChildSymbolTbFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.childSymbolTb,
        getReferencedColumn: (t) => t.symbolId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $ChildSymbolTbFilterComposer(
              $db: $db,
              $table: $db.childSymbolTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $CommunicationSymbolTbOrderingComposer
    extends Composer<_$AppDatabase, CommunicationSymbolTb> {
  $CommunicationSymbolTbOrderingComposer({
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

  $BoardTbOrderingComposer get childBoardId {
    final $BoardTbOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childBoardId,
        referencedTable: $db.boardTb,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $BoardTbOrderingComposer(
              $db: $db,
              $table: $db.boardTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $CommunicationSymbolTbAnnotationComposer
    extends Composer<_$AppDatabase, CommunicationSymbolTb> {
  $CommunicationSymbolTbAnnotationComposer({
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

  $BoardTbAnnotationComposer get childBoardId {
    final $BoardTbAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childBoardId,
        referencedTable: $db.boardTb,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $BoardTbAnnotationComposer(
              $db: $db,
              $table: $db.boardTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> childSymbolTbRefs<T extends Object>(
      Expression<T> Function($ChildSymbolTbAnnotationComposer a) f) {
    final $ChildSymbolTbAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.childSymbolTb,
        getReferencedColumn: (t) => t.symbolId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $ChildSymbolTbAnnotationComposer(
              $db: $db,
              $table: $db.childSymbolTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $CommunicationSymbolTbTableManager extends RootTableManager<
    _$AppDatabase,
    CommunicationSymbolTb,
    CommunicationSymbolEntity,
    $CommunicationSymbolTbFilterComposer,
    $CommunicationSymbolTbOrderingComposer,
    $CommunicationSymbolTbAnnotationComposer,
    $CommunicationSymbolTbCreateCompanionBuilder,
    $CommunicationSymbolTbUpdateCompanionBuilder,
    (CommunicationSymbolEntity, $CommunicationSymbolTbReferences),
    CommunicationSymbolEntity,
    PrefetchHooks Function({bool childBoardId, bool childSymbolTbRefs})> {
  $CommunicationSymbolTbTableManager(
      _$AppDatabase db, CommunicationSymbolTb table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CommunicationSymbolTbFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CommunicationSymbolTbOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CommunicationSymbolTbAnnotationComposer($db: db, $table: table),
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
              CommunicationSymbolTbCompanion(
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
              CommunicationSymbolTbCompanion.insert(
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
                    $CommunicationSymbolTbReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {childBoardId = false, childSymbolTbRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (childSymbolTbRefs) db.childSymbolTb
              ],
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
                        $CommunicationSymbolTbReferences._childBoardIdTable(db),
                    referencedColumn: $CommunicationSymbolTbReferences
                        ._childBoardIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (childSymbolTbRefs)
                    await $_getPrefetchedData<CommunicationSymbolEntity,
                            CommunicationSymbolTb, ChildSymbolEntity>(
                        currentTable: table,
                        referencedTable: $CommunicationSymbolTbReferences
                            ._childSymbolTbRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $CommunicationSymbolTbReferences(db, table, p0)
                                .childSymbolTbRefs,
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

typedef $CommunicationSymbolTbProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    CommunicationSymbolTb,
    CommunicationSymbolEntity,
    $CommunicationSymbolTbFilterComposer,
    $CommunicationSymbolTbOrderingComposer,
    $CommunicationSymbolTbAnnotationComposer,
    $CommunicationSymbolTbCreateCompanionBuilder,
    $CommunicationSymbolTbUpdateCompanionBuilder,
    (CommunicationSymbolEntity, $CommunicationSymbolTbReferences),
    CommunicationSymbolEntity,
    PrefetchHooks Function({bool childBoardId, bool childSymbolTbRefs})>;
typedef $ChildSymbolTbCreateCompanionBuilder = ChildSymbolTbCompanion Function({
  required int position,
  Value<bool> hidden,
  required int boardId,
  required int symbolId,
  Value<int> rowid,
});
typedef $ChildSymbolTbUpdateCompanionBuilder = ChildSymbolTbCompanion Function({
  Value<int> position,
  Value<bool> hidden,
  Value<int> boardId,
  Value<int> symbolId,
  Value<int> rowid,
});

final class $ChildSymbolTbReferences
    extends BaseReferences<_$AppDatabase, ChildSymbolTb, ChildSymbolEntity> {
  $ChildSymbolTbReferences(super.$_db, super.$_table, super.$_typedResult);

  static BoardTb _boardIdTable(_$AppDatabase db) => db.boardTb.createAlias(
      $_aliasNameGenerator(db.childSymbolTb.boardId, db.boardTb.id));

  $BoardTbProcessedTableManager get boardId {
    final $_column = $_itemColumn<int>('board_id')!;

    final manager = $BoardTbTableManager($_db, $_db.boardTb)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_boardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static CommunicationSymbolTb _symbolIdTable(_$AppDatabase db) =>
      db.communicationSymbolTb.createAlias($_aliasNameGenerator(
          db.childSymbolTb.symbolId, db.communicationSymbolTb.id));

  $CommunicationSymbolTbProcessedTableManager get symbolId {
    final $_column = $_itemColumn<int>('symbol_id')!;

    final manager =
        $CommunicationSymbolTbTableManager($_db, $_db.communicationSymbolTb)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_symbolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $ChildSymbolTbFilterComposer
    extends Composer<_$AppDatabase, ChildSymbolTb> {
  $ChildSymbolTbFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hidden => $composableBuilder(
      column: $table.hidden, builder: (column) => ColumnFilters(column));

  $BoardTbFilterComposer get boardId {
    final $BoardTbFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.boardId,
        referencedTable: $db.boardTb,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $BoardTbFilterComposer(
              $db: $db,
              $table: $db.boardTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $CommunicationSymbolTbFilterComposer get symbolId {
    final $CommunicationSymbolTbFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.symbolId,
        referencedTable: $db.communicationSymbolTb,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CommunicationSymbolTbFilterComposer(
              $db: $db,
              $table: $db.communicationSymbolTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $ChildSymbolTbOrderingComposer
    extends Composer<_$AppDatabase, ChildSymbolTb> {
  $ChildSymbolTbOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hidden => $composableBuilder(
      column: $table.hidden, builder: (column) => ColumnOrderings(column));

  $BoardTbOrderingComposer get boardId {
    final $BoardTbOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.boardId,
        referencedTable: $db.boardTb,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $BoardTbOrderingComposer(
              $db: $db,
              $table: $db.boardTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $CommunicationSymbolTbOrderingComposer get symbolId {
    final $CommunicationSymbolTbOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.symbolId,
        referencedTable: $db.communicationSymbolTb,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CommunicationSymbolTbOrderingComposer(
              $db: $db,
              $table: $db.communicationSymbolTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $ChildSymbolTbAnnotationComposer
    extends Composer<_$AppDatabase, ChildSymbolTb> {
  $ChildSymbolTbAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<bool> get hidden =>
      $composableBuilder(column: $table.hidden, builder: (column) => column);

  $BoardTbAnnotationComposer get boardId {
    final $BoardTbAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.boardId,
        referencedTable: $db.boardTb,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $BoardTbAnnotationComposer(
              $db: $db,
              $table: $db.boardTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $CommunicationSymbolTbAnnotationComposer get symbolId {
    final $CommunicationSymbolTbAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.symbolId,
        referencedTable: $db.communicationSymbolTb,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CommunicationSymbolTbAnnotationComposer(
              $db: $db,
              $table: $db.communicationSymbolTb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $ChildSymbolTbTableManager extends RootTableManager<
    _$AppDatabase,
    ChildSymbolTb,
    ChildSymbolEntity,
    $ChildSymbolTbFilterComposer,
    $ChildSymbolTbOrderingComposer,
    $ChildSymbolTbAnnotationComposer,
    $ChildSymbolTbCreateCompanionBuilder,
    $ChildSymbolTbUpdateCompanionBuilder,
    (ChildSymbolEntity, $ChildSymbolTbReferences),
    ChildSymbolEntity,
    PrefetchHooks Function({bool boardId, bool symbolId})> {
  $ChildSymbolTbTableManager(_$AppDatabase db, ChildSymbolTb table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ChildSymbolTbFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ChildSymbolTbOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ChildSymbolTbAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> position = const Value.absent(),
            Value<bool> hidden = const Value.absent(),
            Value<int> boardId = const Value.absent(),
            Value<int> symbolId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildSymbolTbCompanion(
            position: position,
            hidden: hidden,
            boardId: boardId,
            symbolId: symbolId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int position,
            Value<bool> hidden = const Value.absent(),
            required int boardId,
            required int symbolId,
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildSymbolTbCompanion.insert(
            position: position,
            hidden: hidden,
            boardId: boardId,
            symbolId: symbolId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $ChildSymbolTbReferences(db, table, e)))
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
                    referencedTable: $ChildSymbolTbReferences._boardIdTable(db),
                    referencedColumn:
                        $ChildSymbolTbReferences._boardIdTable(db).id,
                  ) as T;
                }
                if (symbolId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.symbolId,
                    referencedTable:
                        $ChildSymbolTbReferences._symbolIdTable(db),
                    referencedColumn:
                        $ChildSymbolTbReferences._symbolIdTable(db).id,
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

typedef $ChildSymbolTbProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    ChildSymbolTb,
    ChildSymbolEntity,
    $ChildSymbolTbFilterComposer,
    $ChildSymbolTbOrderingComposer,
    $ChildSymbolTbAnnotationComposer,
    $ChildSymbolTbCreateCompanionBuilder,
    $ChildSymbolTbUpdateCompanionBuilder,
    (ChildSymbolEntity, $ChildSymbolTbReferences),
    ChildSymbolEntity,
    PrefetchHooks Function({bool boardId, bool symbolId})>;
typedef $SettingTbCreateCompanionBuilder = SettingTbCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $SettingTbUpdateCompanionBuilder = SettingTbCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $SettingTbFilterComposer extends Composer<_$AppDatabase, SettingTb> {
  $SettingTbFilterComposer({
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

class $SettingTbOrderingComposer extends Composer<_$AppDatabase, SettingTb> {
  $SettingTbOrderingComposer({
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

class $SettingTbAnnotationComposer extends Composer<_$AppDatabase, SettingTb> {
  $SettingTbAnnotationComposer({
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

class $SettingTbTableManager extends RootTableManager<
    _$AppDatabase,
    SettingTb,
    SettingEntity,
    $SettingTbFilterComposer,
    $SettingTbOrderingComposer,
    $SettingTbAnnotationComposer,
    $SettingTbCreateCompanionBuilder,
    $SettingTbUpdateCompanionBuilder,
    (SettingEntity, BaseReferences<_$AppDatabase, SettingTb, SettingEntity>),
    SettingEntity,
    PrefetchHooks Function()> {
  $SettingTbTableManager(_$AppDatabase db, SettingTb table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SettingTbFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SettingTbOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SettingTbAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingTbCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingTbCompanion.insert(
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

typedef $SettingTbProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    SettingTb,
    SettingEntity,
    $SettingTbFilterComposer,
    $SettingTbOrderingComposer,
    $SettingTbAnnotationComposer,
    $SettingTbCreateCompanionBuilder,
    $SettingTbUpdateCompanionBuilder,
    (SettingEntity, BaseReferences<_$AppDatabase, SettingTb, SettingEntity>),
    SettingEntity,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $BoardTbTableManager get boardTb => $BoardTbTableManager(_db, _db.boardTb);
  $CommunicationSymbolTbTableManager get communicationSymbolTb =>
      $CommunicationSymbolTbTableManager(_db, _db.communicationSymbolTb);
  $ChildSymbolTbTableManager get childSymbolTb =>
      $ChildSymbolTbTableManager(_db, _db.childSymbolTb);
  $SettingTbTableManager get settingTb =>
      $SettingTbTableManager(_db, _db.settingTb);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dbHash() => r'84524a1c7c67da12b2df558624eb0bfddabd445f';

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
