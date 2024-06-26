// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimerModelCollection on Isar {
  IsarCollection<TimerModel> get timerModels => this.collection();
}

const TimerModelSchema = CollectionSchema(
  name: r'TimerModel',
  id: 1326376837060457485,
  properties: {
    r'relax': PropertySchema(
      id: 0,
      name: r'relax',
      type: IsarType.long,
    ),
    r'relaxSave': PropertySchema(
      id: 1,
      name: r'relaxSave',
      type: IsarType.long,
    ),
    r'timeRelaxSave': PropertySchema(
      id: 2,
      name: r'timeRelaxSave',
      type: IsarType.long,
    ),
    r'timeStat': PropertySchema(
      id: 3,
      name: r'timeStat',
      type: IsarType.long,
    ),
    r'timeWork': PropertySchema(
      id: 4,
      name: r'timeWork',
      type: IsarType.long,
    ),
    r'timeWorkSave': PropertySchema(
      id: 5,
      name: r'timeWorkSave',
      type: IsarType.long,
    ),
    r'userId': PropertySchema(
      id: 6,
      name: r'userId',
      type: IsarType.string,
    ),
    r'work': PropertySchema(
      id: 7,
      name: r'work',
      type: IsarType.long,
    ),
    r'workSave': PropertySchema(
      id: 8,
      name: r'workSave',
      type: IsarType.long,
    )
  },
  estimateSize: _timerModelEstimateSize,
  serialize: _timerModelSerialize,
  deserialize: _timerModelDeserialize,
  deserializeProp: _timerModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _timerModelGetId,
  getLinks: _timerModelGetLinks,
  attach: _timerModelAttach,
  version: '3.1.0+1',
);

int _timerModelEstimateSize(
  TimerModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _timerModelSerialize(
  TimerModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.relax);
  writer.writeLong(offsets[1], object.relaxSave);
  writer.writeLong(offsets[2], object.timeRelaxSave);
  writer.writeLong(offsets[3], object.timeRelax);
  writer.writeLong(offsets[4], object.timeWork);
  writer.writeLong(offsets[5], object.timeWorkSave);
  writer.writeString(offsets[6], object.userId);
  writer.writeLong(offsets[7], object.work);
  writer.writeLong(offsets[8], object.workSave);
}

TimerModel _timerModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimerModel(
    id: id,
    relax: reader.readLong(offsets[0]),
    timeRelax: reader.readLong(offsets[3]),
    timeWork: reader.readLong(offsets[4]),
    userId: reader.readString(offsets[6]),
    work: reader.readLong(offsets[7]),
  );
  object.relaxSave = reader.readLong(offsets[1]);
  object.timeRelaxSave = reader.readLong(offsets[2]);
  object.timeWorkSave = reader.readLong(offsets[5]);
  object.workSave = reader.readLong(offsets[8]);
  return object;
}

P _timerModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _timerModelGetId(TimerModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _timerModelGetLinks(TimerModel object) {
  return [];
}

void _timerModelAttach(IsarCollection<dynamic> col, Id id, TimerModel object) {}

extension TimerModelQueryWhereSort on QueryBuilder<TimerModel, TimerModel, QWhere> {
  QueryBuilder<TimerModel, TimerModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TimerModelQueryWhere on QueryBuilder<TimerModel, TimerModel, QWhereClause> {
  QueryBuilder<TimerModel, TimerModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<TimerModel, TimerModel, QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterWhereClause> idBetween(
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

extension TimerModelQueryFilter on QueryBuilder<TimerModel, TimerModel, QFilterCondition> {
  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> relaxEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relax',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> relaxGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'relax',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> relaxLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'relax',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> relaxBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'relax',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> relaxSaveEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relaxSave',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> relaxSaveGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'relaxSave',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> relaxSaveLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'relaxSave',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> relaxSaveBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'relaxSave',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeRelaxSaveEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeRelaxSave',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeRelaxSaveGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeRelaxSave',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeRelaxSaveLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeRelaxSave',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeRelaxSaveBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeRelaxSave',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeStatEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeStat',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeStatGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeStat',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeStatLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeStat',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeStatBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeStat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeWorkEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeWork',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeWorkGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeWork',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeWorkLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeWork',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeWorkBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeWork',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeWorkSaveEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeWorkSave',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeWorkSaveGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeWorkSave',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeWorkSaveLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeWorkSave',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> timeWorkSaveBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeWorkSave',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> userIdEqualTo(
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

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> userIdGreaterThan(
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

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> userIdLessThan(
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

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> userIdBetween(
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

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> userIdStartsWith(
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

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> userIdEndsWith(
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

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> workEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'work',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> workGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'work',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> workLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'work',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> workBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'work',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> workSaveEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workSave',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> workSaveGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workSave',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> workSaveLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workSave',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterFilterCondition> workSaveBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workSave',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimerModelQueryObject on QueryBuilder<TimerModel, TimerModel, QFilterCondition> {}

extension TimerModelQueryLinks on QueryBuilder<TimerModel, TimerModel, QFilterCondition> {}

extension TimerModelQuerySortBy on QueryBuilder<TimerModel, TimerModel, QSortBy> {
  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByRelax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relax', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByRelaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relax', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByRelaxSave() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relaxSave', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByRelaxSaveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relaxSave', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByTimeRelaxSave() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeRelaxSave', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByTimeRelaxSaveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeRelaxSave', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByTimeStat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStat', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByTimeStatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStat', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByTimeWork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeWork', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByTimeWorkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeWork', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByTimeWorkSave() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeWorkSave', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByTimeWorkSaveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeWorkSave', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByWork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'work', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByWorkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'work', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByWorkSave() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workSave', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> sortByWorkSaveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workSave', Sort.desc);
    });
  }
}

extension TimerModelQuerySortThenBy on QueryBuilder<TimerModel, TimerModel, QSortThenBy> {
  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByRelax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relax', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByRelaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relax', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByRelaxSave() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relaxSave', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByRelaxSaveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relaxSave', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByTimeRelaxSave() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeRelaxSave', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByTimeRelaxSaveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeRelaxSave', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByTimeStat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStat', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByTimeStatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStat', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByTimeWork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeWork', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByTimeWorkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeWork', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByTimeWorkSave() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeWorkSave', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByTimeWorkSaveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeWorkSave', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByWork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'work', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByWorkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'work', Sort.desc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByWorkSave() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workSave', Sort.asc);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QAfterSortBy> thenByWorkSaveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workSave', Sort.desc);
    });
  }
}

extension TimerModelQueryWhereDistinct on QueryBuilder<TimerModel, TimerModel, QDistinct> {
  QueryBuilder<TimerModel, TimerModel, QDistinct> distinctByRelax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relax');
    });
  }

  QueryBuilder<TimerModel, TimerModel, QDistinct> distinctByRelaxSave() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relaxSave');
    });
  }

  QueryBuilder<TimerModel, TimerModel, QDistinct> distinctByTimeRelaxSave() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeRelaxSave');
    });
  }

  QueryBuilder<TimerModel, TimerModel, QDistinct> distinctByTimeStat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeStat');
    });
  }

  QueryBuilder<TimerModel, TimerModel, QDistinct> distinctByTimeWork() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeWork');
    });
  }

  QueryBuilder<TimerModel, TimerModel, QDistinct> distinctByTimeWorkSave() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeWorkSave');
    });
  }

  QueryBuilder<TimerModel, TimerModel, QDistinct> distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimerModel, TimerModel, QDistinct> distinctByWork() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'work');
    });
  }

  QueryBuilder<TimerModel, TimerModel, QDistinct> distinctByWorkSave() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workSave');
    });
  }
}

extension TimerModelQueryProperty on QueryBuilder<TimerModel, TimerModel, QQueryProperty> {
  QueryBuilder<TimerModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TimerModel, int, QQueryOperations> relaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relax');
    });
  }

  QueryBuilder<TimerModel, int, QQueryOperations> relaxSaveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relaxSave');
    });
  }

  QueryBuilder<TimerModel, int, QQueryOperations> timeRelaxSaveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeRelaxSave');
    });
  }

  QueryBuilder<TimerModel, int, QQueryOperations> timeStatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeStat');
    });
  }

  QueryBuilder<TimerModel, int, QQueryOperations> timeWorkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeWork');
    });
  }

  QueryBuilder<TimerModel, int, QQueryOperations> timeWorkSaveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeWorkSave');
    });
  }

  QueryBuilder<TimerModel, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<TimerModel, int, QQueryOperations> workProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'work');
    });
  }

  QueryBuilder<TimerModel, int, QQueryOperations> workSaveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workSave');
    });
  }
}
