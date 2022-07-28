# ESL Data Analysis
### From the dataset creation to dashboards in Tableau, through DB creation and SQL

The goal of this project was to practice the following skills:

  - Analytical thinking
  - DB creation
  - DB design
  - PostgreSQL
  - Spreadsheets
  - Tableau

### Index

**0**. [Dataset creation](#the-dataset)

Creating a dataset with randomly generated personal data and checking correspondences

**1.** [Introduction](#introduction)

ELS English Language School is a fictional company that has decided to use data analysis for their needs

**2.** [Ask](#ask)

Meeting the CEO of ESL to clarify the problem(s) to be solved

**3.** [Prepare](#prepare)

Time to prepare the data. How I created a Database using PostgreSQL

**4.** Process

The dataset was created without needing to be cleaned (check [Data Creation](#the-dataset)).

**5.** [Analyze](#analyze)

Querying the DB to find answers to the stakeholder questions

**6.** [Share](#share)

The findings were presented to the ESL president through dashboards


## The Dataset

The dataset is about Japanese people interested in joining an English
language school called ESL located in the Kansai region.

<p align="center">
<img width="50%" height="50%" src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/esl_logo-1024x819.png">
</p>
<p align="center">
<sup>Logo customized from <a href="https://www.vecteezy.com/free-vector/hand">Hand Vectors by Vecteezy</a></sup>
</p>

Every person has a name, last name, e-mail address, gender, postal code,
residential address, prefecture of residence, phone number, and birth
date as long as an English proficiency level and other columns.

### Tools used

In order to initialize my dataset, I used
[this](https://hogehoge.tk/personal/generator/) website (it's in
Japanese). It's super useful but I needed the data in a different
format.

For example, some columns content was written in Japanese (but I needed
them in roman letters) and I wanted the e-mail addresses to look "less
fake". Also, some information was split into 2 or more columns but I
wanted them to be a single string.

<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_1-1024x201.jpg">
</p>
<p align="center">
<sup>The dummy data from the website looked like this</sup>
</p>

### Creating personal data


<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_2-1024x213.jpg">
</p>
<p align="center">
<sup>Part of the final result</sup>
</p>

First of all, I changed the headers' names in order to make them more
understandable for non-japanese readers. Then I reorganized the columns
in a way more convenient for my needs.

  - **mail\_address**

I wanted to make the e-mail address look more real so I decided to get
rid of the make-up domain and substitute it with existing ones.

To get rid of the domain I extracted the first part of the address by
applying **=LEFT(D2; SEARCH("@"; D2) )**.

In another column, I inserted random numbers from 1 to 5 using
**=RANDBETWEEN(1;5)**. Next to it, with a formula like
**=IF(E8=1;"gmail.com";IF(E8=2;"yahoo.co.jp")...** I could get real
e-mail domains.

The last step was concatenating the 2 strings using the
**=CONCATENATE()** function.

  - **gender**

Using "*FIND AND REPLACE*" I substituted the values in the gender column
(replaced 女 with F and 男 with M).

  - **address**

To make the address fit in a single column, I used the
**=CONCATENATE()** function.

  - **prefecture**

For the prefecture, I again used "*FIND AND REPLACE*", translating from
Japanese.

  - **level**

To make sure that their proficiency level was the same or higher than
the level determined during the trial (look at the next paragraph) I
used the **=RANDBETWEEN()** function setting the bottom value as the
student level determined during the trial and the top value as 8
(highest level possible).

### Creating other data

Once the student's worksheet was created, 2 more were needed: trial
(every student takes a trial lesson where their level is determined) and
lesson (a regular English lesson).

Because the information about the trials and lessons is associated with
the students, I assigned an ID to every student and used it on the other
sheets.

  - **Trial**

The trial date was created using the following formula
**=RANDBETWEEN(DATE(2020;1;1);DATE(2022;12;31))** and their level was
generated with **=RANDBETWEEN(1;8)**

  - **Lesson**

Something that needed particular attention was data about lessons. In
fact, when generating them, I had to check that the student, after
having a trial lesson:

\-enrolled in the school

\-the lesson date wasn't prior to the trial date

To check the first condition, with the **FILTER** tool, I sorted the
<span style="text-decoration: underline;">trial dataset</span> so to
have the enrolled students at the top.

On the <span style="text-decoration: underline;">lesson
worksheet</span>, I reported only those students who enrolled. In this
way, there is no risk that any unrolled student get a lesson assigned.

The reported columns included the student ID and the trial date.

For the lesson date, I used **=RANDBETWEEN(B2;TODAY())** where B2 is the
date of the trial.

Now, every enrolled student has at least one lesson. But, more lesson
records needed to be created.

First I added a bunch of rows with the student ID in the first cell. To
do that, I had to use only the students' ID already present on the
spreadsheet through the formula **`=INDEX($A$2:$A$1500; RANDBETWEEN(1,
ROWS($A$2:$A$1500)); 1)`.**

Then, using **=VLOOKUP()** I obtained the trial date. After that, using
the previously created formulas, the auto-filling did its job great.

## Introduction

ESL is a **<span style="text-decoration: underline;">fictional
company</span>** with 4 branches in the Kansai area of Japan.

This company operates in the educational field and it's specialized in
teaching English language to Japanese people.

The CEO is looking for a way to improve the schools.

<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL1.jpg">
<img src ="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL2.jpg">
<img src ="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL3.jpg">
</p>
<p align="center">
<sup>Comic made with <a href="https://www.storyboardthat.com/">StoryboardThat</a></sup>
</p>

After holding an internal meeting, he decides to use Data Analysis.

Currently, information about students, staff and teachers is saved on
spreadsheets. Every school uses its own set of spreadsheets which means
that other branches don't have information about what goes on in other
schools.


<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/esl_logo-1024x819.png" width="50%" height="50%">
</p>

ESL operates in the cities of Osaka, Kyoto, Kobe, and Nara.

The teachers are all non-Japanese and the staff is all Japanese. They
move around and they work in the different branches depending on the
schedule.

Before joining the school, every student has to take a test to determine
their level. The level is decided by one of the teachers and after that,
someone from the Japanese staff holds an explanatory session with the
student about how ESL works. The student can choose which plan to enroll
in (there are different plans with different prices as long as temporary
campaigns).

Every lesson is private, which means only 1 student is allowed per
lesson. There are different types of lessons (grammar, conversation,
review, ...) and every student gives a rating to the teacher.

<!-- wp:paragraph -->
<p>The CEO of ESL is looking for a way to bring improvements to the company.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>After an internal meeting, he decided to ask me how to use data to achieve his goal.</p>
<!-- /wp:paragraph -->

<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/strip-1024x307.jpg">
</p>

<!-- wp:heading {"level":3} -->
<h3>Meeting the stakeholders</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>The first step of this data analysis is to determine what kind of information the CEO wants.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>We decided to have a meeting in order to know the company more in detail and to clarify the problems to be resolved.</p>
<!-- /wp:paragraph -->


<!-- wp:paragraph -->
<p>The stakeholder stated:</p>
<!-- /wp:paragraph -->


> We would like to launch a targetted campaign. Depending on the prefecture of residence of our potential customers, different studying plans would be offered.</em></p><p><em>For our offers, we also would like to consider different parameters like gender and age.


<!-- wp:paragraph -->
<p>Also,</p>
<!-- /wp:paragraph -->

> Other than getting new customers, mantaining our current students is essential.  </em></p></blockquote>


<!-- wp:heading {"level":3} -->
<h3>Ask</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>After the meeting, the problem was clear, and in order to solve it, some questions had to be answered.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>To keep and improve current students' satisfaction, I had to find an answer to these questions:</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>In which school students are less satisfied with ESL methods?</li><li>Who are the teachers with low ratings?</li><li>Who is the staff with the lowest percentage of new students signups?</li><li>What's the school with fewer students?</li><li>Is there a relationship between teachers' skills (native speakers and/or Japanese speakers) and lesson ratings?</li><li>What level of students appreciates the most Japanese speakers teachers and native speakers teachers?</li><li>What kind of lessons is the less appreciated?</li></ul>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p>Regarding the creation of targetted campaigns:</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>What's the age average of the enrolled students (in general and by school)?</li><li>What is students' favorite time for lessons(in general and by school)?</li><li>What's the most chosen plan by students (in general and by school)?</li><li>When do students usually enroll in ELS (in general and by school?</li><li>What gender is the most satisfied with ELS methods (in general and by school)?</li><li>From which prefecture are the most satisfied student coming from?</li><li>What's the age of the most satisfied students (age and age range in general and by school)?</li></ul>
<!-- /wp:list -->

## Prepare

ESL used to store information about students, staff, teachers, etc on
separate spreadsheets files.

There was no connection between the 4 schools as every branch used its
own set of files.

### Database

To get rid of that problem, I decided to create a database that includes
all those datasets. In this way, the information collected would be
correlated. Thanks to it, specific queries could be created in order to
answer the
[questions](#ask)
related to the problems.

### DB Schema

<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ELS_schema-1024x765.jpeg">
<sup>DB Schema</sup>
</p>

Information about people interested in joining ESL is stored in the
student table. When the individual decides to join, the attribute
*enrolled* is set in a way to "*Y*" (more details in the attributes part
below)

### Entities

I individuated 6 entities:

  - Staff: The Japanese staff does part of the trials.
  - Trial: A special lesson to determine new students level
  - Student: An individual interested in joining ESL
  - School: One of the four ESL branches
  - Teacher: A non-Japanese person whose role is to do part of the
    trials and lessons
  - Lesson: An English lesson between a student and a teacher

### Relations between entities

Relations between entities:

  - Staff : Trial (1:M)

A person from the staff can do multiple trials. Each trial is done by
one staff member at a time.

  - Student : Trial (1:M)

If they want, an individual interested in joining ESL can have several
trials. Each trial is done by one teacher at a time

  - School : Trial (1:M)

A school can hold different trials. That trial can be done in only one
school.

  - School : Student (1:M)

A school has many students. A student is a member of only one school.

  - School : Lesson (1:M)

Many lessons happen in a school. A lesson can happen in only one school.

  - Student : Lesson (1:M)

A student can have many lessons. Every lesson has only one student.

  - Teacher : Lesson (1:M)

A teacher can do many lessons. Every lesson is done by one teacher.

  - Teacher : Trial (1:M)

A teacher can do multiple trials. Each trial is done by one teacher at a
time.

### Entities attributes

As most of the attributes are often used attributes and are
self-explanatory, I'm going to describe some.

**TRIAL**

  - *start\_level*: an English proficiency score (from 1 to 8) is
    assigned to the individual interested in joining the school
  - *signed*: whether or not the individual decides to join ESL (can
    have the values "Y" for yes or "N" for no)

**STUDENT**

  - *prefecture*: the prefecture of residence of the individual
  - *student\_level*: the current student's level
  - *plan*: the study plan in which the student is enrolled
  - *enrolled*: whether or not the student is currently enrolled. It
    matches the value of the attribute *signed* from the **trial** table
    but can also have "*Q*" as a value (the student has *q*uit)

**TEACHER**

  - *japanese\_speaker*: whether or not the teacher can speak Japanese
  - *native*: whether or not the teacher is a native English speaker

**LESSON**

  - *lesson\_type*: the type of the lesson (Grammar, Conversation,
    Review,...)
  - *rating*: after each lesson, each student gives a rating from 1 to
    10 to the teacher

### Table creation and data insert

I decided to create the database using **PostgreSQL**.

Following is the code I wrote to create the tables and to insert the [data](#the-dataset).

``` wp-block-verse
Some of the insert queries are very long. Only a part of them is reported 
```

[The whole .sql file to create the db can be found here](esl_db.sql)

``` wp-block-code
CREATE TABLE staff (
staff_id SERIAL,
first_name VARCHAR (128) NOT NULL,
last_name VARCHAR (128) NOT NULL,
birth_date DATE NOT NULL,
gender CHAR (1) CHECK (gender IN ('M', 'F', 'O')) NOT NULL,
hiring_date DATE NOT NULL,
city VARCHAR (128) NOT NULL,
address TEXT NOT NULL,
notes TEXT,
PRIMARY KEY (staff_id)
);

INSERT INTO staff (first_name, last_name, birth_date, gender, hiring_date, city, address)
VALUES
('Mami', 'Nakaguchi', '1989-07-21', 'F', '2010-03-29', 'Kyoto', '〒602-8007京都府京都市上京区東長者町22番22号'),
('Haruka', 'Kamata', '1981-01-12', 'F', '2010-01-18', 'Osaka', '〒567-0802大阪府茨木市総持寺駅前町27番27号'),
('Ayumi', 'Kono', '1985-03-15', 'F', '2010-01-11', 'Osaka', '〒590-0824大阪府堺市堺区老松町2番2号'),
('Mio', 'Yamaguchi', '1983-03-13', 'F', '2010-08-29', 'Nara', '〒637-0036奈良縣五條市野原西21番21号'),
('Shizuka', 'Hamada', '1988-07-21', 'F', '2010-01-02', 'Osaka', '〒532-0022大阪府大阪市淀川区野中南22番22号');

CREATE TABLE teacher (
teacher_id SERIAL,
first_name VARCHAR (128) NOT NULL,
last_name VARCHAR (128) NOT NULL,
gender CHAR (1) CHECK (gender IN ('M', 'F', 'O')) NOT NULL,
email VARCHAR (128) UNIQUE NOT NULL,
nationality CHAR (3) NOT NULL,
phone TEXT UNIQUE NOT NULL,
japanese_speaker BOOLEAN NOT NULL,
native BOOLEAN NOT NULL,
PRIMARY KEY (teacher_id)
);

INSERT INTO teacher (first_name, last_name,gender, email, nationality, phone, japanese_speaker, native)
VALUES
('Kevin','Mitchell','M','kevin.mitchell@gmail.com','USA','1156783241','0','1'),
('George','Lewis','M','george.lewis@gmail.com','USA','9542540589','0','1'),
('Michelle','Brown','F','michelle.brown@hotmail.com','USA','6588471474','0','1'),
('Mike','Beverly','M','mike.beverly@yahoo.com','USA','7403895038','0','1'),
('Joseph','Wright','M','joseph.wright@hotmail.com','USA','1545350759','1','1'),
('Sean','Micheal','M','sean.micheal@outlook.com','UK','8193054562','1','1'),
('Matt','Osbourne','M','matt.osbourne@yahoo.com','UK','1415238943','1','1'),
('Emily','Hill','F','emily.hill@gmail.com','UK','6297310758','0','1'),
('Jessica','Hamilton','F','jessica.hamilton@gmail.com','UK','9029258313','0','1'),
('Harry','Owen','M','harry.owen@gmail.com','UK','1917398764','0','1'),
('Hanna','Black','F','hanna.black@hotmail.com','AUS','6173213376','0','1'),
('Josephine','Humm','F','josephine.humm@yahoo.com','AUS','7793526145','0','1'),
('Vanessa','Campbell','F','vanessa.campbell@hotmail.com','CAN','3182597514','1','1'),
('Maria','Hernandez','F','maria.hernandez@outlook.com','ESP','1618404948','1','0'),
('Oscar','Leroy','M','oscar.leroy@yahoo.com','FRA','2581754257','0','0'),
('Milo','Thys','M','milo.thys@gmail.com','NED','1976360652','1','0'),
('Rafael','Herrera','M','rafael.herrera@gmail.com','MEX','8501488465','1','0'),
('Selma','Graf','F','selma.graf@gmail.com','GER','5313225902','1','0'),
('Simone','Basile','M','simone.basile@hotmail.com','ITA','8403459750','1','0');

CREATE TABLE school(
school_id SERIAL,
name VARCHAR (128) NOT NULL,
address TEXT NOT NULL,
email VARCHAR (128) UNIQUE NOT NULL,
phone TEXT UNIQUE NOT NULL,
PRIMARY KEY (school_id)
);

INSERT INTO school (name, address, email, phone)
VALUES ('ESL Osaka', '〒560-0013大阪府豊中市上野東30番30号','osaka@esl.com','9337662967'),
('ESL Kobe', '〒650-0046 神戸市中央区港島中町6丁目10番','kobe@esl.com','4867338012'),
('ESL Nara', '〒638-0024奈良縣吉野郡下市町貝原9番9号','nara@esl.com','2351342271'),
('ESL Kyoto', '〒616-8141京都府京都市右京区太秦棚森町5番5号','kyoto@esl.com','7919718043');

CREATE TABLE student(
student_id SERIAL,
first_name VARCHAR (128) NOT NULL,
last_name VARCHAR (128) NOT NULL,
email VARCHAR (128) UNIQUE NOT NULL,
gender CHAR (1) CHECK(gender IN ('M', 'F', 'O')) NOT NULL,
postal_code VARCHAR (128) NOT NULL,
address TEXT NOT NULL,
prefecture VARCHAR (128) NOT NULL,
phone TEXT UNIQUE NOT NULL,
student_level SMALLINT NOT NULL,
birth_date DATE NOT NULL,
plan VARCHAR (128) NOT NULL,
enrolled CHAR (1) CHECK (enrolled IN ('Y', 'N')) ,
notes TEXT,
school_id INT REFERENCES school (school_id) ON DELETE CASCADE,
PRIMARY KEY (student_id)
);

INSERT INTO student (first_name, last_name, email, gender, postal_code, address, prefecture, phone, student_level, birth_date, plan, school_id)
VALUES
('Sawa','Hagiwara','sawa965@yahoo.co.jp','F','670-0028','姫路市 岩端町 2-4-18 岩端町プレシャス311','Hyogo','08016547124','1','1986-09-20','Plan_6','2'),
('Shizuko','Nagata','shizukonagata@docomo.ne.jp','F','651-1254','神戸市北区 山田町福地 4-3-9 ','Hyogo','08022900264','7','1984-09-21','Plan_1','2'),
('Haruna','Aida','haruna273@naver.com','F','585-0002','南河内郡河南町 一須賀 4-1-4 プラチナ一須賀215','Osaka','09063463230','3','2005-08-16','Plan_6','1'),
('Momoka','Honda','tfbsfekxmomoka3149@au.com','F','571-0029','門真市 打越町 4-1-18 打越町ロイヤルパレス216','Osaka','08014372351','5','1953-12-05','Plan_4','1'),
('Misato','Ban','misatoban@docomo.ne.jp','F','651-2225','神戸市西区 桜が丘東町 1-17-15 ','Hyogo','08066703485','6','1996-09-22','Plan_1','2'),
('Ayano','Satou','ayano570@au.com','F','651-1411','西宮市 山口町名来 2-2-6 ','Hyogo','09017390356','6','1963-05-06','Plan_2','2'),
('Mei','Miyauchi','meimiyauchi@docomo.ne.jp','F','639-2272','御所市 蛇穴 3-4-13 蛇穴フォレスト301','Nara','08038519021','1','2009-04-19','Plan_4','3'),
('Chikara','Ishii','chikara12971@docomo.ne.jp','M','612-0003','京都市伏見区 深草藤田坪町 4-7-19 ','Kyoto','08053553335','3','1992-03-17','Plan_8','4'),
('Mio','Ueda','mio46239@ezweb.ne.jp','F','572-0835','寝屋川市 日之出町 4-4-16 ','Osaka','08079161013','4','1994-12-03','Plan_6','1'),
('Yuzuka','Furuya','yuzukafuruya@yahoo.co.jp','F','567-0046','茨木市 南春日丘 1-3-5 ','Osaka','09073639506','1','1982-12-10','Plan_3','1'),
('Hinano','Ri','hinano2217@hotmail.com','F','598-0053','泉佐野市 大宮町 4-19-3 ','Osaka','09063632084','7','1968-05-25','Plan_1','1'),
('Sakiho','Torii','sakiho596@hotmail.com','F','621-0262','亀岡市 畑野町広野 2-5-12 ','Kyoto','09091894323','6','2001-04-19','Plan_4','4'),
('Miyuki','Asai','miyukiasai@yahoo.co.jp','F','545-0034','大阪市阿倍野区 阿倍野元町 1-2 ','Osaka','09050878172','5','1977-08-14','Plan_6','1')
--lines removed

CREATE TABLE trial(
trial_id SERIAL,
trial_date DATE NOT NULL,
trial_time TIME NOT NULL,
start_level SMALLINT NOT NULL,
signed CHAR (1) CHECK (signed IN ('Y', 'N')) NOT NULL,
notes TEXT ,
student_id INT REFERENCES student(student_id) ON DELETE CASCADE,
teacher_id INT REFERENCES teacher(teacher_id) ON DELETE CASCADE,
staff_id INT REFERENCES staff(staff_id) ON DELETE CASCADE,
school_id INT REFERENCES school(school_id) ON DELETE CASCADE,
PRIMARY KEY (trial_id)
);

INSERT INTO trial (trial_date, trial_time, start_level, signed, student_id, teacher_id, staff_id, school_id)
VALUES
('2022-01-22','20:00:00','1','N','1','13','3','2'),
('2021-10-18','15:00:00','4','Y','2','2','1','2'),
('2020-01-30','14:00:00','1','N','3','6','5','1'),
('2020-03-31','13:00:00','1','Y','4','14','3','1'),
('2019-06-26','13:00:00','3','N','5','19','4','2'),
('2020-01-27','15:00:00','6','N','6','4','2','2'),
('2021-06-02','14:00:00','1','Y','7','9','4','3'),
('2019-04-20','18:00:00','2','Y','8','5','5','4'),
('2022-11-06','15:00:00','3','N','9','18','3','1'),
('2019-06-13','14:00:00','1','Y','10','18','1','1'),
('2019-01-03','20:00:00','1','Y','11','10','2','1'),
('2018-08-14','19:00:00','3','Y','12','15','5','4'),
('2019-08-22','11:00:00','5','Y','13','1','4','1'),
('2021-08-25','13:00:00','1','Y','14','12','5','1'),
('2018-12-31','13:00:00','1','N','15','7','3','1'),
('2022-06-05','19:00:00','3','Y','16','9','4','3'),
('2019-02-06','13:00:00','1','Y','17','2','4','4'),
('2021-12-29','18:00:00','2','Y','18','14','1','4'),
('2019-12-09','11:00:00','5','Y','19','4','2','3'),
('2021-05-07','13:00:00','2','Y','20','8','1','4')
--lines removed

CREATE TABLE lesson (
lesson_id SERIAL,
lesson_date DATE NOT NULL,
lesson_time TIME NOT NULL,
lesson_type CHAR(3) CHECK (lesson_type IN ('Con','Gra','Rev','FC','Oth')) NOT NULL,
rating SMALLINT CHECK (rating BETWEEN 1 AND 10) NOT NULL,
notes TEXT,
teacher_id INT REFERENCES teacher (teacher_id) ON DELETE CASCADE,
student_id INT REFERENCES student (student_id) ON DELETE CASCADE,
school_id INT REFERENCES school (school_id) ON DELETE CASCADE,
PRIMARY KEY (lesson_id)
);

INSERT INTO lesson (lesson_date, lesson_time, lesson_type, rating, teacher_id, school_id, student_id)
VALUES
('2023-05-16','11:00:00','Rev','3','3','1','1058'),
('2023-02-10','11:00:00','FC','4','10','4','902'),
('2021-12-19','17:00:00','FC','5','15','1','1527'),
('2022-12-26','17:00:00','Con','5','15','3','115'),
('2021-08-21','19:00:00','Rev','6','13','3','1382'),
('2021-06-23','19:00:00','FC','5','9','3','1085'),
('2019-03-24','13:00:00','Rev','5','10','1','960'),
('2022-02-25','15:00:00','Rev','6','3','3','389'),
('2021-10-24','10:00:00','Oth','4','5','1','805'),
('2019-11-24','20:00:00','Rev','5','12','2','693'),
('2022-11-15','14:00:00','Oth','4','3','3','1137'),
('2022-01-15','10:00:00','Con','5','13','1','1116'),
('2021-06-25','16:00:00','Rev','4','12','1','438'),
('2020-11-09','16:00:00','FC','4','5','4','1552'),
('2022-03-13','14:00:00','Con','5','8','3','550'),
('2021-01-29','15:00:00','Rev','5','1','1','329'),
('2020-06-03','14:00:00','Rev','6','9','3','1338'),
('2023-05-27','10:00:00','Oth','8','1','1','485'),
('2022-12-22','18:00:00','FC','6','13','1','1228')
--lines removed

UPDATE student SET enrolled = trial.signed
FROM trial
WHERE student.student_id = trial.student_id;
```

Now the DB is ready to be interrogated.

## Analyze

Now that my information is stored and organized in the database, I can
answer the [stakeholder
questions](#ask).

To do that, I used PostgreSQL.

[The .sql file with all the queries can be found here](esl_queries.sql)

### Queries

1\.**In which school students are less satisfied with ESL methods?**

``` wp-block-code
SELECT sc.name AS school_name, ROUND(AVG(l.rating),2) AS rating_avg, ROUND(AVG(l.rating),2)-
(
    SELECT ROUND(AVG(l.rating) ,2)
    FROM lesson AS l
) AS avg_diff
FROM school AS sc
JOIN lesson AS l ON sc.school_id = l.school_id
GROUP BY sc.name
UNION
SELECT 'ALL SCHOOLS', ROUND(AVG(l.rating) ,2), '0'
    FROM lesson AS l
ORDER BY rating_avg
```
<p align="center">
<img src ="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql1.jpg">
</p>
<p align="center">
<sup>Students taking lessons at Osaka school are the less satisfied with ESL methods</sup>
</p>

2\.**Who are the teachers with low ratings?**

``` wp-block-code
SELECT t.first_name AS teacher_name, ROUND(AVG(l.rating),2) AS rating_avg, ROUND(AVG(l.rating),2)-
(
    SELECT ROUND(AVG(l.rating) ,2)
    FROM lesson AS l
) AS avg_diff
FROM lesson AS l
JOIN teacher AS t ON l.teacher_id = t.teacher_id
GROUP BY teacher_name
UNION
SELECT 'ALL TEACHERS', ROUND(AVG(l.rating) ,2), '0'
    FROM lesson AS l
ORDER BY rating_avg
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql2.jpg">
</p>
<p align="center">
<sup>Josephine and Mike need some help. Hopefully Simone and Vanessa can help them</sup>
</p>

3\.**Who is the staff with the lowest percentage of new students
signups?**

``` wp-block-code
SELECT staff_name,ROUND((signed/total)*100,2) as p_sign_ups
FROM
(
    SELECT s.first_name AS staff_name, COUNT(*)::DECIMAL total,  SUM(CASE WHEN signed = 'Y' THEN 1 ELSE 0 END) signed
    FROM trial t
    JOIN staff s ON t.staff_id = s.staff_id
GROUP BY s.first_name
) x
ORDER BY p_sign_ups
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql3.jpg">
</p>
<p align="center">
<sup>Mio needs some help with the trials</sup>
</p>

4\.**What’s the school with fewer students?**

``` wp-block-code
SELECT sc.name AS school_name, COUNT (*) AS enrolled_students
FROM student AS st
JOIN school AS sc ON st.school_id = sc.school_id
WHERE st.enrolled = 'Y'
GROUP BY school_name
ORDER BY enrolled_students
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql4.jpg">
</p>
<p align="center">
<sup>Nara school has “only” 299 enrolled students</sup>
</p>

5\.**Is there a relationship between teachers’ skills (native speakers
and/or Japanese speakers) and lesson ratings?**

``` wp-block-code
--relation between rating and native speakers vs non native speakers
SELECT 'Native speaker' AS skill, CAST(AVG (l.rating) AS DECIMAL (10,2))
FROM lesson AS l
JOIN teacher AS t ON t.teacher_id = l.teacher_id
WHERE t.native = 'Y'
UNION
SELECT 'Non native speaker', CAST(AVG (l.rating) AS DECIMAL (10,2))
FROM lesson AS l
JOIN teacher AS t ON t.teacher_id = l.teacher_id
WHERE t.native = 'N'
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql5a.jpg">
</p><p align="center">
<sup>Not much difference in appreciation</sup>
</p>

``` wp-block-code
--relation between rating and japanese speakers vs non japanese speakers
SELECT 'Japanese speaker' AS skill, CAST(AVG (l.rating) AS DECIMAL (10,2))
FROM lesson AS l
JOIN teacher AS t ON t.teacher_id = l.teacher_id
WHERE t.japanese_speaker = 'Y'
UNION
SELECT 'Non Japanese speaker', CAST(AVG (l.rating) AS DECIMAL (10,2))
FROM lesson AS l
JOIN teacher AS t ON t.teacher_id = l.teacher_id
WHERE t.japanese_speaker = 'N'
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql5b.jpg">
</p>
<p align="center">
<sup>Not much difference in appreciation</sup>
</p>

6\.**What level of students appreciates the most Japanese speakers
teachers and native speakers teachers?**

``` wp-block-code
--highest appreciation for japanese speaker teacher by level
SELECT s.student_level AS level, CAST(AVG (l.rating) AS DECIMAL (10,2)) average_rating
FROM lesson AS l
JOIN teacher AS t ON t.teacher_id = l.teacher_id
JOIN student AS s ON l.student_id = s.student_id
WHERE t.japanese_speaker = 'Y'
GROUP BY level
ORDER BY average_rating DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql6a.jpg">
</p>
<p align="center">
<sup>Level 6 students are the most satisfied when they have lessons with Japanese speakers teachers</sup>
</p>

``` wp-block-code
--highest appreciation for native speaker teacher by level
SELECT s.student_level AS level, CAST(AVG (l.rating) AS DECIMAL (10,2)) average_rating
FROM lesson AS l
JOIN teacher AS t ON t.teacher_id = l.teacher_id
JOIN student AS s ON l.student_id = s.student_id
WHERE t.native = 'Y'
GROUP BY level
ORDER BY average_rating DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql6b.jpg">
</p>
<p align="center">
<sup>Level 8 students are the most satisfied when taking lessonswith native teachers</sup>
</p>

7\.**What kind of lessons is the less appreciated?**

``` wp-block-code
SELECT lesson_type, CAST(AVG (rating) AS DECIMAL (10,2)) AS rating_average
FROM lesson
GROUP BY lesson_type
ORDER BY rating_average
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql7.jpg">
</p>
<p align="center">
<sup>“Review” lessons are the less appreciated. FC style are the favorites </sup>
</p>

8\.**What’s the age average of the enrolled students (in general and by
school)?**

``` wp-block-code
SELECT sc.name, CAST(AVG(DATE_PART('year',AGE(birth_date))) AS DECIMAL(10,2)) AS age_average
FROM student AS st
JOIN school AS sc ON sc.school_id = st.school_id
WHERE st.enrolled ='Y'
GROUP BY sc.name
UNION
SELECT 'ESL SCHOOLS', CAST(AVG(DATE_PART('year',AGE(birth_date))) AS DECIMAL(10,2)) AS age_average
FROM student
WHERE enrolled = 'Y'
ORDER BY age_average
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql8.jpg">
</p>
<p align="center">
<sup>ESL Osaka is the “youngest” school</sup>
</p>

9\.**What is students’ favorite time for lessons(in general and by
school)?**

``` wp-block-code
--favorite lesson time
SELECT l.lesson_time AS time, COUNT(*) AS number_of_students
FROM lesson AS l
JOIN school AS s ON s.school_id = l.school_id
WHERE s.name ='ESL Osaka'
GROUP BY time
ORDER BY number_of_students DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql9a.jpg">
</p>
<p align="center">
<sup>ESL students prefer lessons at 6 PM</sup>
</p>

``` wp-block-code
--favorite lesson time in Osaka school
SELECT l.lesson_time AS time, COUNT(*) AS number_of_students
FROM lesson AS l
JOIN school AS s ON s.school_id = l.school_id
WHERE s.name ='ESL Osaka'
GROUP BY time
ORDER BY number_of_students DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql9b.jpg">
</p>
<p align="center">
<sup>In Osaka school, students prefer lessons at 4 PM</sup>
</p>

``` wp-block-code
--favorite lesson time in Kyoto school
SELECT l.lesson_time AS time, COUNT(*) AS number_of_students
FROM lesson AS l
JOIN school AS s ON s.school_id = l.school_id
WHERE s.name ='ESL Kyoto'
GROUP BY time
ORDER BY number_of_students DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql9c.jpg">
</p>
<p align="center">
<sup>In Kyoto school, students prefer lessons at 6 PM. Compared to Osaka, 4 PM is the less favorite</sup>
</p>

``` wp-block-code
--favorite lesson time in Kobe school
SELECT l.lesson_time AS time, COUNT(*) AS number_of_students
FROM lesson AS l
JOIN school AS s ON s.school_id = l.school_id
WHERE s.name ='ESL Kobe'
GROUP BY time
ORDER BY number_of_students DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql9d.jpg">
</p>
<p align="center">
<sup>In Kobe school, students prefer lessons at 6 PM</sup>
</p>

``` wp-block-code
--favorite lesson time in Nara school
SELECT l.lesson_time AS time, COUNT(*) AS number_of_students
FROM lesson AS l
JOIN school AS s ON s.school_id = l.school_id
WHERE s.name ='ESL Nara'
GROUP BY time
ORDER BY number_of_students DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql9e.jpg">
</p>
<p align="center">
<sup>In Nara school, students prefer lessons at 11 AM</sup>
</p>

10\.**What’s the most chosen plan by students (in general and by
school)?**

``` wp-block-code
--most chosen plan by students in general
SELECT st.plan, COUNT (st.plan) AS chosen_times
FROM student AS st
JOIN school AS sc ON sc.school_id = st.school_id
WHERE st.enrolled ='Y'
GROUP BY st.plan
ORDER BY chosen_times DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql10a.jpg">
</p>
<p align="center">
<sup>Plan 5 is the favorite plan</sup>
</p>

``` wp-block-code
--most chosen plan by students by school
SELECT sc.name AS school_name, st.plan, COUNT (st.plan) AS chosen_times
FROM student AS st
JOIN school AS sc ON sc.school_id = st.school_id
WHERE st.enrolled ='Y'
GROUP BY sc.name, st.plan
ORDER BY school_name, chosen_times DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql10b.jpg">
</p>
<p align="center">
<sup>In Kobe school, the favorite plan is Plan 8 / In Kyoto school, the favorite plan is Plan 6 / In Nara school, the favorite plan is Plan 5 / In Osaka school, the favorite plan is Plan 2</sup>
</p>

11\.**When do students usually enroll in ELS (in general and by
school?**)

``` wp-block-code
--amount of signups by month in all schools
SELECT TO_CHAR(t.trial_date , 'MM') AS month, COUNT(*) AS signups
FROM trial AS t
WHERE t.signed = 'Y'
GROUP BY month
ORDER BY signups DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql11a.jpg">
</img>
<p align="center">
<sup>December is the month when most new students decide to enroll </sup>
</p>

``` wp-block-code
--amount of signups by month in Osaka school
SELECT TO_CHAR(t.trial_date , 'MM') AS month, COUNT(*) AS signups
FROM trial AS t
JOIN school AS s ON s.school_id = t.school_id
WHERE t.signed = 'Y' AND s.name ='ESL Osaka'
GROUP BY month
ORDER BY signups DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/ESL_sql11b.jpg">
</img>
<p align="center">
<sup>In Osaka school, the most popular month for enrollment is September</sup>
</p>

``` wp-block-code
--amount of signups by month in Kyoto school
SELECT TO_CHAR(t.trial_date , 'MM') AS month, COUNT(*) AS signups
FROM trial AS t
JOIN school AS s ON s.school_id = t.school_id
WHERE t.signed = 'Y' AND s.name ='ESL Kyoto'
GROUP BY month
ORDER BY signups DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_11c.jpg">
</img>
<p align="center">
<sup>In Kyoto school, the most popular month for enrollment is December</sup>
</p>

``` wp-block-code
--amount of signups by month in Kobe school
SELECT TO_CHAR(t.trial_date , 'MM') AS month, COUNT(*) AS signups
FROM trial AS t
JOIN school AS s ON s.school_id = t.school_id
WHERE t.signed = 'Y' AND s.name ='ESL Kobe'
GROUP BY month
ORDER BY signups DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_11d.jpg">
</img>
<p align="center">
<sup>In Kobe school, the most popular month for enrollment is August</sup>
</p>

``` wp-block-code
--amount of signups by month in Nara school
SELECT TO_CHAR(t.trial_date , 'MM') AS month, COUNT(*) AS signups
FROM trial AS t
JOIN school AS s ON s.school_id = t.school_id
WHERE t.signed = 'Y' AND s.name ='ESL Nara'
GROUP BY month
ORDER BY signups DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_11e.jpg">
</p>
<p align="center">
<sup>In Nara school, the most popular month for enrollment is November</sup>
</p>

12\.**What gender is the most satisfied with ELS methods (in general and
by school)?**

``` wp-block-code
--most satisfied students by gender
SELECT s.gender, CAST(AVG (l.rating) AS DECIMAL (10,2)) AS rating_average
FROM student AS s
JOIN lesson AS l ON s.student_id =l.student_id
GROUP BY s.gender
ORDER BY rating_average DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_12a.jpg">
</p>
<p align="center">
<sup>Female students are slightly more satisfied than males</sup>
</p>

``` wp-block-code
--most satisfied gender by school
SELECT sc.name AS school_name, s.gender, CAST(AVG (l.rating) AS DECIMAL (10,2)) AS rating_average
FROM student AS s
JOIN lesson AS l ON s.student_id =l.student_id
JOIN school AS sc ON sc.school_id = l.school_id
GROUP BY school_name, s.gender
ORDER BY school_name, rating_average DESC
```
<p align="center">
<img="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_12b.jpg">
</p>
<p align="center">
<sup>In every school except Osaka, females are more satisfied than males</sup>
</p>

13\.**From which prefecture are the most satisfied student coming
from?**

``` wp-block-code
SELECT s.prefecture, CAST(AVG (l.rating) AS DECIMAL (10,2)) AS rating_average
FROM student AS s
JOIN lesson AS l ON s.student_id =l.student_id
GROUP BY s.prefecture
ORDER BY rating_average DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_13.jpg">
</p>
<p align="center">
<sup>Students living in Nara are the most satisfied with ESL methods</sup>
</p>

14\.**What’s the age range of the most satisfied students (in general
and by school)?**

``` wp-block-code
--students satisfaction by age range
SELECT (CASE WHEN DATE_PART('year',AGE(s.birth_date)) <= 18 THEN '<= 18'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 19 AND 24 then 'between 19 and 24'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 25 AND 34 then 'between 25 and 34'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 35 AND 44 then 'between 25 and 44'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 45 AND 54 then 'between 45 and 54'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 55 AND 64 then 'between 55 and 64'
             ELSE '> 65'
        END) AS age_category,
ROUND(AVG(l.rating),2) AS rating_average
FROM student AS s
JOIN lesson AS l ON s.student_id= l.student_id
GROUP BY age_category
ORDER BY rating_average DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_14a.jpg">
</p>
<p align="center">
<sup>Over 65 years old and teenagers are the the most satisfied with ESL methods</sup>
</p>

``` wp-block-code
--students satisfaction by age range in Osaka school
--14b)students satisfaction by age range in Osaka
SELECT (CASE WHEN DATE_PART('year',AGE(s.birth_date)) <= 18 THEN '<= 18'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 19 AND 24 then 'between 19 and 24'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 25 AND 34 then 'between 25 and 34'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 35 AND 44 then 'between 35 and 44'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 45 AND 54 then 'between 45 and 54'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 55 AND 64 then 'between 55 and 64'
             ELSE '> 65'
        END) AS age_category,
ROUND(AVG(l.rating),2) AS rating_average
FROM student AS s
JOIN lesson AS l ON s.student_id= l.student_id
JOIN school AS sc ON sc.school_id = l.school_id
WHERE sc.name='ESL Osaka'
GROUP BY age_category
ORDER BY rating_average DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_14b.jpg">
</p>
<p align="center">
<sup>In Osaka school, students between 25 and 34 years old are the most satisfied</sup>
</p>

``` wp-block-code
--students satisfaction by age range in Kyoto school
SELECT (CASE WHEN DATE_PART('year',AGE(s.birth_date)) <= 18 THEN '<= 18'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 19 AND 24 then 'between 19 and 24'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 25 AND 34 then 'between 25 and 34'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 35 AND 44 then 'between 35 and 44'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 45 AND 54 then 'between 45 and 54'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 55 AND 64 then 'between 55 and 64'
             ELSE '> 65'
        END) AS age_category,
ROUND(AVG(l.rating),2) AS rating_average
FROM student AS s
JOIN lesson AS l ON s.student_id= l.student_id
JOIN school AS sc ON sc.school_id = l.school_id
WHERE sc.name='ESL Kyoto'
GROUP BY age_category
ORDER BY rating_average DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_14c.jpg">
</p>
<p align="center">
<sup>In Kyoto school, students between 35 and 44 years old are the most satisfied</sup>
</p>

``` wp-block-code
--students satisfaction by age range in Kobe school
ELECT (CASE WHEN DATE_PART('year',AGE(s.birth_date)) <= 18 THEN '<= 18'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 19 AND 24 then 'between 19 and 24'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 25 AND 34 then 'between 25 and 34'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 35 AND 44 then 'between 35 and 44'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 45 AND 54 then 'between 45 and 54'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 55 AND 64 then 'between 55 and 64'
             ELSE '> 65'
        END) AS age_category,
ROUND(AVG(l.rating),2) AS rating_average
FROM student AS s
JOIN lesson AS l ON s.student_id= l.student_id
JOIN school AS sc ON sc.school_id = l.school_id
WHERE sc.name='ESL Kobe'
GROUP BY age_category
ORDER BY rating_average DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_14d.jpg">
</p>
<p align="center">
<sup>In Kobe school, students between 25 and 34 years old are the most satisfied</sup>
</p>

``` wp-block-code
--students satisfaction by age range in Nara school
SELECT (CASE WHEN DATE_PART('year',AGE(s.birth_date)) <= 18 THEN '<= 18'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 19 AND 24 then 'between 19 and 24'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 25 AND 34 then 'between 25 and 34'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 35 AND 44 then 'between 35 and 44'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 45 AND 54 then 'between 45 and 54'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 55 AND 64 then 'between 55 and 64'
             ELSE '> 65'
        END) AS age_category,
ROUND(AVG(l.rating),2) AS rating_average
FROM student AS s
JOIN lesson AS l ON s.student_id= l.student_id
JOIN school AS sc ON sc.school_id = l.school_id
WHERE sc.name='ESL Nara'
GROUP BY age_category
ORDER BY rating_average DESC
```
<p align="center">
<img src="https://www.alessandroferrarese.com/wp-content/uploads/2022/07/Screenshot_14e.jpg">
</p>
<p align="center">
<sup>In Nara school, teenagers students are the most satisfied</sup>
</p>

## Share

Once that the
[questions](#ask)
were
[answered](#analyze),
the findings were shown to the ESL president through two dashboards.

The first dashboard answered the following statement:

> We would like to launch a targetted campaign. Depending on the prefecture of residence of our potential customers, different studying plans would be offered.

> For our offers, we also would like to consider different parameters like gender and age.

### [Open the Tableau Dashboard](https://public.tableau.com/views/ESL2/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link)

[![BEST TARGET
](https://public.tableau.com/static/images/ES/ESL2/Dashboard1/1_rss.png)]

A dropdown menu at the top shows findings about specific (or all)
schools.

This part of the dashboard answers the following questions:

  - What’s the age of the most satisfied students (age and age range in
    general and by school)?
  - What is students’ favorite time for lessons(in general and by
    school)?
  - What’s the most chosen plan by students (in general and by school)?
  - When do students usually enroll in ELS (in general and by school)?

Below it, two maps answer:

  - What’s the age average of the enrolled students (in general and by
    school)?
  - From which prefecture are the most satisfied student coming from?

The third and last part, at the bottom, answers:

  - What gender is the most satisfied with ELS methods (in general and
    by school)?

The second dashboard answered the following statement:

``` wp-block-verse
Other than getting new customers, mantaining our current students is essential. 
```

The analysis was focused on finding out where improvements should be
brought, highlighting the individuals' and the schools' characteristics.

Particular attention was used to students' preferences regarding
teachers' language-related skills. In this way, better student-teacher
pairing could bring higher customer satisfaction.

This dashboard answers the following questions:

  - Who are the teachers with low ratings?
  - In which school students are less satisfied with ESL methods?
  - What’s the school with fewer students?
  - Who is the staff with the lowest percentage of new students signups?
  - What kind of lessons is the less appreciated?
  - Is there a relationship between teachers’ skills (native speakers
    and/or Japanese speakers) and lesson ratings?
  - What level of students appreciates the most Japanese speakers
    teachers and native speakers teachers?

### [Open the Tableau Dashboard](https://public.tableau.com/views/ESL1_16586519370720/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link)

[![ESL INSIGHTS
](https://public.tableau.com/static/images/ES/ESL1_16586519370720/Dashboard1/1_rss.png)]

</div>


