/* Выяснить какие же группы мышщ развивает программа для набора массы в алфавитном порядке */
SELECT exercise.muscles_nm from fitness.exercise inner join fitness.program_x_exercise on exercise.id = program_x_exercise.exercise_id
    inner join fitness.program on program.id = program_x_exercise.program_id and program.program_nm = 'Для набора массы' order by muscles_nm;

/* Выяснит у какого тренера занимается сколько атлетов */
SELECT trainer.trainer_nm, count(athlete.id) from fitness.trainer inner join fitness.athlete on trainer.id = athlete.trainer_id group by trainer.trainer_nm;

/* Выяснить сколько атлетов занимаются по определнной программе среди тех у которых нет тренера в названии которых имеет вид Для.. тралалал*/
SELECT program.program_nm, count(athlete.id) from fitness.program inner join fitness.athlete on program.id = athlete.program_id group by program.program_nm
having program.program_nm like 'Для%';

/* Выяснить у какого фитнесс клубов сколько залов, среди тех у кого их несколько */
SELECT club_nm, count(gym.gym_title) from fitness.gym group by club_nm having count(gym.gym_title) > 1;

/* Вывести список пар упражнение - программа указав для каждого упражнения число программ тренировок его включающих*/
SELECT exercise.exercise_nm, program.program_nm, count(*) over (partition by exercise_id) as program_count
 from fitness.exercise
inner join fitness.program_x_exercise on exercise.id = program_x_exercise.exercise_id inner join fitness.program
on program_x_exercise.program_id = program.id;