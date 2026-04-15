// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOnboardingDataCollection on Isar {
  IsarCollection<OnboardingData> get onboardingDatas => this.collection();
}

const OnboardingDataSchema = CollectionSchema(
  name: r'OnboardingData',
  id: -6354398654708067484,
  properties: {
    r'county': PropertySchema(
      id: 0,
      name: r'county',
      type: IsarType.string,
    ),
    r'dailyBudget': PropertySchema(
      id: 1,
      name: r'dailyBudget',
      type: IsarType.long,
    ),
    r'dietaryGoals': PropertySchema(
      id: 2,
      name: r'dietaryGoals',
      type: IsarType.stringList,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'region': PropertySchema(
      id: 4,
      name: r'region',
      type: IsarType.string,
    ),
    r'subRegion': PropertySchema(
      id: 5,
      name: r'subRegion',
      type: IsarType.string,
    )
  },
  estimateSize: _onboardingDataEstimateSize,
  serialize: _onboardingDataSerialize,
  deserialize: _onboardingDataDeserialize,
  deserializeProp: _onboardingDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _onboardingDataGetId,
  getLinks: _onboardingDataGetLinks,
  attach: _onboardingDataAttach,
  version: '3.1.0+1',
);

int _onboardingDataEstimateSize(
  OnboardingData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.county.length * 3;
  bytesCount += 3 + object.dietaryGoals.length * 3;
  {
    for (var i = 0; i < object.dietaryGoals.length; i++) {
      final value = object.dietaryGoals[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.region.length * 3;
  bytesCount += 3 + object.subRegion.length * 3;
  return bytesCount;
}

void _onboardingDataSerialize(
  OnboardingData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.county);
  writer.writeLong(offsets[1], object.dailyBudget);
  writer.writeStringList(offsets[2], object.dietaryGoals);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.region);
  writer.writeString(offsets[5], object.subRegion);
}

OnboardingData _onboardingDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OnboardingData(
    county: reader.readStringOrNull(offsets[0]) ?? 'Nairobi',
    dailyBudget: reader.readLongOrNull(offsets[1]) ?? 200,
    dietaryGoals: reader.readStringList(offsets[2]) ?? const ['high-fibre'],
    id: id,
    name: reader.readStringOrNull(offsets[3]) ?? '',
    region: reader.readStringOrNull(offsets[4]) ?? 'kenya',
    subRegion: reader.readStringOrNull(offsets[5]) ?? 'nairobi',
  );
  return object;
}

P _onboardingDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? 'Nairobi') as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 200) as P;
    case 2:
      return (reader.readStringList(offset) ?? const ['high-fibre']) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? 'kenya') as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? 'nairobi') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _onboardingDataGetId(OnboardingData object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _onboardingDataGetLinks(OnboardingData object) {
  return [];
}

void _onboardingDataAttach(
    IsarCollection<dynamic> col, Id id, OnboardingData object) {
  object.id = id;
}

extension OnboardingDataQueryWhereSort
    on QueryBuilder<OnboardingData, OnboardingData, QWhere> {
  QueryBuilder<OnboardingData, OnboardingData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OnboardingDataQueryWhere
    on QueryBuilder<OnboardingData, OnboardingData, QWhereClause> {
  QueryBuilder<OnboardingData, OnboardingData, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<OnboardingData, OnboardingData, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterWhereClause> idBetween(
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

extension OnboardingDataQueryFilter
    on QueryBuilder<OnboardingData, OnboardingData, QFilterCondition> {
  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      countyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'county',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      countyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'county',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      countyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'county',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      countyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'county',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      countyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'county',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      countyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'county',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      countyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'county',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      countyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'county',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      countyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'county',
        value: '',
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      countyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'county',
        value: '',
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dailyBudgetEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailyBudget',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dailyBudgetGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailyBudget',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dailyBudgetLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailyBudget',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dailyBudgetBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailyBudget',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dietaryGoals',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dietaryGoals',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dietaryGoals',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dietaryGoals',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dietaryGoals',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dietaryGoals',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dietaryGoals',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dietaryGoals',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dietaryGoals',
        value: '',
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dietaryGoals',
        value: '',
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dietaryGoals',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dietaryGoals',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dietaryGoals',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dietaryGoals',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dietaryGoals',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dietaryGoals',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
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

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      idLessThan(
    Id? value, {
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

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'region',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'region',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'region',
        value: '',
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'region',
        value: '',
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subRegion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subRegion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subRegion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subRegion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subRegion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subRegion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subRegion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subRegion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subRegion',
        value: '',
      ));
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subRegion',
        value: '',
      ));
    });
  }
}

extension OnboardingDataQueryObject
    on QueryBuilder<OnboardingData, OnboardingData, QFilterCondition> {}

extension OnboardingDataQueryLinks
    on QueryBuilder<OnboardingData, OnboardingData, QFilterCondition> {}

extension OnboardingDataQuerySortBy
    on QueryBuilder<OnboardingData, OnboardingData, QSortBy> {
  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> sortByCounty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'county', Sort.asc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      sortByCountyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'county', Sort.desc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      sortByDailyBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyBudget', Sort.asc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      sortByDailyBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyBudget', Sort.desc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> sortByRegion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.asc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      sortByRegionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.desc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> sortBySubRegion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subRegion', Sort.asc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      sortBySubRegionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subRegion', Sort.desc);
    });
  }
}

extension OnboardingDataQuerySortThenBy
    on QueryBuilder<OnboardingData, OnboardingData, QSortThenBy> {
  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenByCounty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'county', Sort.asc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      thenByCountyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'county', Sort.desc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      thenByDailyBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyBudget', Sort.asc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      thenByDailyBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyBudget', Sort.desc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenByRegion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.asc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      thenByRegionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.desc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenBySubRegion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subRegion', Sort.asc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      thenBySubRegionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subRegion', Sort.desc);
    });
  }
}

extension OnboardingDataQueryWhereDistinct
    on QueryBuilder<OnboardingData, OnboardingData, QDistinct> {
  QueryBuilder<OnboardingData, OnboardingData, QDistinct> distinctByCounty(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'county', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QDistinct>
      distinctByDailyBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyBudget');
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QDistinct>
      distinctByDietaryGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dietaryGoals');
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QDistinct> distinctByRegion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'region', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QDistinct> distinctBySubRegion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subRegion', caseSensitive: caseSensitive);
    });
  }
}

extension OnboardingDataQueryProperty
    on QueryBuilder<OnboardingData, OnboardingData, QQueryProperty> {
  QueryBuilder<OnboardingData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OnboardingData, String, QQueryOperations> countyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'county');
    });
  }

  QueryBuilder<OnboardingData, int, QQueryOperations> dailyBudgetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyBudget');
    });
  }

  QueryBuilder<OnboardingData, List<String>, QQueryOperations>
      dietaryGoalsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dietaryGoals');
    });
  }

  QueryBuilder<OnboardingData, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<OnboardingData, String, QQueryOperations> regionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'region');
    });
  }

  QueryBuilder<OnboardingData, String, QQueryOperations> subRegionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subRegion');
    });
  }
}
