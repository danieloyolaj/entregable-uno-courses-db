/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     24/09/2022 19:39:35                          */
/*==============================================================*/


--Table: CATEGORIES
create table CATEGORIES (
   CATEGORY_ID          uuid                 not null,
   CATEGORY_NAME        VARCHAR(100)         not null,
   constraint PK_CATEGORIES primary key (CATEGORY_ID)
);

--Index: CATEGORIES_PK
create unique index CATEGORIES_PK on CATEGORIES (
CATEGORY_ID
);

--Table: COURSES
create table COURSES (
   COURSES_ID           uuid                 not null,
   CATEGORY_ID          uuid                 null,
   LEVEL_ID             uuid                 null,
   COURSE_TITLE         TEXT                 not null,
   COURSE_DESCRIPTION   TEXT                 null,
   DATE_CREATED         DATE                 not null,
   constraint PK_COURSES primary key (COURSES_ID)
);

Index: COURSES_PK
create unique index COURSES_PK on COURSES (
COURSES_ID
);

--Index: COURSE_BELONGS_CATEGORY_FK
create  index COURSE_BELONGS_CATEGORY_FK on COURSES (
CATEGORY_ID
);

--Index: COURSE_HAS_LEVEL_FK
create  index COURSE_HAS_LEVEL_FK on COURSES (
LEVEL_ID
);

--Table: COURSE_HAS_VIDEO
create table COURSE_HAS_VIDEO (
   COURSES_ID           uuid                 not null,
   VIDEO_ID             uuid                 not null,
   constraint PK_COURSE_HAS_VIDEO primary key (COURSES_ID, VIDEO_ID)
);

--Index: COURSE_HAS_VIDEO_PK
create unique index COURSE_HAS_VIDEO_PK on COURSE_HAS_VIDEO (
COURSES_ID,
VIDEO_ID
);

--Index: COURSE_HAS_VIDEO_FK
create  index COURSE_HAS_VIDEO_FK on COURSE_HAS_VIDEO (
COURSES_ID
);

--Index: COURSE_HAS_VIDEO2_FK
create  index COURSE_HAS_VIDEO2_FK on COURSE_HAS_VIDEO (
VIDEO_ID
);

--Table: COURSE_VIDEO
create table COURSE_VIDEO (
   VIDEO_ID             uuid                 not null,
   VIDEO_TITLE          TEXT                 not null,
   VIDEO_URL            TEXT                 not null,
   DATE_CREATED         DATE                 not null,
   constraint PK_COURSE_VIDEO primary key (VIDEO_ID)
);

--Index: COURSE_VIDEO_PK
create unique index COURSE_VIDEO_PK on COURSE_VIDEO (
VIDEO_ID
);

--Table: LEVEL
create table LEVEL (
   LEVEL_ID             uuid                 not null,
   LEVEL                VARCHAR(50)          not null,
   constraint PK_LEVEL primary key (LEVEL_ID)
);

--Index: LEVEL_PK
create unique index LEVEL_PK on LEVEL (
LEVEL_ID
);

--Table: ROLES
create table ROLES (
   ROLE_ID              uuid                 not null,
   ROLE                 VARCHAR(100)         null,
   constraint PK_ROLES primary key (ROLE_ID)
);

--Index: ROLES_PK
create unique index ROLES_PK on ROLES (
ROLE_ID
);

--Table: STATUS
create table STATUS (
   STATUS_ID            uuid                 not null,
   STATUS               VARCHAR(50)          null,
   constraint PK_STATUS primary key (STATUS_ID)
);

--Index: STATUS_PK
create unique index STATUS_PK on STATUS (
STATUS_ID
);

--Table: USERS
create table USERS (
   USER_ID              uuid                 not null,
   STATUS_ID            uuid                 not null,
   ROLE_ID              uuid                 not null,
   USER_NAME            VARCHAR(50)          null,
   USER_LAST_NAME       VARCHAR(50)          null,
   EMAIL                VARCHAR(100)         not null,
   PASSWORD             VARCHAR(70)          not null,
   CELLPHONE            VARCHAR(15)          null,
   AGE                  INT4                 null,
   DATE_CREATED         DATE                 not null,
   LAST_LOGIN           DATE                 not null,
   constraint PK_USERS primary key (USER_ID)
);

--Index: USERS_PK
create unique index USERS_PK on USERS (
USER_ID
);

--Index: USER_HAS_ROLE_FK
create  index USER_HAS_ROLE_FK on USERS (
ROLE_ID
);

--Index: USER_HAS_STATUS_FK
create  index USER_HAS_STATUS_FK on USERS (
STATUS_ID
);

--Table: USER_HAS_COURSE
create table USER_HAS_COURSE (
   USER_ID              uuid                 not null,
   COURSES_ID           uuid                 not null,
   constraint PK_USER_HAS_COURSE primary key (USER_ID, COURSES_ID)
);

--Index: USER_HAS_COURSE_PK
create unique index USER_HAS_COURSE_PK on USER_HAS_COURSE (
USER_ID,
COURSES_ID
);

--Index: USER_HAS_COURSE_FK
create  index USER_HAS_COURSE_FK on USER_HAS_COURSE (
USER_ID
);

--Index: USER_HAS_COURSE2_FK
create  index USER_HAS_COURSE2_FK on USER_HAS_COURSE (
COURSES_ID
);

alter table COURSES
   add constraint FK_COURSES_COURSE_BE_CATEGORI foreign key (CATEGORY_ID)
      references CATEGORIES (CATEGORY_ID)
      on delete restrict on update cascade;

alter table COURSES
   add constraint FK_COURSES_COURSE_HA_LEVEL foreign key (LEVEL_ID)
      references LEVEL (LEVEL_ID)
      on delete restrict on update cascade;

alter table COURSE_HAS_VIDEO
   add constraint FK_COURSE_H_COURSE_HA_COURSES foreign key (COURSES_ID)
      references COURSES (COURSES_ID)
      on delete restrict on update cascade;

alter table COURSE_HAS_VIDEO
   add constraint FK_COURSE_H_COURSE_HA_COURSE_V foreign key (VIDEO_ID)
      references COURSE_VIDEO (VIDEO_ID)
      on delete restrict on update cascade;

alter table USERS
   add constraint FK_USERS_USER_HAS__ROLES foreign key (ROLE_ID)
      references ROLES (ROLE_ID)
      on delete restrict on update cascade;

alter table USERS
   add constraint FK_USERS_USER_HAS__STATUS foreign key (STATUS_ID)
      references STATUS (STATUS_ID)
      on delete restrict on update cascade;

alter table USER_HAS_COURSE
   add constraint FK_USER_HAS_USER_HAS__USERS foreign key (USER_ID)
      references USERS (USER_ID)
      on delete restrict on update cascade;

alter table USER_HAS_COURSE
   add constraint FK_USER_HAS_USER_HAS__COURSES foreign key (COURSES_ID)
      references COURSES (COURSES_ID)
      on delete restrict on update cascade;

