CREATE TABLE prodi (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_prodi VARCHAR(100) NOT NULL
);

CREATE TABLE mahasiswa (
    nim VARCHAR(10) PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    ipk NUMERIC(3,2) DEFAULT 0.00,
    email VARCHAR(150) UNIQUE,
    id_prodi INT,
    CONSTRAINT fk_mahasiswa_prodi
        FOREIGN KEY (id_prodi)
        REFERENCES prodi (id)
);

insert into prodi(nama_prodi) values('Sistem Informasi'), ('Matematika');


select * from prodi;

insert into mahasiswa(nim, nama, email, id_prodi)
values
('H11223344', 'Ahmad Panrita', 'nonaranovann@gmail.com', 1),
('H22334455', 'Novan', null, 1),
('H33445566', 'Nonara', 'testemail@gmail.com', 2)
returning *;

update mahasiswa set ipk=3.75 where ipk=3.50 returning *;

delete from mahasiswa where email is null returning *;