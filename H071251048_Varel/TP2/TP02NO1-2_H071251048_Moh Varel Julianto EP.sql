SELECT * FROM prodi

INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES
('H071251090', 'bang Windut', 'windut@gmail.com', 1),
('H071251091', 'Miaw Aum Aum Aum', NULL, 2),
('H071251092', 'Lutpi Halimawong', 'lutpi@gmail.com', 1);

SELECT * FROM mahasiswa;

INSERT INTO prodi (nama_prodi)
VALUES
('Sistem Informasi'),
('Informatika');

SELECT * FROM prodi;

UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 0.00;

DELETE FROM mahasiswa
WHERE email IS NULL;

SELECT * FROM mahasiswa;