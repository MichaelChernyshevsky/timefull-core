// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPackagesCollection on Isar {
  IsarCollection<Packages> get packages => this.collection();
}

const PackagesSchema = CollectionSchema(
  name: r'Packages',
  id: 4613324276804828692,
  properties: {
    r'economy': PropertySchema(
      id: 0,
      name: r'economy',
      type: IsarType.bool,
    ),
    r'note': PropertySchema(
      id: 1,
      name: r'note',
      type: IsarType.bool,
    ),
    r'task': PropertySchema(
      id: 2,
      name: r'task',
      type: IsarType.bool,
    ),
    r'timer': PropertySchema(
      id: 3,
      name: r'timer',
      type: IsarType.bool,
    ),
    r'userId': PropertySchema(
      id: 4,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _packagesEstimateSize,
  serialize: _packagesSerialize,
  deserialize: _packagesDeserialize,
  deserializeProp: _packagesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _packagesGetId,
  getLinks: _packagesGetLinks,
  attach: _packagesAttach,
  version: '3.1.0+1',
);

int _packagesEstimateSize(
  Packages object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _packagesSerialize(
  Packages object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.economy);
  writer.writeBool(offsets[1], object.note);
  writer.writeBool(offsets[2], object.task);
  writer.writeBool(offsets[3], object.timer);
  writer.writeString(offsets[4], object.userId);
}

Packages _packagesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Packages(
    economy: reader.readBool(offsets[0]),
    id: id,
    note: reader.readBool(offsets[1]),
    task: reader.readBool(offsets[2]),
    timer: reader.readBool(offsets[3]),
    userId: reader.readString(offsets[4]),
  );
  return object;
}

P _packagesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _packagesGetId(Packages object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _packagesGetLinks(Packages object) {
  return [];
}

void _packagesAttach(IsarCollection<dynamic> col, Id id, Packages object) {
  object.id = id;
}

extension PackagesQueryWhereSort on QueryBuilder<Packages, Packages, QWhere> {
  QueryBuilder<Packages, Packages, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PackagesQueryWhere on QueryBuilder<Packages, Packages, QWhereClause> {
  QueryBuilder<Packages, Packages, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Packages, Packages, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Packages, Packages, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Packages, Packages, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PackagesQueryFilter
    on QueryBuilder<Packages, Packages, QFilterCondition> {
  QueryBuilder<Packages, Packages, QAfterFilterCondition> economyEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'economy',
        value: value,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> noteEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> taskEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'task',
        value: value,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> timerEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timer',
        value: value,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> userIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<Packages, Packages, QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension PackagesQueryObject
    on QueryBuilder<Packages, Packages, QFilterCondition> {}

extension PackagesQueryLinks
    on QueryBuilder<Packages, Packages, QFilterCondition> {}

extension PackagesQuerySortBy on QueryBuilder<Packages, Packages, QSortBy> {
  QueryBuilder<Packages, Packages, QAfterSortBy> sortByEconomy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'economy', Sort.asc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> sortByEconomyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'economy', Sort.desc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> sortByTask() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'task', Sort.asc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> sortByTaskDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'task', Sort.desc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> sortByTimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timer', Sort.asc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> sortByTimerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timer', Sort.desc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension PackagesQuerySortThenBy
    on QueryBuilder<Packages, Packages, QSortThenBy> {
  QueryBuilder<Packages, Packages, QAfterSortBy> thenByEconomy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'economy', Sort.asc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> thenByEconomyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'economy', Sort.desc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> thenByTask() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'task', Sort.asc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> thenByTaskDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'task', Sort.desc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> thenByTimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timer', Sort.asc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> thenByTimerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timer', Sort.desc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<Packages, Packages, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension PackagesQueryWhereDistinct
    on QueryBuilder<Packages, Packages, QDistinct> {
  QueryBuilder<Packages, Packages, QDistinct> distinctByEconomy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'economy');
    });
  }

  QueryBuilder<Packages, Packages, QDistinct> distinctByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note');
    });
  }

  QueryBuilder<Packages, Packages, QDistinct> distinctByTask() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'task');
    });
  }

  QueryBuilder<Packages, Packages, QDistinct> distinctByTimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timer');
    });
  }

  QueryBuilder<Packages, Packages, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension PackagesQueryProperty
    on QueryBuilder<Packages, Packages, QQueryProperty> {
  QueryBuilder<Packages, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Packages, bool, QQueryOperations> economyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'economy');
    });
  }

  QueryBuilder<Packages, bool, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<Packages, bool, QQueryOperations> taskProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'task');
    });
  }

  QueryBuilder<Packages, bool, QQueryOperations> timerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timer');
    });
  }

  QueryBuilder<Packages, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
