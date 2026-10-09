create database db_rs_sejahtera;

-- Soal 1

create table poliklinik (
	id_poli int generated always as identity primary key,
	nama_poli varchar(50) not null unique,
	gedung varchar(50) not null
);

-- create type jen_kel as enum (
-- 	'laki-laki',
-- 	'perempuan'
-- );

create table pasien (
	id_pasien int generated always as identity primary key,
	nik varchar(16) not null unique,
	nama_pasien varchar(150) not null,
	jenis_kelamin varchar(1) check(jenis_kelamin in ('l','p'))
);

create table dokter (
	id_dokter int generated always as identity primary key,
	nama_dokter varchar(150) not null,
	no_izin_praktek varchar(30) unique,
	pengalaman_tahun int default 0,
	id_poli int,
	constraint for_id_poli
		foreign key (id_poli)
		references poliklinik(id_poli)
);

create table rekam_medis (
	id_rm int generated always as identity primary key,
	keluhan varchar not null,
	biaya_pemeriksaan numeric(12, 2) default 15000,
	id_pasien int,
	constraint for_id_pasien
		foreign key (id_pasien)
		references pasien(id_pasien),
	id_dokter int,
	constraint for_id_dokter
		foreign key (id_dokter)
		references dokter(id_dokter)
);

create table resep_obat (
	id_resep int generated always as identity primary key,
	nama_obat varchar(100) not null,
	jumlah int check(jumlah > 0),
	id_rm int,
	constraint for_id_rm
		foreign key (id_rm)
		references rekam_medis(id_rm)
);

-- Soal 2

alter table pasien add column gol_darah varchar(2);
alter table resep_obat alter column nama_obat type varchar;
alter table poliklinik drop column gedung;


-- Soal 3


drop table rekam_medis;
drop table resep_obat;
