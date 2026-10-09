-- SALWA AINIYYAH (H071251032)

-- latihan 1
CREATE TABLE pegawai (
	id_pegawain INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_pegawai VARCHAR(100),
	umur INTEGER,
	gaji NUMERIC(12,2),
	email VARCHAR(150),
	tanggal_masuk_kerja DATE,
	status_keaktifan_pegawai BOOLEAN
);

SELECT * FROM pegawai 

-- latihan 2
CREATE TABLE siswa (
	nisn VARCHAR(10) PRIMARY KEY,
	nama_siswa VARCHAR(100) NOT NULL,
	nilai_rata NUMERIC(5,2) CHECK (0<= nilai_rata AND nilai_rata <= 100),
	email VARCHAR(150) UNIQUE,
	tahun_masuk INT CHECK (tahun_masuk >= 200),
	status_kelulusan BOOLEAN DEFAULT FALSE
);

SELECT * FROM siswa 



