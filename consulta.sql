CREATE TABLE "roles" (
  "id" uuid PRIMARY KEY,
  "name" varchar NOT NULL
);

insert into roles (id, name) 
values('738b2005-bbfe-4833-8bb6-c9c74b96c22f', 'student'),
	  ('760f6d82-d744-4087-aacc-0416f36333a9', 'teacher'),
	  ('134d8dc7-e622-49ec-8a08-edf049eb7bbe', 'admin');


CREATE TABLE "users" (
  "id" uuid PRIMARY KEY,
  "name" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "age" varchar NOT NULL,
  "roles_id" uuid NOT NULL
);

ALTER TABLE "users" ADD FOREIGN KEY ("roles_id") REFERENCES "roles" ("id");

insert into users (id, name, email, password, age, roles_id) 
values('4c141fc7-8bb2-4342-90cb-2f5020a430cd','robert','abc@gmail.com','123', '30', '738b2005-bbfe-4833-8bb6-c9c74b96c22f'),
	  ('f27ba5e1-47c3-4711-8019-371e6c468ea3','ramon','def@gmail.com','456', '20', '760f6d82-d744-4087-aacc-0416f36333a9'),
	  ('edb0d10c-db9c-4bf6-8804-5c3f7f20939f','javier','ghi@gmail.com','789', '40', '134d8dc7-e622-49ec-8a08-edf049eb7bbe');

	 
CREATE TABLE "categories" (
  "id" uuid PRIMARY KEY,
  "name" varchar NOT NULL
);

insert into categories (id, name) 
values('82adc6fb-95b4-496e-ad5f-8f0309ca6666','front-end'),
	  ('bb362c47-64fd-4bf4-9653-e0aa5962efc4','back-end'),
	  ('d364ab5b-8b08-4211-91ec-1f1fe50fac36','front-end');

CREATE TABLE "course_videos" (
  "id" uuid PRIMARY KEY,
  "title" varchar NOT NULL,
  "url" varchar NOT NULL,
  "categories_id" uuid NOT NULL
);

ALTER TABLE "course_videos" ADD FOREIGN KEY ("categories_id") REFERENCES "categories" ("id");

insert into course_videos (id, title, url, categories_id) 
values('64f4044a-f84a-4b47-8c25-f50b6f0429ee','react', 'www.react.com', '82adc6fb-95b4-496e-ad5f-8f0309ca6666'),
	  ('b3553f29-9cab-4911-9e45-9bed00a8c648','node', 'www.node.com','bb362c47-64fd-4bf4-9653-e0aa5962efc4'),
	  ('0db8630e-b96b-45d0-ba54-6aa4883a6ed0','javascript', 'www.javascript.com','d364ab5b-8b08-4211-91ec-1f1fe50fac36');

CREATE TABLE "teacher" (
  "id" uuid PRIMARY KEY,
  "name" varchar NOT NULL,
  "title" varchar NOT NULL
);

insert into teacher (id, name) 
values('64f8341d-3362-4e5a-8efc-d6625f2811c3','juan'),
	  ('68db8bae-298f-49c1-ad6e-0d1d9ef8fdf0','alberto'),
	  ('bbad8707-72c0-4de0-9d59-c722e7a2062e','benjamin');
	 
CREATE TABLE "level" (
  "id" uuid PRIMARY KEY,
  "name" varchar NOT NULL
);

insert into "level"  (id, name) 
values('eb7b471b-3a6b-454d-a2f4-a8f6f2ccf0e5','principiante'),
	  ('950b0abd-80b2-4a1e-bbd1-a076aaa21bef','medio'),
	  ('95c252de-0357-42e7-8bba-b7fbc587b4e9','avanzado');


CREATE TABLE "courses" (
  "id" uuid PRIMARY KEY,
  "title" varchar NOT NULL,
  "description" varchar NOT NULL,
  "level_id" uuid NOT NULL,
  "teacher_id" uuid NOT NULL,
  "user_id" uuid NOT NULL,
  "course_videos_id" uuid NOT NULL
);

CREATE TABLE "courses_users"(
  "id" uuid PRIMARY KEY,
  "id_users" uuid not null,
  "id_curses" uuid not null,
  "complete" integer NOT NULL
);

insert into "courses_users"(id, id_users, id_curses, complete)
values('0f347519-c139-4ef5-9aaf-578af0847eb0','4c141fc7-8bb2-4342-90cb-2f5020a430cd','a521463b-2c0e-4c4c-90fa-0e3b48134dea',50),
	('55720286-62ea-412b-9bbd-25326afe5341','edb0d10c-db9c-4bf6-8804-5c3f7f20939f','4c141fc7-8bb2-4342-90cb-2f5020a430cd',80);



ALTER TABLE "courses" ADD FOREIGN KEY ("teacher_id") REFERENCES "teacher" ("id");
ALTER TABLE "courses" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");
ALTER TABLE "courses" ADD FOREIGN KEY ("level_id") REFERENCES "level" ("id");
ALTER TABLE "courses" ADD FOREIGN KEY ("course_videos_id") REFERENCES "course_videos" ("id");

insert into "courses"  (id, title, description, level_id, teacher_id, user_id, course_videos_id)
values('a521463b-2c0e-4c4c-90fa-0e3b48134dea', 'Curso React','Libreria React',
'95c252de-0357-42e7-8bba-b7fbc587b4e9','bbad8707-72c0-4de0-9d59-c722e7a2062e',
'4c141fc7-8bb2-4342-90cb-2f5020a430cd','64f4044a-f84a-4b47-8c25-f50b6f0429ee');


--Reto opcional!: Crea un join que traiga como tabla primaria los cursos y todas sus relaciones--



select courses.title, courses.description, teacher."name", users."name", level."name", course_videos.url from courses left join teacher on courses.teacher_id  = teacher.id
left join users on courses.user_id  = users.id
left join level on courses.level_id  = level.id
left join course_videos on courses.course_videos_id = course_videos.id ;



select courses_users.complete, courses.title, courses.description, teacher."name", users."name", level."name", course_videos.url from courses left join teacher on courses.teacher_id  = teacher.id
left join users on courses.user_id  = users.id
left join level on courses.level_id  = level.id
left join course_videos on courses.course_videos_id = course_videos.id 
inner join courses_users on courses_users.id_users  = users.id ;
