/* Creating function to hide the name */
CREATE OR REPLACE FUNCTION mask_personal_name(name varchar)
RETURNS varchar AS $$
BEGIN
  RETURN overlay(name placing '*' from position(' ' in name) + 1 for length(name));
END;
$$ LANGUAGE plpgsql;


/* Creating views for each table */
-- STEP 1: athlete
create view fitness.v_athlete as select mask_personal_name(athlete_nm) as athlete_nm, mask_personal_name(trainer_nm) as trainer_nm, p.program_nm from fitness.athlete left join
    fitness.trainer on athlete.trainer_id = trainer.id
    inner join fitness.program p on athlete.program_id = p.id;

-- STEP 2: athlete gyms
create view fitness.v_athlete_x_gym as select mask_personal_name(athlete_nm) as athlete_nm, gym_title from fitness.athlete_x_gym inner join fitness.athlete a on
    a.id = athlete_x_gym.athlete_id inner join fitness.gym on athlete_x_gym.gym_id = gym.id;

-- STEP 3: exercise
create view fitness.v_exercise as select exercise_nm, muscles_nm from fitness.exercise;

-- STEP 4: exercise and items
create view fitness.v_exercise_x_item as select exercise_nm, item_title from fitness.exercise_x_item
    inner join fitness.exercise e on e.id = exercise_x_item.exercise_id inner join fitness.item i
        on i.id = exercise_x_item.item_id;

-- STEP 5: gym
create view fitness.v_gym as select gym_title, club_nm from fitness.gym;

-- STEP 6: gym and items
create view fitness.v_gym_x_item as select gym_title, item_title from fitness.gym_x_item inner join
    fitness.gym g on g.id = gym_x_item.gym_id inner join fitness.item i on i.id = gym_x_item.item_id;

-- STEP 7: items
create view fitness.v_item as select item_title from fitness.item;

-- STEP 8: programs
create view fitness.v_program as select program_nm from fitness.program;

-- STEP 9: programs and exercises
create view fitness.v_program_x_exercise as select program_nm, exercise_nm from fitness.program_x_exercise
    inner join fitness.exercise e on e.id = program_x_exercise.exercise_id inner join
    fitness.program p on p.id = program_x_exercise.program_id;

-- STEP 10: trainers
create view fitness.v_trainer as select mask_personal_name(trainer_nm) as trainer_nm from fitness.trainer;

-- STEP 11: trainers and gyms
create view fitness.v_trainer_x_gym as select mask_personal_name(trainer_nm) as trainer_nm, gym_title from fitness.trainer_x_gym
    inner join fitness.gym g on g.id = trainer_x_gym.gym_id inner join
    fitness.trainer t on t.id = trainer_x_gym.trainer_id;

-- ADDITIONAL VIEW - which athletes do which exercises
create view fitness.v_athlete_x_exercise as select mask_personal_name(athlete_nm) as athlete_nm, exercise_nm from fitness.athlete
    inner join fitness.program p on athlete.program_id = p.id inner join fitness.program_x_exercise pxe
        on athlete.program_id = pxe.program_id inner join fitness.exercise e on e.id = pxe.exercise_id;

-- ADDITIONAL VIEW - which trainers love which programs
create view fitness.v_trainers_x_program as select mask_personal_name(trainer_nm) as trainer_nm, program_nm from fitness.athlete inner join fitness.trainer t on t.id = athlete.trainer_id
inner join fitness.program p on p.id = athlete.program_id;