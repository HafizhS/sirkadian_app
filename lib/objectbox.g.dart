// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/obejctbox_model.dart/food_exercise_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 3008231103323831688),
      name: 'Exercise',
      lastPropertyId: const IdUid(10, 5656940485429870223),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3615653338782105055),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1812126622084556210),
            name: 'sportId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7864110207407699350),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 582277406779960890),
            name: 'desc',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2999228664004424380),
            name: 'mets',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2867189625285625297),
            name: 'imageFilename',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 274337251598326168),
            name: 'userId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 48849009873946689),
            relationTarget: 'User'),
        ModelProperty(
            id: const IdUid(8, 1567179705838215984),
            name: 'date',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5785605612801335971),
            name: 'isChecked',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 5656940485429870223),
            name: 'difficulty',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 1537447124247363090),
      name: 'Food',
      lastPropertyId: const IdUid(32, 2456367297624848551),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1827803256389649423),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8266201449706535739),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 212255939708086216),
            name: 'foodTypes',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1651283957346611691),
            name: 'duration',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 6766339525834140782),
            name: 'serving',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 7172396799859426036),
            name: 'session',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 3401850130613586118),
            name: 'date',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 7997541492252149572),
            name: 'difficulty',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5361553243045867856),
            name: 'tags',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 2942761977035440198),
            name: 'water',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 742429649812164597),
            name: 'energy',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 3468394470166265548),
            name: 'protein',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 6786427632652934830),
            name: 'fat',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 181047063025413438),
            name: 'carbohydrate',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 1191615290116359505),
            name: 'fiber',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 2934399922158885364),
            name: 'calcium',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 2891129737123689418),
            name: 'iron',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(18, 2645815561105167672),
            name: 'phosphor',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(19, 4921141469057489333),
            name: 'potassium',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(20, 3172267514076120666),
            name: 'sodium',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(21, 3534344241356221884),
            name: 'zinc',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(22, 7683524786197295127),
            name: 'copper',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(23, 3403812029689781462),
            name: 'vitaminC',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(24, 2431716558378395180),
            name: 'vitaminB1',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(25, 7040609714595649194),
            name: 'vitaminB2',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(26, 8002174984704190355),
            name: 'vitaminB3',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(27, 8910209046546154968),
            name: 'retinol',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(28, 8237221542813592976),
            name: 'foodId',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(29, 533869178784666820),
            name: 'instruction',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(30, 3672133806436929419),
            name: 'imageFileName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(31, 3534973823171917606),
            name: 'userId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 4707290468638542427),
            relationTarget: 'User'),
        ModelProperty(
            id: const IdUid(32, 2456367297624848551),
            name: 'recommendationScore',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 7510490782568328100),
      name: 'User',
      lastPropertyId: const IdUid(1, 3060100015683794578),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3060100015683794578),
            name: 'id',
            type: 6,
            flags: 1)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 2793138410119953805),
            name: 'exercises',
            targetId: const IdUid(1, 3008231103323831688))
      ],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'foods', srcEntity: 'Food', srcField: '')
      ]),
  ModelEntity(
      id: const IdUid(4, 8973082184935809639),
      name: 'Variations',
      lastPropertyId: const IdUid(13, 5107727704619027609),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7920547170551620558),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1683529787628143452),
            name: 'sportId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6557456373294508945),
            name: 'sportVariationsId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7423941731417593974),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 5533496727351254392),
            name: 'desc',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 533139905566367718),
            name: 'mets',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 4530687362846416579),
            name: 'imageFilename',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 98058746785667943),
            name: 'userId',
            type: 11,
            flags: 520,
            indexId: const IdUid(3, 6506144417513643134),
            relationTarget: 'Exercise'),
        ModelProperty(
            id: const IdUid(12, 2893357313142973546),
            name: 'subVariations',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 5107727704619027609),
            name: 'difficulty',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(4, 8973082184935809639),
      lastIndexId: const IdUid(3, 6506144417513643134),
      lastRelationId: const IdUid(1, 2793138410119953805),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        1429937487993746113,
        7226356010622220216,
        5683875273788991992
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Exercise: EntityDefinition<Exercise>(
        model: _entities[0],
        toOneRelations: (Exercise object) => [object.user],
        toManyRelations: (Exercise object) => {},
        getId: (Exercise object) => object.id,
        setId: (Exercise object, int id) {
          object.id = id;
        },
        objectToFB: (Exercise object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final descOffset =
              object.desc == null ? null : fbb.writeString(object.desc!);
          final imageFilenameOffset = object.imageFilename == null
              ? null
              : fbb.writeString(object.imageFilename!);
          final dateOffset =
              object.date == null ? null : fbb.writeString(object.date!);
          final difficultyOffset = object.difficulty == null
              ? null
              : fbb.writeString(object.difficulty!);
          fbb.startTable(11);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.sportId);
          fbb.addOffset(2, nameOffset);
          fbb.addOffset(3, descOffset);
          fbb.addFloat64(4, object.mets);
          fbb.addOffset(5, imageFilenameOffset);
          fbb.addInt64(6, object.user.targetId);
          fbb.addOffset(7, dateOffset);
          fbb.addBool(8, object.isChecked);
          fbb.addOffset(9, difficultyOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Exercise(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              desc: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              difficulty: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 22),
              imageFilename: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              mets: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              sportId: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              date: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18),
              isChecked: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 20));
          object.user.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0);
          object.user.attach(store);
          return object;
        }),
    Food: EntityDefinition<Food>(
        model: _entities[1],
        toOneRelations: (Food object) => [object.user],
        toManyRelations: (Food object) => {},
        getId: (Food object) => object.id,
        setId: (Food object, int id) {
          object.id = id;
        },
        objectToFB: (Food object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final foodTypesOffset = object.foodTypes == null
              ? null
              : fbb.writeList(object.foodTypes!
                  .map(fbb.writeString)
                  .toList(growable: false));
          final sessionOffset = fbb.writeString(object.session);
          final dateOffset = fbb.writeString(object.date);
          final difficultyOffset = object.difficulty == null
              ? null
              : fbb.writeString(object.difficulty!);
          final tagsOffset =
              object.tags == null ? null : fbb.writeString(object.tags!);
          final foodIdOffset =
              object.foodId == null ? null : fbb.writeString(object.foodId!);
          final instructionOffset = object.instruction == null
              ? null
              : fbb.writeList(object.instruction!
                  .map(fbb.writeString)
                  .toList(growable: false));
          final imageFileNameOffset = object.imageFileName == null
              ? null
              : fbb.writeString(object.imageFileName!);
          final recommendationScoreOffset = object.recommendationScore == null
              ? null
              : fbb.writeString(object.recommendationScore!);
          fbb.startTable(33);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, foodTypesOffset);
          fbb.addInt64(3, object.duration);
          fbb.addInt64(4, object.serving);
          fbb.addOffset(5, sessionOffset);
          fbb.addOffset(6, dateOffset);
          fbb.addOffset(7, difficultyOffset);
          fbb.addOffset(8, tagsOffset);
          fbb.addFloat64(9, object.water);
          fbb.addFloat64(10, object.energy);
          fbb.addFloat64(11, object.protein);
          fbb.addFloat64(12, object.fat);
          fbb.addFloat64(13, object.carbohydrate);
          fbb.addFloat64(14, object.fiber);
          fbb.addFloat64(15, object.calcium);
          fbb.addFloat64(16, object.iron);
          fbb.addFloat64(17, object.phosphor);
          fbb.addFloat64(18, object.potassium);
          fbb.addFloat64(19, object.sodium);
          fbb.addFloat64(20, object.zinc);
          fbb.addFloat64(21, object.copper);
          fbb.addFloat64(22, object.vitaminC);
          fbb.addFloat64(23, object.vitaminB1);
          fbb.addFloat64(24, object.vitaminB2);
          fbb.addFloat64(25, object.vitaminB3);
          fbb.addFloat64(26, object.retinol);
          fbb.addOffset(27, foodIdOffset);
          fbb.addOffset(28, instructionOffset);
          fbb.addOffset(29, imageFileNameOffset);
          fbb.addInt64(30, object.user.targetId);
          fbb.addOffset(31, recommendationScoreOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Food(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              foodTypes:
                  const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false)
                      .vTableGetNullable(buffer, rootOffset, 8),
              duration: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              serving: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              date: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 16, ''),
              session: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, ''),
              difficulty: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18),
              tags: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 20),
              water: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 22),
              energy: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 24),
              protein: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 26),
              fat: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 28),
              carbohydrate: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 30),
              fiber: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 32),
              calcium: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 34),
              iron: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 36),
              phosphor: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 38),
              potassium: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 40),
              sodium: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 42),
              zinc: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 44),
              copper: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 46),
              vitaminC: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 48),
              vitaminB1: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 50),
              vitaminB2: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 52),
              vitaminB3: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 54),
              retinol: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 56),
              foodId: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 58),
              instruction: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false).vTableGetNullable(buffer, rootOffset, 60),
              imageFileName: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 62),
              recommendationScore: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 66));
          object.user.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 64, 0);
          object.user.attach(store);
          return object;
        }),
    User: EntityDefinition<User>(
        model: _entities[2],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) => {
              RelInfo<User>.toMany(1, object.id): object.exercises,
              RelInfo<Food>.toOneBacklink(
                      31, object.id, (Food srcObject) => srcObject.user):
                  object.foods
            },
        getId: (User object) => object.id,
        setId: (User object, int id) {
          object.id = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          fbb.startTable(2);
          fbb.addInt64(0, object.id);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = User(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          InternalToManyAccess.setRelInfo(object.exercises, store,
              RelInfo<User>.toMany(1, object.id), store.box<User>());
          InternalToManyAccess.setRelInfo(
              object.foods,
              store,
              RelInfo<Food>.toOneBacklink(
                  31, object.id, (Food srcObject) => srcObject.user),
              store.box<User>());
          return object;
        }),
    Variations: EntityDefinition<Variations>(
        model: _entities[3],
        toOneRelations: (Variations object) => [object.user],
        toManyRelations: (Variations object) => {},
        getId: (Variations object) => object.id,
        setId: (Variations object, int id) {
          object.id = id;
        },
        objectToFB: (Variations object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final descOffset =
              object.desc == null ? null : fbb.writeString(object.desc!);
          final imageFilenameOffset = object.imageFilename == null
              ? null
              : fbb.writeString(object.imageFilename!);
          final subVariationsOffset = object.subVariations == null
              ? null
              : fbb.writeString(object.subVariations!);
          final difficultyOffset = object.difficulty == null
              ? null
              : fbb.writeString(object.difficulty!);
          fbb.startTable(14);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.sportId);
          fbb.addInt64(2, object.sportVariationsId);
          fbb.addOffset(3, nameOffset);
          fbb.addOffset(4, descOffset);
          fbb.addFloat64(5, object.mets);
          fbb.addOffset(7, imageFilenameOffset);
          fbb.addInt64(8, object.user.targetId);
          fbb.addOffset(11, subVariationsOffset);
          fbb.addOffset(12, difficultyOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Variations(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              difficulty: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 28),
              desc: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              imageFilename: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18),
              mets: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              sportId: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              subVariations: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 26),
              sportVariationsId:
                  const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 8));
          object.user.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          object.user.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Exercise] entity fields to define ObjectBox queries.
class Exercise_ {
  /// see [Exercise.id]
  static final id = QueryIntegerProperty<Exercise>(_entities[0].properties[0]);

  /// see [Exercise.sportId]
  static final sportId =
      QueryIntegerProperty<Exercise>(_entities[0].properties[1]);

  /// see [Exercise.name]
  static final name = QueryStringProperty<Exercise>(_entities[0].properties[2]);

  /// see [Exercise.desc]
  static final desc = QueryStringProperty<Exercise>(_entities[0].properties[3]);

  /// see [Exercise.mets]
  static final mets = QueryDoubleProperty<Exercise>(_entities[0].properties[4]);

  /// see [Exercise.imageFilename]
  static final imageFilename =
      QueryStringProperty<Exercise>(_entities[0].properties[5]);

  /// see [Exercise.user]
  static final user =
      QueryRelationToOne<Exercise, User>(_entities[0].properties[6]);

  /// see [Exercise.date]
  static final date = QueryStringProperty<Exercise>(_entities[0].properties[7]);

  /// see [Exercise.isChecked]
  static final isChecked =
      QueryBooleanProperty<Exercise>(_entities[0].properties[8]);

  /// see [Exercise.difficulty]
  static final difficulty =
      QueryStringProperty<Exercise>(_entities[0].properties[9]);
}

/// [Food] entity fields to define ObjectBox queries.
class Food_ {
  /// see [Food.id]
  static final id = QueryIntegerProperty<Food>(_entities[1].properties[0]);

  /// see [Food.name]
  static final name = QueryStringProperty<Food>(_entities[1].properties[1]);

  /// see [Food.foodTypes]
  static final foodTypes =
      QueryStringVectorProperty<Food>(_entities[1].properties[2]);

  /// see [Food.duration]
  static final duration =
      QueryIntegerProperty<Food>(_entities[1].properties[3]);

  /// see [Food.serving]
  static final serving = QueryIntegerProperty<Food>(_entities[1].properties[4]);

  /// see [Food.session]
  static final session = QueryStringProperty<Food>(_entities[1].properties[5]);

  /// see [Food.date]
  static final date = QueryStringProperty<Food>(_entities[1].properties[6]);

  /// see [Food.difficulty]
  static final difficulty =
      QueryStringProperty<Food>(_entities[1].properties[7]);

  /// see [Food.tags]
  static final tags = QueryStringProperty<Food>(_entities[1].properties[8]);

  /// see [Food.water]
  static final water = QueryDoubleProperty<Food>(_entities[1].properties[9]);

  /// see [Food.energy]
  static final energy = QueryDoubleProperty<Food>(_entities[1].properties[10]);

  /// see [Food.protein]
  static final protein = QueryDoubleProperty<Food>(_entities[1].properties[11]);

  /// see [Food.fat]
  static final fat = QueryDoubleProperty<Food>(_entities[1].properties[12]);

  /// see [Food.carbohydrate]
  static final carbohydrate =
      QueryDoubleProperty<Food>(_entities[1].properties[13]);

  /// see [Food.fiber]
  static final fiber = QueryDoubleProperty<Food>(_entities[1].properties[14]);

  /// see [Food.calcium]
  static final calcium = QueryDoubleProperty<Food>(_entities[1].properties[15]);

  /// see [Food.iron]
  static final iron = QueryDoubleProperty<Food>(_entities[1].properties[16]);

  /// see [Food.phosphor]
  static final phosphor =
      QueryDoubleProperty<Food>(_entities[1].properties[17]);

  /// see [Food.potassium]
  static final potassium =
      QueryDoubleProperty<Food>(_entities[1].properties[18]);

  /// see [Food.sodium]
  static final sodium = QueryDoubleProperty<Food>(_entities[1].properties[19]);

  /// see [Food.zinc]
  static final zinc = QueryDoubleProperty<Food>(_entities[1].properties[20]);

  /// see [Food.copper]
  static final copper = QueryDoubleProperty<Food>(_entities[1].properties[21]);

  /// see [Food.vitaminC]
  static final vitaminC =
      QueryDoubleProperty<Food>(_entities[1].properties[22]);

  /// see [Food.vitaminB1]
  static final vitaminB1 =
      QueryDoubleProperty<Food>(_entities[1].properties[23]);

  /// see [Food.vitaminB2]
  static final vitaminB2 =
      QueryDoubleProperty<Food>(_entities[1].properties[24]);

  /// see [Food.vitaminB3]
  static final vitaminB3 =
      QueryDoubleProperty<Food>(_entities[1].properties[25]);

  /// see [Food.retinol]
  static final retinol = QueryDoubleProperty<Food>(_entities[1].properties[26]);

  /// see [Food.foodId]
  static final foodId = QueryStringProperty<Food>(_entities[1].properties[27]);

  /// see [Food.instruction]
  static final instruction =
      QueryStringVectorProperty<Food>(_entities[1].properties[28]);

  /// see [Food.imageFileName]
  static final imageFileName =
      QueryStringProperty<Food>(_entities[1].properties[29]);

  /// see [Food.user]
  static final user =
      QueryRelationToOne<Food, User>(_entities[1].properties[30]);

  /// see [Food.recommendationScore]
  static final recommendationScore =
      QueryStringProperty<Food>(_entities[1].properties[31]);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.id]
  static final id = QueryIntegerProperty<User>(_entities[2].properties[0]);

  /// see [User.exercises]
  static final exercises =
      QueryRelationToMany<User, Exercise>(_entities[2].relations[0]);
}

/// [Variations] entity fields to define ObjectBox queries.
class Variations_ {
  /// see [Variations.id]
  static final id =
      QueryIntegerProperty<Variations>(_entities[3].properties[0]);

  /// see [Variations.sportId]
  static final sportId =
      QueryIntegerProperty<Variations>(_entities[3].properties[1]);

  /// see [Variations.sportVariationsId]
  static final sportVariationsId =
      QueryIntegerProperty<Variations>(_entities[3].properties[2]);

  /// see [Variations.name]
  static final name =
      QueryStringProperty<Variations>(_entities[3].properties[3]);

  /// see [Variations.desc]
  static final desc =
      QueryStringProperty<Variations>(_entities[3].properties[4]);

  /// see [Variations.mets]
  static final mets =
      QueryDoubleProperty<Variations>(_entities[3].properties[5]);

  /// see [Variations.imageFilename]
  static final imageFilename =
      QueryStringProperty<Variations>(_entities[3].properties[6]);

  /// see [Variations.user]
  static final user =
      QueryRelationToOne<Variations, Exercise>(_entities[3].properties[7]);

  /// see [Variations.subVariations]
  static final subVariations =
      QueryStringProperty<Variations>(_entities[3].properties[8]);

  /// see [Variations.difficulty]
  static final difficulty =
      QueryStringProperty<Variations>(_entities[3].properties[9]);
}
