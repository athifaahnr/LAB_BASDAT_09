-- Nama: Zahwa Dwi Putri
-- NIM: H071251065

CREATE TABLE pegawai(
	id_pegawai INT PRIMARY KEY,
	nama VARCHAR(100),
	umur INT,
	gaji NUMERIC (12,2),
	email VARCHAR(100),
	tanggal_masuk DATE,
	aktif BOOLEAN
);

SELECT * from pegawai;

CREATE TABLE siswa(
	nisn VARCHAR(10) PRIMARY KEY,
	nama_siswa VARCHAR(100) NOT NULL,
	nilai_rata NUMERIC (4,2) CHECK (nilai_rata >=0 AND nilai_rata <=100),
	email_siswa TEXT UNIQUE,
	tahun_masuk INT CHECK (tahun_masuk >=2000),
	status BOOLEAN DEFAULT FALSE
);

SELECT * from siswa;