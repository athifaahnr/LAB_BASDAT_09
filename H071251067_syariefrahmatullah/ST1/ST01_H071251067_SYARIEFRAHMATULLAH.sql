-- nomor 1
CREATE TABLE pegawai(
	id_pegawai INT PRIMARY KEY,
	nama_pengguna VARCHAR(100),
	umur INT,
	gaji NUMERIC(12,2),
	email VARCHAR(150)UNIQUE,
	tanggal_masuk_kerja DATE,
	status_kp BOOLEAN
	
	
);
SELECT * FROM  pegawai;

 -- nomor 2
 CREATE TABLE seller(
	id_seller INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_toko VARCHAR(100) NOT NULL UNIQUE,
	nama_pemilik  VARCHAR(100) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	nomor_rekening VARCHAR(20) UNIQUE,
	saldo NUMERIC(15,2) DEFAULT 0 CHECK(saldo>=0),
	rating_toko NUMERIC(2,1) DEFAULT 0 CHECK(rating_toko BETWEEN 0.0 AND 5.0),
	komisi_platfrom DOUBLE PRECISION CHECK(komisi_platfrom <= 0 AND komisi_platfrom <= 100),
	tanggal_wp TIMESTAMP,
	status_verifikasi BOOLEAN DEFAULT('FALSE'),
	deskripsi_toko TEXT
);
SELECT * FROM seller;


