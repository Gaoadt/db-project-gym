/* CRUD QUERIES */
-- STEP 1: ATHLETES
SELECT * from fitness.athlete;
INSERT INTO fitness.athlete(athlete_nm, program_id)
 SELECT 'Ганибал Кинг', PROGRAM.ID from fitness.program where program_nm = 'Для набора массы';
UPDATE fitness.athlete SET athlete_nm = 'Haniball King' where athlete_nm = 'Ганибал Кинг';
DELETE FROM fitness.athlete where athlete_nm = 'Haniball King';

-- STEP 2: ATHLETE GYMS
SELECT * FROM fitness.athlete;
DELETE FROM fitness.athlete_x_gym WHERE ATHLETE_ID in (SELECT athlete.id from fitness.athlete where athlete.athlete_nm = 'Григорий Минаков');
INSERT INTO fitness.athlete_x_gym(athlete_id, gym_id) SELECT athlete.id, gym.id from fitness.athlete inner join fitness.gym
ON athlete.athlete_nm = 'Григорий Минаков' and gym.gym_title = 'СК 2 МФТИ';

-- STEP 3: EXERCISE ITEMS
SELECT * from fitness.exercise_x_item;
INSERT INTO fitness.exercise_x_item(exercise_id, item_id) SELECT exercise.id, item.id from fitness.exercise inner join fitness.item
on exercise.exercise_nm = 'Жим гантелей сидя' and item.item_title = 'Штанга';
/* ЗАЧЕМ ДЛЯ ЖИМА ГАНТЕЛЕЙ ШТАНГА А?*/
DELETE FROM fitness.exercise_x_item where (exercise_id, item_id) in (SELECT exercise.id, item.id from fitness.exercise inner join fitness.item
on exercise.exercise_nm = 'Жим гантелей сидя' and item.item_title = 'Штанга');

-- STEP 4: EXERCISES
SELECT * from fitness.exercise;
INSERT INTO fitness.exercise(exercise_nm, muscles_nm) VALUES ('Выход на две', 'Плечи');
UPDATE fitness.exercise set muscles_nm = 'Грудь' WHERE exercise_nm = 'Выход на два';
DELETE FROM fitness.exercise where exercise_nm = 'Выход на две';

-- STEP 5: GYM ITEMS
/* Штанга сломалась */
UPDATE fitness.gym_x_item set valid_to_dttm = now() WHERE gym_id in (SELECT gym.id from fitness.gym where gym.gym_title = 'СК 1 МФТИ') and item_id
in (SELECT item.id from fitness.item where item_title = 'Штанга');
/* Удаляем устаревшие данные из версионной таблицы */
DELETE FROM fitness.gym_x_item where gym_x_item.valid_to_dttm < now();
/* Купили новую */
INSERT INTO fitness.gym_x_item(item_id, gym_id) SELECT item.id, gym.id from fitness.item inner join
    fitness.gym on item.item_title = 'Штанга' and gym.gym_title = 'СК 2 МФТИ';

-- STEP 6: GYMS
INSERT INTO fitness.gym(gym_title, club_nm) VALUES ('Стадион МФТИ', 'МФТИ');
/* Сгорел вместе с курилкой*/
/* Here we have to carefully delete fks */
DELETE FROM fitness.athlete_x_gym where gym_id in (SELECT id from fitness.gym where gym_title = 'Спортзал общежития 2');
DELETE FROM fitness.gym_x_item where gym_id in (SELECT id from fitness.gym where gym_title = 'Спортзал общежития 2');
DELETE FROM  fitness.gym where gym_title = 'Спортзал общежития 2';

-- STEP 7: ITEMS
INSERT INTO fitness.item(item_title) VALUES ('Мячик');
UPDATE fitness.item set item_title = 'Фигня' where item_title = 'Мячик';
DELETE FROM fitness.item where item_title = 'Фигня';
SELECT item_title from fitness.item;

-- STEP 8: PROGRAM EXERCISES
INSERT INTO FITNESS.program_x_exercise(exercise_id, program_id) SELECT EXERCISE.ID, PROGRAM.ID
FROM fitness.exercise inner join fitness.program on program.program_nm = 'С акцентом на изолированные упражнения' and
(exercise.exercise_nm = 'Махи с гантелями в стороны');
/* Удалим махи из всех программ */
DELETE FROM FITNESS.program_x_exercise where exercise_id in (SELECT id from fitness.exercise where exercise_nm = 'Махи с гантелями в стороны');

-- STEP 9: PROGRAMS
SELECT program_nm from fitness.program;
INSERT INTO fitness.program(program_nm) values ('Калистетика');
UPDATE fitness.program set program_nm = 'Calithetics' where program_nm = 'Калистетика';
DELETE FROM fitness.program where program_nm = 'Calithetics';

-- STEP 10: TRAINERS
SELECT * from fitness.trainer;
INSERT INTO fitness.trainer(trainer_nm) values ('Мик Джаггер');
UPDATE fitness.trainer set trainer_nm = 'Mick Jagger' where trainer_nm = 'Мик Джаггер';
DELETE from fitness.trainer where trainer_nm = 'Mick Jagger';

-- STEP 11: TRAINERS GYMS
SELECT * from fitness.trainer_x_gym;
INSERT INTO FITNESS.trainer_x_gym(trainer_id, gym_id) SELECT TRAINER.ID, GYM.ID
FROM fitness.trainer inner join fitness.gym on trainer.trainer_nm = 'Арнольд Шварцнегер'
and gym.gym_title = 'СК 2 МФТИ';
DELETE from fitness.trainer_x_gym where (trainer_id, gym_id) in
(SELECT trainer.id, gym.id from fitness.trainer inner join fitness.gym
    on trainer.trainer_nm = 'Арнольд Шварцнегер' and gym.gym_title = 'СК 1 МФТИ');