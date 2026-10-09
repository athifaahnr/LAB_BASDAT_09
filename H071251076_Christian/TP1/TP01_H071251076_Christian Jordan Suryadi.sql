CREATE TABLE poliklinik (
	id_poli INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_poli VARCHAR(50) UNIQUE NOT NULL,
	gedung VARCHAR(50) NOT NULL
);

SELECT * from poliklinik;

CREATE TABLE pasien (
	id_pasien INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nik VARCHAR(16) UNIQUE NOT NULL,
	nama_pasien VARCHAR(150) NOT NULL,
	jenis_kelamin VARCHAR(1) CHECK (jenis_kelamin IN('L','P'))
);

SELECT * from pasien;

CREATE TABLE dokter (
	id_dokter INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_dokter VARCHAR(150) NOT NULL,
	no_izin_praktek VARCHAR(30) UNIQUE,
	pengalaman_tahun INT NOT NULL DEFAULT 0 CHECK (pengalaman_tahun >=0),
	id_poli INT,
		FOREIGN KEY (id_poli)
		REFERENCES poliklinik
);

SELECT * from dokter;

CREATE TABLE rekam_medis (
	id_rm INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	keluhan TEXT UNIQUE,
	biaya_pemeriksaan DECIMAL(15,2) NOT NULL DEFAULT 150000.00,
	id_pasien INT,
	id_dokter INT,
		FOREIGN KEY (id_pasien) REFERENCES pasien,
		FOREIGN KEY (id_dokter) REFERENCES dokter
);	

SELECT CONSTRAINT_NAME FROM information_schema.table_constraints WHERE TABLE_NAME = 'rekam_medis';
SELECT CONSTRAINT_NAME FROM information_schema.table_constraints WHERE TABLE_NAME = 'resep_obat';

CREATE TABLE resep_obat(
	id_reset INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_obat VARCHAR(100) NOT NULL,
	jumlah INT CHECK (jumlah > 0),
	id_rm INT,
		FOREIGN KEY (id_rm) REFERENCES rekam_medis
);

SELECT * from resep_obat;

ALTER TABLE pasien
ADD COLUMN gol_darah VARCHAR(2) CHECK (gol_darah IN('A','B','AB','O'));

ALTER TABLE resep_obat
ALTER COLUMN nama_obat TYPE TEXT;


ALTER TABLE poliklinik
DROP COLUMN gedung;

ALTER TABLE rekam_medis
	DROP CONSTRAINT rekam_medis_id_pasien_fkey,
	DROP CONSTRAINT rekam_medis_id_dokter_fkey;

ALTER TABLE resep_obat
	DROP CONSTRAINT resep_obat_id_rm_fkey;

DROP TABLE rekam_medis;
DROP TABLE resep_obat;