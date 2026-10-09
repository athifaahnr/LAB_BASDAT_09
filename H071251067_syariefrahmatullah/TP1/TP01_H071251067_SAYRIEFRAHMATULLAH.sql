CREATE TABLE poliklinik(
	id_poli INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_poli VARCHAR(50) NOT NULL UNIQUE,
	gedung VARCHAR(50) NOT NULL
);

CREATE TABLE pasien(
	id_pasien INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nik VARCHAR(16) NOT NULL UNIQUE,
	nama_pasien VARCHAR(150) NOT NULL,
	jenis_kelamin VARCHAR(1) CHECK (jenis_kelamin IN('L','P'))
);

CREATE TABLE doktor(
	id_dokter INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_dokter VARCHAR(150) NOT NULL,
	no_izin_praktik VARCHAR(30) UNIQUE,
	pengalaman_tahun INT CHECK(pengalaman_tahun >= 0) DEFAULT 0,
	id_poli INT ,
		CONSTRAINT fk_doktor_poliklinik
			FOREIGN KEY (id_poli)
			REFERENCES poliklinik(id_poli)
);

CREATE TABLE rekam_medis(
	id_rm INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	keluhan TEXT NOT NULL,
	biaya_pemeriksaan NUMERIC(8,2) DEFAULT 150000,
	id_pasien INT,
		CONSTRAINT fk_rekam_medis_pasien
			FOREIGN KEY (id_pasien)
			REFERENCES pasien(id_pasien),
	id_dokter INT,
		CONSTRAINT fk_rekam_medis_doktor
			FOREIGN KEY (id_dokter)
			REFERENCES doktor(id_dokter)
);

CREATE TABLE resep_obat(
	id_resep INT GENERATED ALWAYS AS IDENTITY PRIMARY KEy,
	nama_obat VARCHAR(100) NOT NULL,
	jumlah INT CHECK(jumlah >0),
	id_rm INT,
		CONSTRAINT fk_resep_obat_rekam_medis
			FOREIGN KEY (id_rm)
			REFERENCES rekam_medis(id_rm)
);



--soal 2--

ALTER TABLE pasien
	ADD COLUMN gol_darah VARCHAR(2);
ALTER TABLE resep_obat
	ALTER COLUMN nama_obat TYPE TEXT;
ALTER TABLE poliklinik
	DROP COLUMN gedung;


--soal 3--

DROP TABLE resep_obat;
DROP TABLE rekam_medis;











