-- STEP 1
/* Extracting gym data from csv */
COPY FITNESS.GYM(gym_title, club_nm) FROM '/data/gyms.csv'
DELIMITER ',' CSV HEADER;
/* It was closed due to fire but anyway */
INSERT INTO FITNESS.GYM (gym_title, club_nm) VALUES ('Спортзал общежития 2', 'МФТИ');

-- STEP 2
/* Extracting exercise data from csv */
COPY FITNESS.EXERCISE(exercise_nm, muscles_nm) FROM '/data/exercises.csv'
DELIMITER ',' CSV HEADER;
INSERT INTO FITNESS.EXERCISE(exercise_nm, muscles_nm) VALUES ('Отжимания на брусьях', 'Грудь');
INSERT INTO FITNESS.EXERCISE(exercise_nm, muscles_nm) VALUES ('Бег', 'Кардио');

-- STEP 3
/* Extracting item data from csv */
COPY FITNESS.ITEM(item_title) FROM '/data/items.csv'
DELIMITER ',' CSV HEADER;
INSERT INTO FITNESS.ITEM(item_title) VALUES ('Брусья');
INSERT INTO FITNESS.ITEM(item_title) VALUES ('Беговая дорожка');

-- STEP 4
/* Extracting program data from csv */
COPY FITNESS.PROGRAM(program_nm)  FROM '/data/programs.csv'
DELIMITER ',' CSV HEADER;
INSERT INTO FITNESS.PROGRAM(program_nm) VALUES ('Для сушки');

-- STEP 5
/* Extracting trainer data from csv */
COPY FITNESS.TRAINER(trainer_nm) FROM '/data/trainers.csv'
DELIMITER ',' CSV HEADER;
INSERT INTO FITNESS.TRAINER(trainer_nm) VALUES ('Арнольд Шварцнегер');

-- STEP 6
/* Inserting athlete */
/* Those who don't have trainer */
INSERT INTO FITNESS.athlete(PROGRAM_ID, athlete_nm) SELECT ID, 'Петр Петрович'
FROM FITNESS.program WHERE program_nm = 'Для набора массы';
INSERT INTO FITNESS.athlete(PROGRAM_ID, athlete_nm) SELECT ID, 'Алексей Иванович'
FROM FITNESS.program WHERE program_nm = 'Для увеличения силы';
INSERT INTO FITNESS.athlete(PROGRAM_ID, athlete_nm) SELECT ID, 'Василий Игнатьевич'
FROM FITNESS.program WHERE program_nm = 'С акцентом на жим';
INSERT INTO FITNESS.athlete(PROGRAM_ID, athlete_nm) SELECT ID, 'Эдвард Нортон'
FROM FITNESS.program WHERE program_nm = 'С акцентом на ноги';
INSERT INTO FITNESS.athlete(PROGRAM_ID, athlete_nm) SELECT ID, 'Брюс Уиллис'
FROM FITNESS.program WHERE program_nm = 'Для увеличения силы';
INSERT INTO FITNESS.athlete(PROGRAM_ID, athlete_nm) SELECT ID, 'Алексей Иванов'
FROM FITNESS.program WHERE program_nm = 'Для сушки';
/* Those who have professional trainer */
INSERT INTO FITNESS.athlete(PROGRAM_ID, TRAINER_ID, athlete_nm) SELECT program.ID, trainer.ID, 'Ваня Ванич'
FROM FITNESS.program INNER JOIN FITNESS.trainer ON trainer.trainer_nm = 'Крис Хериа' AND program.program_nm='С акцентом на ноги';
INSERT INTO FITNESS.athlete(PROGRAM_ID, TRAINER_ID, athlete_nm) SELECT program.ID, trainer.ID, 'Григорий Минаков'
FROM FITNESS.program INNER JOIN FITNESS.trainer ON trainer.trainer_nm = 'Виктор Блуд' AND program.program_nm='С акцентом на изолированные упражнения';
INSERT INTO FITNESS.athlete(PROGRAM_ID, TRAINER_ID, athlete_nm) SELECT program.ID, trainer.ID, 'Петя Петич'
FROM FITNESS.program INNER JOIN FITNESS.trainer ON trainer.trainer_nm = 'Джефф Ниппард' AND program.program_nm='Для увеличения силы';
INSERT INTO FITNESS.athlete(PROGRAM_ID, TRAINER_ID, athlete_nm) SELECT program.ID, trainer.ID, 'Леха Лехыч'
FROM FITNESS.program INNER JOIN FITNESS.trainer ON trainer.trainer_nm = 'Михаил Баратов' AND program.program_nm='Для увеличения силы';
INSERT INTO FITNESS.athlete(PROGRAM_ID, TRAINER_ID, athlete_nm) SELECT program.ID, trainer.ID, 'Дима Димыч'
FROM FITNESS.program INNER JOIN FITNESS.trainer ON trainer.trainer_nm = 'Михаил Баратов' AND program.program_nm='С акцентом на изолированные упражнения';
INSERT INTO FITNESS.athlete(PROGRAM_ID, TRAINER_ID, athlete_nm) SELECT program.ID, trainer.ID, 'Тима Тимыч'
FROM FITNESS.program INNER JOIN FITNESS.trainer ON trainer.trainer_nm = 'Арнольд Шварцнегер' AND program.program_nm='Для увеличения силы';

-- STEP 7
/* Inserting exercise item */
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Подьем штанги стоя на бицепс'
AND item.item_title = 'Штанга';
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Подьем штанги сидя на скамье Скотта'
AND (item.item_title = 'Штанга' OR item.item_title = 'Скамья Скотта');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Французский жим лежа на трицепс'
AND (item.item_title = 'Штанга' OR item.item_title = 'Скамейка' OR item.item_title = 'Набор блинов');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Жим лежа с акцентом на трипес'
AND (item.item_title = 'Штанга' OR item.item_title = 'Скамейка' OR item.item_title = 'Набор блинов');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Подьем на блоке на бицепс'
AND (item.item_title = 'Блочный тренажер');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Подьем гантелей на бицепс'
AND (item.item_title = 'Набор гантелей');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Жим гантелей сидя'
AND (item.item_title = 'Набор гантелей' OR item.item_title = 'Скамейка');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Жим гантелей стоя'
AND (item.item_title = 'Набор гантелей');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Широкие подтягивания'
AND (item.item_title = 'Турник');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Подтягивания обратным хватом'
AND (item.item_title = 'Турник');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Разведение гантелей на грудь'
AND (item.item_title = 'Набор гантелей' OR item.item_title = 'Скамейка');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Подьем ног на турнике'
AND (item.item_title = 'Турник');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Подьем ног на брусьях'
AND (item.item_title = 'Брусья');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Присед'
AND (item.item_title = 'Штанга' OR item.item_title = 'Набор блинов');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Сгибание ног на тренажере'
AND (item.item_title = 'Тренажер на икры');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Жим платформы ногами на тренажере'
AND (item.item_title = 'Тренажер для жима платформы ногами');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Махи с гантелями в стороны'
AND (item.item_title = 'Набор гантелей');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Становая тяга'
AND (item.item_title = 'Штанга' OR item.item_title = 'Набор блинов');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Гиперекстензия'
AND (item.item_title = 'Упор для гиперэкстензии');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Отжимания на брусьях'
AND (item.item_title = 'Брусья');
INSERT INTO FITNESS.exercise_x_item(exercise_id, item_id) SELECT exercise.ID, item.ID
FROM fitness.exercise inner join fitness.item ON exercise.exercise_nm = 'Бег'
AND (item.item_title = 'Беговая дорожка');

-- STEP 8
/* Filling GYM_item. Let us think that every respectful gym has all the equipment,
   at least at the very beginning, cause it is scd 2 table.
*/

INSERT INTO FITNESS.gym_x_item(item_id, gym_id) SELECT item.ID, gym.ID
FROM fitness.gym cross join fitness.item;

-- STEP 9
/* Filling PROGRAM_exercise */
INSERT INTO FITNESS.program_x_exercise(exercise_id, program_id) SELECT exercise.ID, program.ID
FROM fitness.exercise inner join fitness.program on program.program_nm = 'Для похудения' and
(exercise.exercise_nm = 'Бег' or exercise.exercise_nm = 'Скручивания' or exercise.exercise_nm = 'Гиперекстензия');
INSERT INTO FITNESS.program_x_exercise(exercise_id, program_id) SELECT exercise.ID, program.ID
FROM fitness.exercise inner join fitness.program on program.program_nm = 'Для сушки' and
(exercise.exercise_nm = 'Бег' or exercise.exercise_nm = 'Скручивания' or exercise.exercise_nm = 'Гиперекстензия'
     or exercise.exercise_nm = 'Присед');
INSERT INTO FITNESS.program_x_exercise(exercise_id, program_id) SELECT exercise.ID, program.ID
FROM fitness.exercise inner join fitness.program on program.program_nm = 'Для набора массы' and
(exercise.exercise_nm = 'Присед' or exercise.exercise_nm = 'Становая тяга' or exercise.exercise_nm = 'Жим лежа'
     or exercise.exercise_nm = 'Подьем штанги стоя на бицепс');
INSERT INTO FITNESS.program_x_exercise(exercise_id, program_id) SELECT exercise.ID, program.ID
FROM fitness.exercise inner join fitness.program on program.program_nm = 'Для увеличения силы' and
(exercise.exercise_nm = 'Присед' or exercise.exercise_nm = 'Становая тяга' or exercise.exercise_nm = 'Жим лежа'
     or exercise.exercise_nm = 'Подьем штанги стоя на бицепс' or exercise.exercise_nm = 'Широкие подтягивания'
     or exercise.exercise_nm = 'Жим гантелей сидя');
INSERT INTO FITNESS.program_x_exercise(exercise_id, program_id) SELECT exercise.ID, program.ID
FROM fitness.exercise inner join fitness.program on program.program_nm = 'С акцентом на жим' and
(exercise.exercise_nm = 'Жим лежа с акцентом на трипес' or exercise.exercise_nm = 'Жим лежа'
     or exercise.exercise_nm = 'Французский жим лежа на трицепс' or exercise.exercise_nm = 'Широкие подтягивания'
     or exercise.exercise_nm = 'Жим гантелей сидя');
INSERT INTO FITNESS.program_x_exercise(exercise_id, program_id) SELECT exercise.ID, program.ID
FROM fitness.exercise inner join fitness.program on program.program_nm = 'С акцентом на ноги' and
(exercise.exercise_nm = 'Присед' or exercise.exercise_nm = 'Жим платформы ногами на тренажере'
     or exercise.exercise_nm = 'Сгибание ног на тренажере'
     or exercise.exercise_nm = 'Выпады');
INSERT INTO FITNESS.program_x_exercise(exercise_id, program_id) SELECT exercise.ID, program.ID
FROM fitness.exercise inner join fitness.program on program.program_nm = 'С акцентом на изолированные упражнения' and
(exercise.exercise_nm = 'Разгибания на блоке на трицепс' or exercise.exercise_nm = 'Подьем штанги стоя на бицепс'
     or exercise.exercise_nm = 'Подьем штанги сидя на скамье Скотта'
     or exercise.exercise_nm = 'Жим лежа с акцентом на трипес' or exercise.exercise_nm = 'Подьем на блоке на бицепс'
     or exercise.exercise_nm = 'Подьем гантелей на бицепс');

-- STEP 10
/* Adding gym in which trainer work */
INSERT INTO FITNESS.trainer_x_gym(trainer_id, gym_id) SELECT trainer.ID, gym.ID
FROM fitness.trainer inner join fitness.gym on trainer.trainer_nm = 'Арнольд Шварцнегер'
and gym.gym_title = 'СК 1 МФТИ';
INSERT INTO FITNESS.trainer_x_gym(trainer_id, gym_id) SELECT trainer.ID, gym.ID
FROM fitness.trainer inner join fitness.gym on trainer.trainer_nm = 'Крис Хериа'
and gym.gym_title = 'СК 2 МФТИ';
INSERT INTO FITNESS.trainer_x_gym(trainer_id, gym_id) SELECT trainer.ID, gym.ID
FROM fitness.trainer inner join fitness.gym on trainer.trainer_nm = 'Виктор Блуд'
and gym.gym_title = 'SkyFit мытищи';
INSERT INTO FITNESS.trainer_x_gym(trainer_id, gym_id) SELECT trainer.ID, gym.ID
FROM fitness.trainer inner join fitness.gym on trainer.trainer_nm = 'Нилетто'
and gym.gym_title = 'Topdogfitness';
INSERT INTO FITNESS.trainer_x_gym(trainer_id, gym_id) SELECT trainer.ID, gym.ID
FROM fitness.trainer inner join fitness.gym on trainer.trainer_nm = 'Игорь Войтенко'
and gym.gym_title = 'Спортзал общежития 12';
INSERT INTO FITNESS.trainer_x_gym(trainer_id, gym_id) SELECT trainer.ID, gym.ID
FROM fitness.trainer inner join fitness.gym on trainer.trainer_nm = 'Джефф Ниппард'
and gym.gym_title = 'Fitness Formula на Спортивной';
INSERT INTO FITNESS.trainer_x_gym(trainer_id, gym_id) SELECT trainer.ID, gym.ID
FROM fitness.trainer inner join fitness.gym on trainer.trainer_nm = 'Евгений Сидоренко'
and gym.gym_title = 'WorldClass Metropolis';
INSERT INTO FITNESS.trainer_x_gym(trainer_id, gym_id) SELECT trainer.ID, gym.ID
FROM fitness.trainer inner join fitness.gym on trainer.trainer_nm = 'Михаил Баратов'
and gym.gym_title = 'King''s Gym РИО';
INSERT INTO FITNESS.trainer_x_gym(trainer_id, gym_id) SELECT trainer.ID, gym.ID
FROM fitness.trainer inner join fitness.gym on trainer.trainer_nm = 'Тайлер Дерден'
and gym.gym_title = 'SkyFit мытищи';
INSERT INTO FITNESS.trainer_x_gym(trainer_id, gym_id) SELECT trainer.ID, gym.ID
FROM fitness.trainer inner join fitness.gym on trainer.trainer_nm = 'Джейсон Стетхем'
and gym.gym_title = 'Iron Fitness на Спортивной';

-- STEP 11
/* Adding gym in which athlete do workout */
/* Firstly process those having trainer - simpy add any gym */
INSERT INTO fitness.athlete_x_gym(athlete_id, gym_id)  SELECT athlete.id, min(trainer_x_gym.gym_id) FROM fitness.athlete inner join fitness.trainer_x_gym
    on athlete.trainer_id = trainer_x_gym.trainer_id group by athlete.id;
/* All who don't have gym will go gym with max id */
/*   This will find all without gym, used for debug
     SELECT * FROM fitness.athlete left join fitness.athlete_gym on athlete.id = athlete_gym.athlete_id where athlete_gym.gym_id is null;
*/
INSERT INTO fitness.athlete_x_gym(athlete_id, gym_id) SELECT athlete.id, max(gym.id) FROM fitness.athlete inner join fitness.gym
on athlete.trainer_id is null group by athlete.id;

-- FINISHED