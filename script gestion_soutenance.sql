/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  28/07/2023 09:50:29                      */
/*==============================================================*/


drop table if exists demandes_soutenance;

drop table if exists directeurs_memoires;

drop table if exists enseignants;

drop table if exists etudiants;

drop table if exists jury;

drop table if exists maitre_de_stage;

drop table if exists notifications;

drop table if exists presidents_du_jury;

drop table if exists roles;

drop table if exists salles;

drop table if exists soutenances;

drop table if exists utilisateurs;

/*==============================================================*/
/* Table : demandes_soutenance                                  */
/*==============================================================*/
create table demandes_soutenance
(
   id_demande           int not null,
   id_etudiant          int not null,
   id_utilisateur       int not null,
   titre                varchar(254),
   resume_              varchar(254),
   statut               varchar(254),
   date_soumission      datetime,
   etablissement        varchar(254),
   primary key (id_demande)
);

/*==============================================================*/
/* Table : directeurs_memoires                                  */
/*==============================================================*/
create table directeurs_memoires
(
   id_dm                int not null,
   nom                  varchar(254),
   prenom               varchar(254),
   adresse              varchar(254),
   telephone            int,
   fonction             varchar(254),
   primary key (id_dm)
);

/*==============================================================*/
/* Table : enseignants                                          */
/*==============================================================*/
create table enseignants
(
   id_enseignant        int not null,
   nom                  varchar(254),
   prenom               varchar(254),
   telephone            int,
   email                varchar(254),
   fonction             varchar(254),
   primary key (id_enseignant)
);

/*==============================================================*/
/* Table : etudiants                                            */
/*==============================================================*/
create table etudiants
(
   id_etudiant          int not null,
   id_utilisateur       int,
   id_maitre            int not null,
   id_dm                int not null,
   nom                  varchar(254),
   prenom               varchar(254),
   telephone            varchar(254),
   email                int,
   filiere              varchar(254),
   primary key (id_etudiant)
);

/*==============================================================*/
/* Table : jury                                                 */
/*==============================================================*/
create table jury
(
   id_jury              int not null,
   id_president         int not null,
   id_utilisateur       int not null,
   id_enseignant        int not null,
   id_dm                int not null,
   id_maitre            int,
   nom                  varchar(254),
   primary key (id_jury)
);

/*==============================================================*/
/* Table : maitre_de_stage                                      */
/*==============================================================*/
create table maitre_de_stage
(
   id_maitre            int not null,
   nom                  varchar(254),
   prenom               varchar(254),
   telephone            int,
   email                varchar(254),
   fonction             varchar(254),
   primary key (id_maitre)
);

/*==============================================================*/
/* Table : notifications                                        */
/*==============================================================*/
create table notifications
(
   id_notification      int not null,
   id_utilisateur       int not null,
   contenu              varchar(254),
   date_                datetime,
   primary key (id_notification)
);

/*==============================================================*/
/* Table : presidents_du_jury                                   */
/*==============================================================*/
create table presidents_du_jury
(
   id_president         int not null,
   nom                  varchar(254),
   prenom               varchar(254),
   affiliation          varchar(254),
   telephone            int,
   email                varchar(254),
   primary key (id_president)
);

/*==============================================================*/
/* Table : roles                                                */
/*==============================================================*/
create table roles
(
   id_role              int not null,
   role_                varchar(254),
   primary key (id_role)
);

/*==============================================================*/
/* Table : salles                                               */
/*==============================================================*/
create table salles
(
   id_salle             int not null,
   id_utilisateur       int not null,
   nom_salle            varchar(254),
   capacite             int,
   equipements          varchar(254),
   primary key (id_salle)
);

/*==============================================================*/
/* Table : soutenances                                          */
/*==============================================================*/
create table soutenances
(
   id_soutenance        int not null,
   id_jury              int not null,
   id_salle             int not null,
   id_demande           int not null,
   id_utilisateur       int not null,
   date_                datetime,
   heure                varchar(254),
   statut               varchar(254),
   primary key (id_soutenance)
);

/*==============================================================*/
/* Table : utilisateurs                                         */
/*==============================================================*/
create table utilisateurs
(
   id_utilisateur       int not null,
   id_role              int not null,
   nom                  varchar(254),
   prenom               varchar(254),
   email                varchar(254),
   telephone            int,
   mot_de_passe         varchar(254),
   primary key (id_utilisateur)
);

alter table demandes_soutenance add constraint FK_Association_13 foreign key (id_utilisateur)
      references utilisateurs (id_utilisateur) on delete restrict on update restrict;

alter table demandes_soutenance add constraint FK_Association_4 foreign key (id_etudiant)
      references etudiants (id_etudiant) on delete restrict on update restrict;

alter table etudiants add constraint FK_Association_17 foreign key (id_utilisateur)
      references utilisateurs (id_utilisateur) on delete restrict on update restrict;

alter table etudiants add constraint FK_Association_3 foreign key (id_dm)
      references directeurs_memoires (id_dm) on delete restrict on update restrict;

alter table etudiants add constraint FK_Association_6 foreign key (id_maitre)
      references maitre_de_stage (id_maitre) on delete restrict on update restrict;

alter table jury add constraint FK_Association_1 foreign key (id_maitre)
      references maitre_de_stage (id_maitre) on delete restrict on update restrict;

alter table jury add constraint FK_Association_15 foreign key (id_utilisateur)
      references utilisateurs (id_utilisateur) on delete restrict on update restrict;

alter table jury add constraint FK_Association_2 foreign key (id_dm)
      references directeurs_memoires (id_dm) on delete restrict on update restrict;

alter table jury add constraint FK_Association_7 foreign key (id_president)
      references presidents_du_jury (id_president) on delete restrict on update restrict;

alter table jury add constraint FK_Association_9 foreign key (id_enseignant)
      references enseignants (id_enseignant) on delete restrict on update restrict;

alter table notifications add constraint FK_Association_14 foreign key (id_utilisateur)
      references utilisateurs (id_utilisateur) on delete restrict on update restrict;

alter table salles add constraint FK_Association_16 foreign key (id_utilisateur)
      references utilisateurs (id_utilisateur) on delete restrict on update restrict;

alter table soutenances add constraint FK_Association_10 foreign key (id_salle)
      references salles (id_salle) on delete restrict on update restrict;

alter table soutenances add constraint FK_Association_12 foreign key (id_utilisateur)
      references utilisateurs (id_utilisateur) on delete restrict on update restrict;

alter table soutenances add constraint FK_Association_5 foreign key (id_demande)
      references demandes_soutenance (id_demande) on delete restrict on update restrict;

alter table soutenances add constraint FK_Association_8 foreign key (id_jury)
      references jury (id_jury) on delete restrict on update restrict;

alter table utilisateurs add constraint FK_Association_11 foreign key (id_role)
      references roles (id_role) on delete restrict on update restrict;

