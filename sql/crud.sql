/* CRUD QUERIES */
-- STEP 1: ATHLETES
SELECT * from fitness.athletes;
INSERT INTO fitness.athletes(name, program_id)
 SELECT 'Ганибал Кинг', PROGRAMS.ID from fitness.programs where name = 'Для набора массы';
UPDATE fitness.athletes SET name = 'Haniball King' where name = 'Ганибал Кинг';
DELETE FROM fitness.athletes where name = 'Haniball King';

-- STEP 2: ATHLETE GYMS
SELECT * FROM fitness.athletes;
DELETE FROM fitness.athletes_gyms WHERE ATHLETE_ID in (SELECT athletes.id from fitness.athletes where athletes.name = 'Григорий Минаков');
INSERT INTO fitness.athletes_gyms(athlete_id, gym_id) SELECT athletes.id, gyms.id from fitness.athletes inner join fitness.gyms
ON athletes.name = 'Григорий Минаков' and gyms.name = 'СК 2 МФТИ';

-- STEP 3: EXERCISE ITEMS
SELECT * from fitness.exercise_items;
INSERT INTO fitness.exercise_items(exercise_id, item_id) SELECT exercises.id, items.id from fitness.exercises inner join fitness.items
on exercises.name = 'Жим гантелей сидя' and items.name = 'Штанга';
/* ЗАЧЕМ ДЛЯ ЖИМА ГАНТЕЛЕЙ ШТАНГА А?*/
DELETE FROM fitness.exercise_items where (exercise_id, item_id) in (SELECT exercises.id, items.id from fitness.exercises inner join fitness.items
on exercises.name = 'Жим гантелей сидя' and items.name = 'Штанга');

-- STEP 4: EXERCISES
SELECT * from fitness.exercises;
INSERT INTO fitness.exercises(name, muscles) VALUES ('Выход на две', 'Плечи');
UPDATE fitness.exercises set muscles = 'Грудь' WHERE name = 'Выход на два';
DELETE FROM fitness.exercises where name = 'Выход на две';

-- STEP 5: GYM ITEMS
/* Штанга сломалась */
UPDATE fitness.gym_items set time_to = now() WHERE gym_id in (SELECT gyms.id from fitness.gyms where  gyms.name = 'СК 1 МФТИ') and item_id
in (SELECT items.id from fitness.items where name = 'Штанга');
/* Удаляем устаревшие данные из версионной таблицы */
DELETE FROM fitness.gym_items where time_to < now();
/* Купили новую */
INSERT INTO fitness.gym_items(item_id, gym_id) SELECT items.id, gyms.id from fitness.items inner join
    fitness.gyms on items.name = 'Штанга' and gyms.name = 'СК 2 МФТИ';

-- STEP 6: GYMS
INSERT INTO fitness.gyms(name, club) VALUES ('Стадион МФТИ', 'МФТИ');
/* Сгорел вместе с курилкой*/
/* Here we have to carefully delete fks */
DELETE FROM fitness.athletes_gyms where gym_id in (SELECT id from fitness.gyms where name = 'Спортзал общежития 2');
DELETE FROM fitness.gym_items where gym_id in (SELECT id from fitness.gyms where name = 'Спортзал общежития 2');
DELETE FROM  fitness.gyms where name = 'Спортзал общежития 2';

-- STEP 7: ITEMS
INSERT INTO fitness.items(name) VALUES ('Мячик');
UPDATE fitness.items set name = 'Фигня' where name = 'Мячик';
DELETE FROM fitness.items where name = 'Фигня';
SELECT name from fitness.items;

-- STEP 8: PROGRAM EXERCISES
INSERT INTO FITNESS.program_exercises(exercise_id, program_id) SELECT EXERCISES.ID, PROGRAMS.ID
FROM fitness.exercises inner join fitness.programs on programs.name = 'С акцентом на изолированные упражнения' and
(exercises.name = 'Махи с гантелями в стороны');
/* Удалим махи из всех программ */
DELETE FROM FITNESS.program_exercises where exercise_id in (SELECT id from fitness.exercises where name = 'Махи с гантелями в стороны');

-- STEP 9: PROGRAMS
SELECT name from fitness.programs;
INSERT INTO fitness.programs(name) values ('Калистетика');
UPDATE fitness.programs set name = 'Calithetics' where name = 'Калистетика';
DELETE FROM fitness.programs where name = 'Calithetics';

-- STEP 10: TRAINERS
SELECT * from fitness.trainers;
INSERT INTO fitness.trainers(name) values ('Мик Джаггер');
UPDATE fitness.trainers set name = 'Mick Jagger' where name = 'Мик Джаггер';
DELETE from fitness.trainers where name = 'Mick Jagger';

-- STEP 11: TRAINERS GYMS
SELECT * from fitness.trainers_gyms;
INSERT INTO FITNESS.trainers_gyms(trainer_id, gym_id) SELECT TRAINERS.ID, GYMS.ID
FROM fitness.trainers inner join fitness.gyms on trainers.name = 'Арнольд Шварцнегер'
and gyms.name = 'СК 2 МФТИ';
DELETE from fitness.trainers_gyms where (trainer_id, gym_id) in
(SELECT trainers.id, gyms.id from fitness.trainers inner join fitness.gyms
    on trainers.name = 'Арнольд Шварцнегер' and gyms.name = 'СК 1 МФТИ');