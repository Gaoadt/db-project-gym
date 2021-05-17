CREATE SCHEMA FITNESS;
CREATE TABLE FITNESS.PROGRAMS(
    ID      SERIAL,
    NAME    VARCHAR(100)    NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE FITNESS.EXERCISES(
    ID      SERIAL,
    NAME    VARCHAR(100)    NOT NULL,
    MUSCLES VARCHAR(200)    NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE FITNESS.ITEMS(
    ID      SERIAL,
    NAME    VARCHAR(100)    NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE FITNESS.GYMS(
    ID      SERIAL,
    NAME    VARCHAR(200)    NOT NULL,
    CLUB    VARCHAR(200)    NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE FITNESS.TRAINERS(
    ID      SERIAL,
    NAME    VARCHAR(100)    NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE FITNESS.ATHLETES(
    ID      SERIAL,
    NAME    VARCHAR(100)    NOT NULL,
    TRAINER_ID INT,
    PROGRAM_ID INT          NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (TRAINER_ID) REFERENCES FITNESS.TRAINERS(ID),
    FOREIGN KEY (PROGRAM_ID) REFERENCES FITNESS.PROGRAMS(ID)
);

CREATE TABLE FITNESS.PROGRAM_EXERCISES(
    EXERCISE_ID INT,
    PROGRAM_ID INT,
    PRIMARY KEY (EXERCISE_ID, PROGRAM_ID),
    FOREIGN KEY (EXERCISE_ID) REFERENCES FITNESS.EXERCISES(ID),
    FOREIGN KEY (PROGRAM_ID) REFERENCES FITNESS.PROGRAMS(ID)
);

CREATE TABLE FITNESS.EXERCISE_ITEMS(
    EXERCISE_ID INT,
    ITEM_ID INT,
    PRIMARY KEY (EXERCISE_ID, ITEM_ID),
    FOREIGN KEY (EXERCISE_ID) REFERENCES FITNESS.EXERCISES(ID),
    FOREIGN KEY (ITEM_ID) REFERENCES FITNESS.ITEMS(ID)
);

CREATE TABLE FITNESS.ATHLETES_GYMS(
    ATHLETE_ID INT,
    GYM_ID INT,
    PRIMARY KEY (ATHLETE_ID, GYM_ID),
    FOREIGN KEY (ATHLETE_ID) REFERENCES FITNESS.ATHLETES(ID),
    FOREIGN KEY (GYM_ID) REFERENCES FITNESS.GYMS(ID)
);

CREATE TABLE FITNESS.TRAINERS_GYMS(
    TRAINER_ID INT,
    GYM_ID INT,
    PRIMARY KEY (TRAINER_ID, GYM_ID),
    FOREIGN KEY (TRAINER_ID) REFERENCES FITNESS.TRAINERS(ID),
    FOREIGN KEY (GYM_ID) REFERENCES FITNESS.GYMS(ID)
);

CREATE TABLE FITNESS.GYM_ITEMS(
    ITEM_ID INT,
    GYM_ID INT,
    TIME_FROM   TIMESTAMP     NOT NULL,
    TIME_TO     TIMESTAMP     NOT NULL,
    PRIMARY KEY (ITEM_ID, GYM_ID, TIME_FROM),
    FOREIGN KEY (ITEM_ID) REFERENCES FITNESS.ITEMS(ID),
    FOREIGN KEY (GYM_ID) REFERENCES FITNESS.GYMS(ID)
);