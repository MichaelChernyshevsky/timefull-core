// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNoteModelCollection on Isar {
  IsarCollection<NoteModel> get noteModels => this.collection();
}

const NoteModelSchema = CollectionSchema(
  name: r'NoteModel',
  id: -5829966683692150002,
  properties: {
    r'active': PropertySchema(
      id: 0,
      name: r'active',
      type: IsarType.bool,
    ),
    r'markActive': PropertySchema(
      id: 1,
      name: r'markActive',
      type: IsarType.bool,
    ),
    r'padding': PropertySchema(
      id: 2,
      name: r'padding',
      type: IsarType.long,
    ),
    r'pageId': PropertySchema(
      id: 3,
      name: r'pageId',
      type: IsarType.long,
    ),
    r'position': PropertySchema(
      id: 4,
      name: r'position',
      type: IsarType.long,
    ),
    r'suffics': PropertySchema(
      id: 5,
      name: r'suffics',
      type: IsarType.string,
    ),
    r'text': PropertySchema(
      id: 6,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _noteModelEstimateSize,
  serialize: _noteModelSerialize,
  deserialize: _noteModelDeserialize,
  deserializeProp: _noteModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _noteModelGetId,
  getLinks: _noteModelGetLinks,
  attach: _noteModelAttach,
  version: '3.1.0+1',
);

int _noteModelEstimateSize(
  NoteModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.suffics;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _noteModelSerialize(
  NoteModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.active);
  writer.writeBool(offsets[1], object.markActive);
  writer.writeLong(offsets[2], object.padding);
  writer.writeLong(offsets[3], object.pageId);
  writer.writeLong(offsets[4], object.position);
  writer.writeString(offsets[5], object.suffics);
  writer.writeString(offsets[6], object.text);
}

NoteModel _noteModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NoteModel(
    active: reader.readBoolOrNull(offsets[0]),
    id: id,
    markActive: reader.readBoolOrNull(offsets[1]),
    padding: reader.readLongOrNull(offsets[2]),
    pageId: reader.readLong(offsets[3]),
    position: reader.readLong(offsets[4]),
    suffics: reader.readStringOrNull(offsets[5]),
    text: reader.readString(offsets[6]),
  );
  return object;
}

P _noteModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _noteModelGetId(NoteModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _noteModelGetLinks(NoteModel object) {
  return [];
}

void _noteModelAttach(IsarCollection<dynamic> col, Id id, NoteModel object) {
  object.id = id;
}

extension NoteModelQueryWhereSort
    on QueryBuilder<NoteModel, NoteModel, QWhere> {
  QueryBuilder<NoteModel, NoteModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NoteModelQueryWhere
    on QueryBuilder<NoteModel, NoteModel, QWhereClause> {
  QueryBuilder<NoteModel, NoteModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<NoteModel, NoteModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterWhereClause> idBetween(
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

extension NoteModelQueryFilter
    on QueryBuilder<NoteModel, NoteModel, QFilterCondition> {
  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> activeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'active',
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> activeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'active',
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> activeEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'active',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> markActiveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'markActive',
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition>
      markActiveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'markActive',
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> markActiveEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'markActive',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> paddingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'padding',
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> paddingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'padding',
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> paddingEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'padding',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> paddingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'padding',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> paddingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'padding',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> paddingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'padding',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> pageIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageId',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> pageIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pageId',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> pageIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pageId',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> pageIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> positionEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> positionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> positionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> positionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'position',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> sufficsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'suffics',
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> sufficsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'suffics',
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> sufficsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'suffics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> sufficsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'suffics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> sufficsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'suffics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> sufficsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'suffics',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> sufficsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'suffics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> sufficsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'suffics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> sufficsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'suffics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> sufficsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'suffics',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> sufficsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'suffics',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition>
      sufficsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'suffics',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterFilterCondition> textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension NoteModelQueryObject
    on QueryBuilder<NoteModel, NoteModel, QFilterCondition> {}

extension NoteModelQueryLinks
    on QueryBuilder<NoteModel, NoteModel, QFilterCondition> {}

extension NoteModelQuerySortBy on QueryBuilder<NoteModel, NoteModel, QSortBy> {
  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortByActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'active', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortByActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'active', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortByMarkActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'markActive', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortByMarkActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'markActive', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortByPadding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'padding', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortByPaddingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'padding', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortByPageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageId', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortByPageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageId', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortBySuffics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suffics', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortBySufficsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suffics', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension NoteModelQuerySortThenBy
    on QueryBuilder<NoteModel, NoteModel, QSortThenBy> {
  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'active', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'active', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByMarkActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'markActive', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByMarkActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'markActive', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByPadding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'padding', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByPaddingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'padding', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByPageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageId', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByPageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageId', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenBySuffics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suffics', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenBySufficsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suffics', Sort.desc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension NoteModelQueryWhereDistinct
    on QueryBuilder<NoteModel, NoteModel, QDistinct> {
  QueryBuilder<NoteModel, NoteModel, QDistinct> distinctByActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'active');
    });
  }

  QueryBuilder<NoteModel, NoteModel, QDistinct> distinctByMarkActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'markActive');
    });
  }

  QueryBuilder<NoteModel, NoteModel, QDistinct> distinctByPadding() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'padding');
    });
  }

  QueryBuilder<NoteModel, NoteModel, QDistinct> distinctByPageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pageId');
    });
  }

  QueryBuilder<NoteModel, NoteModel, QDistinct> distinctByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'position');
    });
  }

  QueryBuilder<NoteModel, NoteModel, QDistinct> distinctBySuffics(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'suffics', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteModel, NoteModel, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }
}

extension NoteModelQueryProperty
    on QueryBuilder<NoteModel, NoteModel, QQueryProperty> {
  QueryBuilder<NoteModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NoteModel, bool?, QQueryOperations> activeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'active');
    });
  }

  QueryBuilder<NoteModel, bool?, QQueryOperations> markActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'markActive');
    });
  }

  QueryBuilder<NoteModel, int?, QQueryOperations> paddingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'padding');
    });
  }

  QueryBuilder<NoteModel, int, QQueryOperations> pageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pageId');
    });
  }

  QueryBuilder<NoteModel, int, QQueryOperations> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'position');
    });
  }

  QueryBuilder<NoteModel, String?, QQueryOperations> sufficsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'suffics');
    });
  }

  QueryBuilder<NoteModel, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }
}
