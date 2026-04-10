// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_data.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetOnboardingDataCollection on Isar {
  IsarCollection<int, OnboardingData> get onboardingDatas => this.collection();
}

const OnboardingDataSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'OnboardingData',
    idName: 'isarId',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'name',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'region',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'subRegion',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'dailyBudget',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'dietaryGoals',
        type: IsarType.stringList,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, OnboardingData>(
    serialize: serializeOnboardingData,
    deserialize: deserializeOnboardingData,
    deserializeProperty: deserializeOnboardingDataProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeOnboardingData(IsarWriter writer, OnboardingData object) {
  IsarCore.writeString(writer, 1, object.name);
  IsarCore.writeString(writer, 2, object.region);
  IsarCore.writeString(writer, 3, object.subRegion);
  IsarCore.writeLong(writer, 4, object.dailyBudget);
  {
    final list = object.dietaryGoals;
    final listWriter = IsarCore.beginList(writer, 5, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeString(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  return object.isarId;
}

@isarProtected
OnboardingData deserializeOnboardingData(IsarReader reader) {
  final String _name;
  _name = IsarCore.readString(reader, 1) ?? '';
  final String _region;
  _region = IsarCore.readString(reader, 2) ?? 'kenya';
  final String _subRegion;
  _subRegion = IsarCore.readString(reader, 3) ?? 'nairobi';
  final int _dailyBudget;
  {
    final value = IsarCore.readLong(reader, 4);
    if (value == -9223372036854775808) {
      _dailyBudget = 200;
    } else {
      _dailyBudget = value;
    }
  }
  final List<String> _dietaryGoals;
  {
    final length = IsarCore.readList(reader, 5, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _dietaryGoals = const ['high-fibre'];
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _dietaryGoals = list;
      }
    }
  }
  final object = OnboardingData(
    name: _name,
    region: _region,
    subRegion: _subRegion,
    dailyBudget: _dailyBudget,
    dietaryGoals: _dietaryGoals,
  );
  object.isarId = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeOnboardingDataProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? 'kenya';
    case 3:
      return IsarCore.readString(reader, 3) ?? 'nairobi';
    case 4:
      {
        final value = IsarCore.readLong(reader, 4);
        if (value == -9223372036854775808) {
          return 200;
        } else {
          return value;
        }
      }
    case 5:
      {
        final length = IsarCore.readList(reader, 5, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return const ['high-fibre'];
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _OnboardingDataUpdate {
  bool call({
    required int isarId,
    String? name,
    String? region,
    String? subRegion,
    int? dailyBudget,
  });
}

class _OnboardingDataUpdateImpl implements _OnboardingDataUpdate {
  const _OnboardingDataUpdateImpl(this.collection);

  final IsarCollection<int, OnboardingData> collection;

  @override
  bool call({
    required int isarId,
    Object? name = ignore,
    Object? region = ignore,
    Object? subRegion = ignore,
    Object? dailyBudget = ignore,
  }) {
    return collection.updateProperties([
          isarId
        ], {
          if (name != ignore) 1: name as String?,
          if (region != ignore) 2: region as String?,
          if (subRegion != ignore) 3: subRegion as String?,
          if (dailyBudget != ignore) 4: dailyBudget as int?,
        }) >
        0;
  }
}

sealed class _OnboardingDataUpdateAll {
  int call({
    required List<int> isarId,
    String? name,
    String? region,
    String? subRegion,
    int? dailyBudget,
  });
}

class _OnboardingDataUpdateAllImpl implements _OnboardingDataUpdateAll {
  const _OnboardingDataUpdateAllImpl(this.collection);

  final IsarCollection<int, OnboardingData> collection;

  @override
  int call({
    required List<int> isarId,
    Object? name = ignore,
    Object? region = ignore,
    Object? subRegion = ignore,
    Object? dailyBudget = ignore,
  }) {
    return collection.updateProperties(isarId, {
      if (name != ignore) 1: name as String?,
      if (region != ignore) 2: region as String?,
      if (subRegion != ignore) 3: subRegion as String?,
      if (dailyBudget != ignore) 4: dailyBudget as int?,
    });
  }
}

extension OnboardingDataUpdate on IsarCollection<int, OnboardingData> {
  _OnboardingDataUpdate get update => _OnboardingDataUpdateImpl(this);

  _OnboardingDataUpdateAll get updateAll => _OnboardingDataUpdateAllImpl(this);
}

sealed class _OnboardingDataQueryUpdate {
  int call({
    String? name,
    String? region,
    String? subRegion,
    int? dailyBudget,
  });
}

class _OnboardingDataQueryUpdateImpl implements _OnboardingDataQueryUpdate {
  const _OnboardingDataQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<OnboardingData> query;
  final int? limit;

  @override
  int call({
    Object? name = ignore,
    Object? region = ignore,
    Object? subRegion = ignore,
    Object? dailyBudget = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (name != ignore) 1: name as String?,
      if (region != ignore) 2: region as String?,
      if (subRegion != ignore) 3: subRegion as String?,
      if (dailyBudget != ignore) 4: dailyBudget as int?,
    });
  }
}

extension OnboardingDataQueryUpdate on IsarQuery<OnboardingData> {
  _OnboardingDataQueryUpdate get updateFirst =>
      _OnboardingDataQueryUpdateImpl(this, limit: 1);

  _OnboardingDataQueryUpdate get updateAll =>
      _OnboardingDataQueryUpdateImpl(this);
}

class _OnboardingDataQueryBuilderUpdateImpl
    implements _OnboardingDataQueryUpdate {
  const _OnboardingDataQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<OnboardingData, OnboardingData, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? name = ignore,
    Object? region = ignore,
    Object? subRegion = ignore,
    Object? dailyBudget = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (name != ignore) 1: name as String?,
        if (region != ignore) 2: region as String?,
        if (subRegion != ignore) 3: subRegion as String?,
        if (dailyBudget != ignore) 4: dailyBudget as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension OnboardingDataQueryBuilderUpdate
    on QueryBuilder<OnboardingData, OnboardingData, QOperations> {
  _OnboardingDataQueryUpdate get updateFirst =>
      _OnboardingDataQueryBuilderUpdateImpl(this, limit: 1);

  _OnboardingDataQueryUpdate get updateAll =>
      _OnboardingDataQueryBuilderUpdateImpl(this);
}

extension OnboardingDataQueryFilter
    on QueryBuilder<OnboardingData, OnboardingData, QFilterCondition> {
  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      isarIdEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      isarIdGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      isarIdGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      isarIdLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      isarIdLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      isarIdBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      regionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      subRegionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dailyBudgetEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dailyBudgetGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dailyBudgetGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dailyBudgetLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dailyBudgetLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dailyBudgetBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 5,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsIsEmpty() {
    return not().dietaryGoalsIsNotEmpty();
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterFilterCondition>
      dietaryGoalsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 5, value: null),
      );
    });
  }
}

extension OnboardingDataQueryObject
    on QueryBuilder<OnboardingData, OnboardingData, QFilterCondition> {}

extension OnboardingDataQuerySortBy
    on QueryBuilder<OnboardingData, OnboardingData, QSortBy> {
  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> sortByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      sortByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> sortByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> sortByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> sortByRegion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> sortByRegionDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> sortBySubRegion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      sortBySubRegionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      sortByDailyBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      sortByDailyBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }
}

extension OnboardingDataQuerySortThenBy
    on QueryBuilder<OnboardingData, OnboardingData, QSortThenBy> {
  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenByRegion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenByRegionDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy> thenBySubRegion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      thenBySubRegionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      thenByDailyBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterSortBy>
      thenByDailyBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }
}

extension OnboardingDataQueryWhereDistinct
    on QueryBuilder<OnboardingData, OnboardingData, QDistinct> {
  QueryBuilder<OnboardingData, OnboardingData, QAfterDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterDistinct> distinctByRegion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterDistinct>
      distinctBySubRegion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterDistinct>
      distinctByDailyBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<OnboardingData, OnboardingData, QAfterDistinct>
      distinctByDietaryGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }
}

extension OnboardingDataQueryProperty1
    on QueryBuilder<OnboardingData, OnboardingData, QProperty> {
  QueryBuilder<OnboardingData, int, QAfterProperty> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<OnboardingData, String, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<OnboardingData, String, QAfterProperty> regionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<OnboardingData, String, QAfterProperty> subRegionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<OnboardingData, int, QAfterProperty> dailyBudgetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<OnboardingData, List<String>, QAfterProperty>
      dietaryGoalsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension OnboardingDataQueryProperty2<R>
    on QueryBuilder<OnboardingData, R, QAfterProperty> {
  QueryBuilder<OnboardingData, (R, int), QAfterProperty> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<OnboardingData, (R, String), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<OnboardingData, (R, String), QAfterProperty> regionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<OnboardingData, (R, String), QAfterProperty>
      subRegionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<OnboardingData, (R, int), QAfterProperty> dailyBudgetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<OnboardingData, (R, List<String>), QAfterProperty>
      dietaryGoalsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension OnboardingDataQueryProperty3<R1, R2>
    on QueryBuilder<OnboardingData, (R1, R2), QAfterProperty> {
  QueryBuilder<OnboardingData, (R1, R2, int), QOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<OnboardingData, (R1, R2, String), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<OnboardingData, (R1, R2, String), QOperations> regionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<OnboardingData, (R1, R2, String), QOperations>
      subRegionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<OnboardingData, (R1, R2, int), QOperations>
      dailyBudgetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<OnboardingData, (R1, R2, List<String>), QOperations>
      dietaryGoalsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}
