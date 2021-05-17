/* Выяснить какие же группы мышщ развивает программа для набора массы в алфавитном порядке */
SELECT exercises.muscles from fitness.exercises inner join fitness.program_exercises on exercises.id = program_exercises.exercise_id
    inner join fitness.programs on programs.id = program_exercises.program_id and programs.name = 'Для набора массы' order by muscles;

/* Выяснит у какого тренера занимается сколько атлетов */
SELECT trainers.name, count(athletes.id) from fitness.trainers inner join fitness.athletes on trainers.id = athletes.trainer_id group by trainers.name;

/* Выяснить сколько атлетов занимаются по определнной программе среди тех у которых нет тренера в названии которых имеет вид Для.. тралалал*/
SELECT programs.name, count(athletes.id) from fitness.programs inner join fitness.athletes on programs.id = athletes.program_id group by programs.name
having programs.name like 'Для%';

/* Выяснить у какого зала сколько фитнесс клубов, среди тех у кого их несколько */
SELECT club, count(gyms.name) from fitness.gyms group by club having count(name) > 1;

/* Вывести список пар упражнение - программа указав для каждого упражнения число программ тренировок его включающих*/
SELECT exercises.name, programs.name, count(*) over (partition by exercise_id) as program_count
 from fitness.exercises
inner join fitness.program_exercises on exercises.id = program_exercises.exercise_id inner join fitness.programs
on program_exercises.program_id = programs.id;