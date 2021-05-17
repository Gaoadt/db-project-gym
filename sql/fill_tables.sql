-- STEP 1
/* Extracting gym data from csv */
COPY FITNESS.GYMS(NAME, CLUB) FROM '/data/gyms.csv'
DELIMITER ',' CSV HEADER;
/* It was closed due to fire but anyway */
INSERT INTO FITNESS.GYMS (NAME, CLUB) VALUES ('Спортзал общежития 2', 'МФТИ');

-- STEP 2
/* Extracting exercise data from csv */
COPY FITNESS.EXERCISES(NAME, MUSCLES) FROM '/data/exercises.csv'
DELIMITER ',' CSV HEADER;
INSERT INTO FITNESS.EXERCISES(NAME, MUSCLES) VALUES ('Отжимания на брусьях', 'Грудь');
INSERT INTO FITNESS.EXERCISES(NAME, MUSCLES) VALUES ('Бег', 'Кардио');

-- STEP 3
/* Extracting item data from csv */
COPY FITNESS.ITEMS(NAME) FROM '/data/items.csv'
DELIMITER ',' CSV HEADER;
INSERT INTO FITNESS.ITEMS(NAME) VALUES ('Брусья');
INSERT INTO FITNESS.ITEMS(NAME) VALUES ('Беговая дорожка');

-- STEP 4
/* Extracting program data from csv */
COPY FITNESS.PROGRAMS(NAME) FROM '/data/programs.csv'
DELIMITER ',' CSV HEADER;
INSERT INTO FITNESS.PROGRAMS(NAME) VALUES ('Для сушки');

-- STEP 5
/* Extracting trainer data from csv */
COPY FITNESS.TRAINERS(NAME) FROM '/data/trainers.csv'
DELIMITER ',' CSV HEADER;
INSERT INTO FITNESS.TRAINERS(NAME) VALUES ('Арнольд Шварцнегер');

-- STEP 6
/* Inserting athletes */
/* Those who don't have trainer */
INSERT INTO FITNESS.athletes(PROGRAM_ID, NAME) SELECT ID, 'Петр Петрович'
FROM FITNESS.PROGRAMS WHERE name = 'Для набора массы';
INSERT INTO FITNESS.athletes(PROGRAM_ID, NAME) SELECT ID, 'Алексей Иванович'
FROM FITNESS.PROGRAMS WHERE name = 'Для увеличения силы';
INSERT INTO FITNESS.athletes(PROGRAM_ID, NAME) SELECT ID, 'Василий Игнатьевич'
FROM FITNESS.PROGRAMS WHERE name = 'С акцентом на жим';
INSERT INTO FITNESS.athletes(PROGRAM_ID, NAME) SELECT ID, 'Эдвард Нортон'
FROM FITNESS.PROGRAMS WHERE name = 'С акцентом на ноги';
INSERT INTO FITNESS.athletes(PROGRAM_ID, NAME) SELECT ID, 'Брюс Уиллис'
FROM FITNESS.PROGRAMS WHERE name = 'Для увеличения силы';
INSERT INTO FITNESS.athletes(PROGRAM_ID, NAME) SELECT ID, 'Алексей Иванов'
FROM FITNESS.PROGRAMS WHERE name = 'Для сушки';
/* Those who have professional trainer */
INSERT INTO FITNESS.athletes(PROGRAM_ID, TRAINER_ID, NAME) SELECT PROGRAMS.ID, TRAINERS.ID, 'Ваня Ванич'
FROM FITNESS.PROGRAMS INNER JOIN FITNESS.TRAINERS ON trainers.name = 'Крис Хериа' AND programs.name='С акцентом на ноги';
INSERT INTO FITNESS.athletes(PROGRAM_ID, TRAINER_ID, NAME) SELECT PROGRAMS.ID, TRAINERS.ID, 'Григорий Минаков'
FROM FITNESS.PROGRAMS INNER JOIN FITNESS.TRAINERS ON trainers.name = 'Виктор Блуд' AND programs.name='С акцентом на изолированные упражнения';
INSERT INTO FITNESS.athletes(PROGRAM_ID, TRAINER_ID, NAME) SELECT PROGRAMS.ID, TRAINERS.ID, 'Петя Петич'
FROM FITNESS.PROGRAMS INNER JOIN FITNESS.TRAINERS ON trainers.name = 'Джефф Ниппард' AND programs.name='Для увеличения силы';
INSERT INTO FITNESS.athletes(PROGRAM_ID, TRAINER_ID, NAME) SELECT PROGRAMS.ID, TRAINERS.ID, 'Леха Лехыч'
FROM FITNESS.PROGRAMS INNER JOIN FITNESS.TRAINERS ON trainers.name = 'Михаил Баратов' AND programs.name='Для увеличения силы';
INSERT INTO FITNESS.athletes(PROGRAM_ID, TRAINER_ID, NAME) SELECT PROGRAMS.ID, TRAINERS.ID, 'Дима Димыч'
FROM FITNESS.PROGRAMS INNER JOIN FITNESS.TRAINERS ON trainers.name = 'Михаил Баратов' AND programs.name='С акцентом на изолированные упражнения';
INSERT INTO FITNESS.athletes(PROGRAM_ID, TRAINER_ID, NAME) SELECT PROGRAMS.ID, TRAINERS.ID, 'Тима Тимыч'
FROM FITNESS.PROGRAMS INNER JOIN FITNESS.TRAINERS ON trainers.name = 'Арнольд Шварцнегер' AND programs.name='Для увеличения силы';

-- STEP 7
/* Inserting exercise items */
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Подьем штанги стоя на бицепс'
AND items.name = 'Штанга';
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Подьем штанги сидя на скамье Скотта'
AND (items.name = 'Штанга' OR items.name = 'Скамья Скотта');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Французский жим лежа на трицепс'
AND (items.name = 'Штанга' OR items.name = 'Скамейка' OR items.name = 'Набор блинов');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Жим лежа с акцентом на трипес'
AND (items.name = 'Штанга' OR items.name = 'Скамейка' OR items.name = 'Набор блинов');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Подьем на блоке на бицепс'
AND (items.name = 'Блочный тренажер');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Подьем гантелей на бицепс'
AND (items.name = 'Набор гантелей');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Жим гантелей сидя'
AND (items.name = 'Набор гантелей' OR items.name = 'Скамейка');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Жим гантелей стоя'
AND (items.name = 'Набор гантелей');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Широкие подтягивания'
AND (items.name = 'Турник');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Подтягивания обратным хватом'
AND (items.name = 'Турник');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Разведение гантелей на грудь'
AND (items.name = 'Набор гантелей' OR items.name = 'Скамейка');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Подьем ног на турнике'
AND (items.name = 'Турник');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Подьем ног на брусьях'
AND (items.name = 'Брусья');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Присед'
AND (items.name = 'Штанга' OR items.name = 'Набор блинов');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Сгибание ног на тренажере'
AND (items.name = 'Тренажер на икры');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Жим платформы ногами на тренажере'
AND (items.name = 'Тренажер для жима платформы ногами');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Махи с гантелями в стороны'
AND (items.name = 'Набор гантелей');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Становая тяга'
AND (items.name = 'Штанга' OR items.name = 'Набор блинов');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Гиперекстензия'
AND (items.name = 'Упор для гиперэкстензии');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Отжимания на брусьях'
AND (items.name = 'Брусья');
INSERT INTO FITNESS.exercise_items(exercise_id, item_id) SELECT EXERCISES.ID, ITEMS.ID
FROM fitness.exercises inner join fitness.items ON exercises.name = 'Бег'
AND (items.name = 'Беговая дорожка');

-- STEP 8
/* Filling GYM_ITEMS. Let us think that every respectful gym has all the equipment,
   at least at the very beginning, cause it is scd 2 table.
*/

INSERT INTO FITNESS.gym_items(item_id, gym_id, time_from, time_to) SELECT ITEMS.ID, GYMS.ID,
                                                                          TO_TIMESTAMP('2000-01-01', 'YYYY-MM-DD'),
                                                                          TO_TIMESTAMP('5999-01-01', 'YYYY-MM-DD')
FROM fitness.gyms cross join fitness.items;

-- STEP 9
/* Filling PROGRAM_EXERCISES */
INSERT INTO FITNESS.program_exercises(exercise_id, program_id) SELECT EXERCISES.ID, PROGRAMS.ID
FROM fitness.exercises inner join fitness.programs on programs.name = 'Для похудения' and
(exercises.name = 'Бег' or exercises.name = 'Скручивания' or exercises.name = 'Гиперекстензия');
INSERT INTO FITNESS.program_exercises(exercise_id, program_id) SELECT EXERCISES.ID, PROGRAMS.ID
FROM fitness.exercises inner join fitness.programs on programs.name = 'Для сушки' and
(exercises.name = 'Бег' or exercises.name = 'Скручивания' or exercises.name = 'Гиперекстензия'
     or exercises.name = 'Присед');
INSERT INTO FITNESS.program_exercises(exercise_id, program_id) SELECT EXERCISES.ID, PROGRAMS.ID
FROM fitness.exercises inner join fitness.programs on programs.name = 'Для набора массы' and
(exercises.name = 'Присед' or exercises.name = 'Становая тяга' or exercises.name = 'Жим лежа'
     or exercises.name = 'Подьем штанги стоя на бицепс');
INSERT INTO FITNESS.program_exercises(exercise_id, program_id) SELECT EXERCISES.ID, PROGRAMS.ID
FROM fitness.exercises inner join fitness.programs on programs.name = 'Для увеличения силы' and
(exercises.name = 'Присед' or exercises.name = 'Становая тяга' or exercises.name = 'Жим лежа'
     or exercises.name = 'Подьем штанги стоя на бицепс' or exercises.name = 'Широкие подтягивания'
     or exercises.name = 'Жим гантелей сидя');
INSERT INTO FITNESS.program_exercises(exercise_id, program_id) SELECT EXERCISES.ID, PROGRAMS.ID
FROM fitness.exercises inner join fitness.programs on programs.name = 'С акцентом на жим' and
(exercises.name = 'Жим лежа с акцентом на трипес' or exercises.name = 'Жим лежа'
     or exercises.name = 'Французский жим лежа на трицепс' or exercises.name = 'Широкие подтягивания'
     or exercises.name = 'Жим гантелей сидя');
INSERT INTO FITNESS.program_exercises(exercise_id, program_id) SELECT EXERCISES.ID, PROGRAMS.ID
FROM fitness.exercises inner join fitness.programs on programs.name = 'С акцентом на ноги' and
(exercises.name = 'Присед' or exercises.name = 'Жим платформы ногами на тренажере'
     or exercises.name = 'Сгибание ног на тренажере'
     or exercises.name = 'Выпады');
INSERT INTO FITNESS.program_exercises(exercise_id, program_id) SELECT EXERCISES.ID, PROGRAMS.ID
FROM fitness.exercises inner join fitness.programs on programs.name = 'С акцентом на изолированные упражнения' and
(exercises.name = 'Разгибания на блоке на трицепс' or exercises.name = 'Подьем штанги стоя на бицепс'
     or exercises.name = 'Подьем штанги сидя на скамье Скотта'
     or exercises.name = 'Жим лежа с акцентом на трипес' or exercises.name = 'Подьем на блоке на бицепс'
     or exercises.name = 'Подьем гантелей на бицепс');

-- STEP 10
/* Adding gyms in which trainers work */
INSERT INTO FITNESS.trainers_gyms(trainer_id, gym_id) SELECT TRAINERS.ID, GYMS.ID
FROM fitness.trainers inner join fitness.gyms on trainers.name = 'Арнольд Шварцнегер'
and gyms.name = 'СК 1 МФТИ';
INSERT INTO FITNESS.trainers_gyms(trainer_id, gym_id) SELECT TRAINERS.ID, GYMS.ID
FROM fitness.trainers inner join fitness.gyms on trainers.name = 'Крис Хериа'
and gyms.name = 'СК 2 МФТИ';
INSERT INTO FITNESS.trainers_gyms(trainer_id, gym_id) SELECT TRAINERS.ID, GYMS.ID
FROM fitness.trainers inner join fitness.gyms on trainers.name = 'Виктор Блуд'
and gyms.name = 'SkyFit мытищи';
INSERT INTO FITNESS.trainers_gyms(trainer_id, gym_id) SELECT TRAINERS.ID, GYMS.ID
FROM fitness.trainers inner join fitness.gyms on trainers.name = 'Нилетто'
and gyms.name = 'Topdogfitness';
INSERT INTO FITNESS.trainers_gyms(trainer_id, gym_id) SELECT TRAINERS.ID, GYMS.ID
FROM fitness.trainers inner join fitness.gyms on trainers.name = 'Игорь Войтенко'
and gyms.name = 'Спортзал общежития 12';
INSERT INTO FITNESS.trainers_gyms(trainer_id, gym_id) SELECT TRAINERS.ID, GYMS.ID
FROM fitness.trainers inner join fitness.gyms on trainers.name = 'Джефф Ниппард'
and gyms.name = 'Fitness Formula на Спортивной';
INSERT INTO FITNESS.trainers_gyms(trainer_id, gym_id) SELECT TRAINERS.ID, GYMS.ID
FROM fitness.trainers inner join fitness.gyms on trainers.name = 'Евгений Сидоренко'
and gyms.name = 'WorldClass Metropolis';
INSERT INTO FITNESS.trainers_gyms(trainer_id, gym_id) SELECT TRAINERS.ID, GYMS.ID
FROM fitness.trainers inner join fitness.gyms on trainers.name = 'Михаил Баратов'
and gyms.name = 'King''s Gym РИО';
INSERT INTO FITNESS.trainers_gyms(trainer_id, gym_id) SELECT TRAINERS.ID, GYMS.ID
FROM fitness.trainers inner join fitness.gyms on trainers.name = 'Тайлер Дерден'
and gyms.name = 'SkyFit мытищи';
INSERT INTO FITNESS.trainers_gyms(trainer_id, gym_id) SELECT TRAINERS.ID, GYMS.ID
FROM fitness.trainers inner join fitness.gyms on trainers.name = 'Джейсон Стетхем'
and gyms.name = 'Iron Fitness на Спортивной';

-- STEP 11
/* Adding gyms in which athletes do workout */
/* Firstly process those having trainers - simpy add any gym */
INSERT INTO fitness.athletes_gyms(athlete_id, gym_id)  SELECT athletes.id, min(trainers_gyms.gym_id) FROM fitness.athletes inner join fitness.trainers_gyms
    on athletes.trainer_id = trainers_gyms.trainer_id group by athletes.id;
/* All who don't have gym will go gym with max id */
/*   This will find all without gym, used for debug
     SELECT * FROM fitness.athletes left join fitness.athletes_gyms on athletes.id = athletes_gyms.athlete_id where athletes_gyms.gym_id is null;
*/
INSERT INTO fitness.athletes_gyms(athlete_id, gym_id) SELECT athletes.id, max(gyms.id) FROM fitness.athletes inner join fitness.gyms
on athletes.trainer_id is null group by athletes.id;

-- FINISHED