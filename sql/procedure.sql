/* Procedure for deleting items from gyms */
CREATE PROCEDURE delete_item_from_gym(gym_title_arg varchar, item_title_arg varchar)
LANGUAGE SQL
AS $$
UPDATE fitness.gym_x_item set valid_to_dttm = now() WHERE gym_id in (SELECT gym.id from fitness.gym where gym.gym_title = gym_title_arg) and item_id
in (SELECT item.id from fitness.item where item_title = item_title_arg);
$$;

/* Usage example */
CALL delete_item_from_gym('СК 2 МФТИ', 'Скамейка');

/* Expected 0 rows since now on */
SELECT * from fitness.v_gym_x_item where item_title = 'Скамейка' and gym_title = 'СК 2 МФТИ';