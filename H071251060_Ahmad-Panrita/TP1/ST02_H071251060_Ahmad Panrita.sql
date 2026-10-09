create table seller (
	id_seller bigint generated always as identity primary key,
	nama_toko varchar(100) not null unique,
	nama_pemilik varchar(100) not null,
	email varchar(150) not null unique,
	nomor_rekening varchar(20) unique,
	saldo numeric(15,2) check(saldo >=0) default 0,
	rating_toko numeric(2,1) check (rating_toko >= 0 and rating_toko <= 5.0) default 0.0,
	komisi_platform double precision check(komisi_platform >= 0 and komisi_platform <= 100),
	tanggal_pendaftaran timestamp,
	status_verifikasi boolean,
	deskripsi text
);

drop table seller;

select * from seller;

