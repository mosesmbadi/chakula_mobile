// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_history_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMealHistoryItemCollection on Isar {
  IsarCollection<MealHistoryItem> get mealHistoryItems => this.collection();
}

const MealHistoryItemSchema = CollectionSchema(
  name: r'MealHistoryItem',
  id: -4124679062511397902,
  properties: {
    r'cost': PropertySchema(id: 0, name: r'cost', type: IsarType.double),
    r'currency': PropertySchema(
      id: 1,
      name: r'currency',
      type: IsarType.string,
    ),
    r'downvotes': PropertySchema(
      id: 2,
      name: r'downvotes',
      type: IsarType.long,
    ),
    r'eatenAt': PropertySchema(
      id: 3,
      name: r'eatenAt',
      type: IsarType.dateTime,
    ),
    r'foodId': PropertySchema(id: 4, name: r'foodId', type: IsarType.string),
    r'id': PropertySchema(id: 5, name: r'id', type: IsarType.string),
    r'mealName': PropertySchema(
      id: 6,
      name: r'mealName',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(id: 7, name: r'notes', type: IsarType.string),
    r'recipeInstructions': PropertySchema(
      id: 8,
      name: r'recipeInstructions',
      type: IsarType.string,
    ),
    r'recipeTitle': PropertySchema(
      id: 9,
      name: r'recipeTitle',
      type: IsarType.string,
    ),
    r'region': PropertySchema(id: 10, name: r'region', type: IsarType.string),
    r'subRegion': PropertySchema(
      id: 11,
      name: r'subRegion',
      type: IsarType.string,
    ),
    r'upvotes': PropertySchema(id: 12, name: r'upvotes', type: IsarType.long),
    r'userName': PropertySchema(
      id: 13,
      name: r'userName',
      type: IsarType.string,
    ),
  },

  estimateSize: _mealHistoryItemEstimateSize,
  serialize: _mealHistoryItemSerialize,
  deserialize: _mealHistoryItemDeserialize,
  deserializeProp: _mealHistoryItemDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _mealHistoryItemGetId,
  getLinks: _mealHistoryItemGetLinks,
  attach: _mealHistoryItemAttach,
  version: '3.3.2',
);

int _mealHistoryItemEstimateSize(
  MealHistoryItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.currency.length * 3;
  {
    final value = object.foodId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.mealName.length * 3;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.recipeInstructions;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.recipeTitle;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.region;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.subRegion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _mealHistoryItemSerialize(
  MealHistoryItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cost);
  writer.writeString(offsets[1], object.currency);
  writer.writeLong(offsets[2], object.downvotes);
  writer.writeDateTime(offsets[3], object.eatenAt);
  writer.writeString(offsets[4], object.foodId);
  writer.writeString(offsets[5], object.id);
  writer.writeString(offsets[6], object.mealName);
  writer.writeString(offsets[7], object.notes);
  writer.writeString(offsets[8], object.recipeInstructions);
  writer.writeString(offsets[9], object.recipeTitle);
  writer.writeString(offsets[10], object.region);
  writer.writeString(offsets[11], object.subRegion);
  writer.writeLong(offsets[12], object.upvotes);
  writer.writeString(offsets[13], object.userName);
}

MealHistoryItem _mealHistoryItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MealHistoryItem(
    cost: reader.readDouble(offsets[0]),
    currency: reader.readString(offsets[1]),
    downvotes: reader.readLong(offsets[2]),
    eatenAt: reader.readDateTime(offsets[3]),
    foodId: reader.readStringOrNull(offsets[4]),
    id: reader.readString(offsets[5]),
    mealName: reader.readString(offsets[6]),
    notes: reader.readStringOrNull(offsets[7]),
    recipeInstructions: reader.readStringOrNull(offsets[8]),
    recipeTitle: reader.readStringOrNull(offsets[9]),
    region: reader.readStringOrNull(offsets[10]),
    subRegion: reader.readStringOrNull(offsets[11]),
    upvotes: reader.readLong(offsets[12]),
    userName: reader.readStringOrNull(offsets[13]),
  );
  return object;
}

P _mealHistoryItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mealHistoryItemGetId(MealHistoryItem object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _mealHistoryItemGetLinks(MealHistoryItem object) {
  return [];
}

void _mealHistoryItemAttach(
  IsarCollection<dynamic> col,
  Id id,
  MealHistoryItem object,
) {}

extension MealHistoryItemQueryWhereSort
    on QueryBuilder<MealHistoryItem, MealHistoryItem, QWhere> {
  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MealHistoryItemQueryWhere
    on QueryBuilder<MealHistoryItem, MealHistoryItem, QWhereClause> {
  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterWhereClause>
  isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterWhereClause>
  isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterWhereClause>
  isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterWhereClause>
  isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterWhereClause>
  isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension MealHistoryItemQueryFilter
    on QueryBuilder<MealHistoryItem, MealHistoryItem, QFilterCondition> {
  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  costEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'cost',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  costGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cost',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  costLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cost',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  costBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cost',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  currencyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currency',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  currencyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  currencyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'currency',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  downvotesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'downvotes', value: value),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  downvotesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'downvotes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  downvotesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'downvotes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  downvotesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'downvotes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  eatenAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'eatenAt', value: value),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  eatenAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'eatenAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  eatenAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'eatenAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  eatenAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'eatenAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  foodIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'foodId'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  foodIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'foodId'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  foodIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'foodId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  foodIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'foodId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  foodIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'foodId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  foodIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'foodId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  foodIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'foodId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  foodIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'foodId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  foodIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'foodId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  foodIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'foodId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  foodIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'foodId', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  foodIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'foodId', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  idEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  idLessThan(String value, {bool include = false, bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  idStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  idEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'id',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  mealNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mealName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  mealNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mealName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  mealNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mealName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  mealNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mealName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  mealNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'mealName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  mealNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'mealName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  mealNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'mealName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  mealNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'mealName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  mealNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mealName', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  mealNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'mealName', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  notesEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  notesStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  notesEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeInstructionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'recipeInstructions'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeInstructionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'recipeInstructions'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeInstructionsEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'recipeInstructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeInstructionsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recipeInstructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeInstructionsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recipeInstructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeInstructionsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recipeInstructions',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeInstructionsStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'recipeInstructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeInstructionsEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'recipeInstructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeInstructionsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'recipeInstructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeInstructionsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'recipeInstructions',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeInstructionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recipeInstructions', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeInstructionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'recipeInstructions', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeTitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'recipeTitle'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeTitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'recipeTitle'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeTitleEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'recipeTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeTitleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recipeTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeTitleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recipeTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeTitleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recipeTitle',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeTitleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'recipeTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeTitleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'recipeTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'recipeTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'recipeTitle',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recipeTitle', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  recipeTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'recipeTitle', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  regionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'region'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  regionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'region'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  regionEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'region',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  regionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'region',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  regionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'region',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  regionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'region',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  regionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'region',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  regionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'region',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  regionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'region',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  regionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'region',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  regionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'region', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  regionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'region', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  subRegionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'subRegion'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  subRegionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'subRegion'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  subRegionEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'subRegion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  subRegionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'subRegion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  subRegionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'subRegion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  subRegionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'subRegion',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  subRegionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'subRegion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  subRegionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'subRegion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  subRegionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'subRegion',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  subRegionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'subRegion',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  subRegionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'subRegion', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  subRegionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'subRegion', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  upvotesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'upvotes', value: value),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  upvotesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'upvotes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  upvotesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'upvotes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  upvotesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'upvotes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  userNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'userName'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  userNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'userName'),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  userNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'userName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  userNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'userName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  userNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'userName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  userNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'userName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  userNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'userName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  userNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'userName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  userNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'userName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  userNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'userName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  userNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'userName', value: ''),
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterFilterCondition>
  userNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'userName', value: ''),
      );
    });
  }
}

extension MealHistoryItemQueryObject
    on QueryBuilder<MealHistoryItem, MealHistoryItem, QFilterCondition> {}

extension MealHistoryItemQueryLinks
    on QueryBuilder<MealHistoryItem, MealHistoryItem, QFilterCondition> {}

extension MealHistoryItemQuerySortBy
    on QueryBuilder<MealHistoryItem, MealHistoryItem, QSortBy> {
  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> sortByCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cost', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByCostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cost', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByDownvotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downvotes', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByDownvotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downvotes', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> sortByEatenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eatenAt', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByEatenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eatenAt', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> sortByFoodId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodId', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByFoodIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodId', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByMealName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealName', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByMealNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealName', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByRecipeInstructions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeInstructions', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByRecipeInstructionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeInstructions', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByRecipeTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeTitle', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByRecipeTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeTitle', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> sortByRegion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByRegionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortBySubRegion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subRegion', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortBySubRegionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subRegion', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> sortByUpvotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'upvotes', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByUpvotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'upvotes', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  sortByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension MealHistoryItemQuerySortThenBy
    on QueryBuilder<MealHistoryItem, MealHistoryItem, QSortThenBy> {
  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> thenByCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cost', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByCostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cost', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByDownvotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downvotes', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByDownvotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downvotes', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> thenByEatenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eatenAt', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByEatenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eatenAt', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> thenByFoodId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodId', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByFoodIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodId', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByMealName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealName', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByMealNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealName', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByRecipeInstructions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeInstructions', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByRecipeInstructionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeInstructions', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByRecipeTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeTitle', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByRecipeTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeTitle', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> thenByRegion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByRegionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenBySubRegion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subRegion', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenBySubRegionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subRegion', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy> thenByUpvotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'upvotes', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByUpvotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'upvotes', Sort.desc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QAfterSortBy>
  thenByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension MealHistoryItemQueryWhereDistinct
    on QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct> {
  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct> distinctByCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cost');
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct> distinctByCurrency({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct>
  distinctByDownvotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'downvotes');
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct>
  distinctByEatenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eatenAt');
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct> distinctByFoodId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'foodId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct> distinctById({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct> distinctByMealName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mealName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct> distinctByNotes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct>
  distinctByRecipeInstructions({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'recipeInstructions',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct>
  distinctByRecipeTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recipeTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct> distinctByRegion({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'region', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct>
  distinctBySubRegion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subRegion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct>
  distinctByUpvotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'upvotes');
    });
  }

  QueryBuilder<MealHistoryItem, MealHistoryItem, QDistinct> distinctByUserName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userName', caseSensitive: caseSensitive);
    });
  }
}

extension MealHistoryItemQueryProperty
    on QueryBuilder<MealHistoryItem, MealHistoryItem, QQueryProperty> {
  QueryBuilder<MealHistoryItem, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<MealHistoryItem, double, QQueryOperations> costProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cost');
    });
  }

  QueryBuilder<MealHistoryItem, String, QQueryOperations> currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<MealHistoryItem, int, QQueryOperations> downvotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'downvotes');
    });
  }

  QueryBuilder<MealHistoryItem, DateTime, QQueryOperations> eatenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eatenAt');
    });
  }

  QueryBuilder<MealHistoryItem, String?, QQueryOperations> foodIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'foodId');
    });
  }

  QueryBuilder<MealHistoryItem, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MealHistoryItem, String, QQueryOperations> mealNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mealName');
    });
  }

  QueryBuilder<MealHistoryItem, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<MealHistoryItem, String?, QQueryOperations>
  recipeInstructionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recipeInstructions');
    });
  }

  QueryBuilder<MealHistoryItem, String?, QQueryOperations>
  recipeTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recipeTitle');
    });
  }

  QueryBuilder<MealHistoryItem, String?, QQueryOperations> regionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'region');
    });
  }

  QueryBuilder<MealHistoryItem, String?, QQueryOperations> subRegionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subRegion');
    });
  }

  QueryBuilder<MealHistoryItem, int, QQueryOperations> upvotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'upvotes');
    });
  }

  QueryBuilder<MealHistoryItem, String?, QQueryOperations> userNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userName');
    });
  }
}
