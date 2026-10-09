create table pegawai (
	id_primary int generated always as identity primary key,
	nama varchar (100) not null,
	umur int,
	gaji numeric(12,2),
	email varchar(150) unique,
	tanggal_masuk date,
	aktif boolean
);

