/* Creating trigger to support cascading delete for trainer */
CREATE OR REPLACE FUNCTION delete_trainer() RETURNS trigger
LANGUAGE plpgsql
AS $$
begin
UPDATE fitness.athlete set trainer_id = NULL where trainer_id in (SELECT trainer_id from fitness.trainer where trainer_nm = old.trainer_nm);
DELETE FROM fitness.trainer_x_gym where trainer_id in (SELECT trainer_id from fitness.trainer where trainer_nm = old.trainer_nm);
return old;
end
$$;

/* Call the above function before delete on each row*/
CREATE TRIGGER trainer_delete_trigger
BEFORE DELETE on fitness.trainer
FOR EACH ROW
EXECUTE PROCEDURE delete_trainer();

/* Check that work */
DELETE FROM fitness.trainer where trainer_nm = 'Виктор Блуд';

/* Now lets add cascading delete for athletes */
CREATE OR REPLACE FUNCTION delete_athlete() RETURNS trigger
LANGUAGE plpgsql
AS $$
begin
DELETE FROM fitness.athlete_x_gym where athlete_id = OLD.id;
return old;
end
$$;

/* Call the above function before delete on each row*/
CREATE TRIGGER athlete_delete_trigger
BEFORE DELETE on fitness.athlete
FOR EACH ROW
EXECUTE PROCEDURE delete_athlete();

/* Check that above works */
DELETE FROM fitness.athlete where athlete_nm = 'Григорий Минаков';