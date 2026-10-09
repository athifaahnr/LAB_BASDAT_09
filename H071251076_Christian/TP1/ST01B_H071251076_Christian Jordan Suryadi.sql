CREATE TABLE seller(
	id_seller INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_toko VARCHAR(100) UNIQUE NOT NULL,
	nama_pemilik VARCHAR(100) NOT NULL,
	email VARCHAR(150) UNIQUE NOT NULL,
	no_rekening VARCHAR(20) UNIQUE,
	saldo DECIMAL(15,2) NOT NULL DEFAULT(0) CHECK (saldo > 0),
	rating_toko NUMERIC(2,1) NOT NULL DEFAULT(0.0) CHECK (rating_toko <=5.0) CHECK(rating_toko >= 0.0),
	komisi_platform FLOAT CHECK (komisi_platform >= 0) CHECK(komisi_platform <= 100),
	waktu_daftar TIMESTAMP,
	status_verifikasi BOOLEAN DEFAULT('FALSE'),
	deskripsi_toko TEXT
);

SELECT * from seller;