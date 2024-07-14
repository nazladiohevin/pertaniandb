-- Buat database pertanian
CREATE DATABASE pertanian;
USE pertanian;

-- Tabel Detail Lahan
CREATE TABLE detail_lahan (
  lahan_detail_id int NOT NULL AUTO_INCREMENT,
  lahan_id int DEFAULT NULL,
  tanaman_id int DEFAULT NULL,
  petani_id int DEFAULT NULL,
  PRIMARY KEY (lahan_detail_id),  
  FOREIGN KEY (lahan_id) REFERENCES lahan (lahan_id),
  FOREIGN KEY (tanaman_id) REFERENCES tanaman (tanaman_id),
  FOREIGN KEY (petani_id) REFERENCES petani (petani_id)
);
INSERT INTO detail_lahan (lahan_id, tanaman_id, petani_id) VALUES
	(1, 2, 1),
	(1, 2, 2),
	(1, 1, 5),
	(2, 3, 3),
	(3, 3, 4);

-- Tabel Detail Transaksi Penjualan
CREATE TABLE detail_transaksi_penjualan (
  transaksi_detail_id int NOT NULL AUTO_INCREMENT,
  transaksi_id int DEFAULT NULL,
  petani_id int DEFAULT NULL,
  tanaman_id int DEFAULT NULL,
  PRIMARY KEY (transaksi_detail_id),  
  FOREIGN KEY (transaksi_id) REFERENCES transaksi_penjualan (transaksi_id),
  FOREIGN KEY (petani_id) REFERENCES petani (petani_id),
  FOREIGN KEY (tanaman_id) REFERENCES tanaman (tanaman_id)
);
INSERT INTO detail_transaksi_penjualan (transaksi_id, petani_id, tanaman_id) VALUES
	(1, 1, 1),
	(2, 2, 2),
	(3, 3, 3),
	(4, 4, 1),
	(5, 5, 2),
	(6, 1, 3),
	(7, 2, 1),
	(8, 2, 2);

-- Tabel Hasil Panen
CREATE TABLE hasil_panen (
  hasil_panen_id int NOT NULL AUTO_INCREMENT,
  petani_id int DEFAULT NULL,
  stok int DEFAULT NULL,
  satuan_stok enum('kg','karung','gram') DEFAULT NULL,
  PRIMARY KEY (hasil_panen_id),  
  FOREIGN KEY (petani_id) REFERENCES petani (petani_id)
);
INSERT INTO hasil_panen (petani_id, stok, satuan_stok) VALUES
	(1, 500, 'kg'),
	(2, 300, 'kg'),
	(5, 3000, 'kg'),
	(3, 2500, 'kg'),
	(4, 2000, 'kg');

-- Tabel Lahan
CREATE TABLE lahan (
  lahan_id int NOT NULL AUTO_INCREMENT,
  lokasi text,
  luas int DEFAULT NULL,
  PRIMARY KEY (lahan_id)
);
INSERT INTO lahan (lokasi, luas) VALUES
	('Mororejo', 3000),
	('Gamping', 2000),
	('Tulung', 1500),
	('Condongcatur', 2000),
	('Ngemplak', 2100);

-- Tabel Pembeli
CREATE TABLE pembeli (
  pembeli_id int NOT NULL AUTO_INCREMENT,
  nama varchar(255) DEFAULT NULL,
  alamat text,
  PRIMARY KEY (pembeli_id)
);
INSERT INTO pembeli (nama, alamat) VALUES
	('Gunawan sylvester', 'Jakarta'),
	('Eko Hidayatullah', 'Magelang'),
	('Faisal pambudi', 'Surabaya');
	('Pranoto', 'Klaten');
	('Sri Handayani', 'Surabaya');


-- Tabel Petani
CREATE TABLE petani (
  petani_id INT NOT NULL AUTO_INCREMENT,
  nama VARCHAR(255) DEFAULT NULL,
  alamat TEXT,
  PRIMARY KEY (petani_id)
);
INSERT INTO petani (nama, alamat) VALUES
	('Erwan Edy Purwoko', 'Mororejo,Tempel,Sleman'),
	('Muhammad Agung Reza', 'Mororejo,Tempel,Sleman'),
	('Edwin Salim', 'Gamping,Sleman'),
	('Nazla Dio Hevin', 'Tulung,Klaten'),
	('Rahmat Riyadi', 'Mororejo,Tempel,Sleman');


-- Tabel Tanaman
CREATE TABLE tanaman (
  tanaman_id int NOT NULL AUTO_INCREMENT,
  nama varchar(255) DEFAULT NULL,
  deskripsi text,
  waktu_panen int DEFAULT NULL,
  harga int DEFAULT NULL,
  harga_satuan enum('kg','karung') DEFAULT NULL,
  PRIMARY KEY (`tanaman_id`)
);
INSERT INTO tanaman (nama, deskripsi, waktu_panen, harga, harga_satuan) VALUES
	('Padi', 'Tanaman Padi', 90, 6500, 'kg'),
	('Cabai', 'Tanaman Cabai', 90, 35000, 'kg'),
	('Jagung', 'Tanaman Jagung', 90, 6000, 'kg'),
	('Kedelai', 'Kedelai delai hitam', 120, 11000, 'kg'),
	('Tomat', 'Tomat madu', 100, 12000, 'kg');


-- TABEL TRANSAKSI PENJUALAN
CREATE TABLE transaksi_penjualan (
  transaksi_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  pembeli_id int NOT NULL,
  status enum('gagal','menunggu','selesai') DEFAULT NULL,
  FOREIGN KEY (pembeli_id) REFERENCES pembeli (pembeli_id)
);
INSERT INTO transaksi_penjualan (pembeli_id, status) VALUES
	(1, 'selesai'),
	(2, 'selesai'),
	(3, 'menunggu'),
	(1, 'menunggu'),
	(1, 'gagal'),
	(2, 'gagal'),
	(1, 'selesai'),
	(3, 'selesai');


-- A. Function
-- Pembuatan function GetDaftarPetani
DELIMITER //

CREATE FUNCTION GetDaftarPetani()
RETURNS VARCHAR(1000)
DETERMINISTIC
BEGIN
    DECLARE daftar_petani VARCHAR(1000);
    SET daftar_petani = '';
    SELECT GROUP_CONCAT(nama SEPARATOR ', ') INTO daftar_petani FROM petani;
    RETURN daftar_petani;
END //

DELIMITER ;

DELIMITER //

-- Pembuatan function GetTotalHasilPanen
CREATE FUNCTION GetTotalHasilPanen(tanamanID INT, tanggalPanen DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_hasil INT;
    
    -- Mengambil total hasil panen
    SELECT SUM(jumlah_hasil) INTO total_hasil
    FROM panen
    WHERE tanaman_id = tanamanID AND tanggal = tanggalPanen;
    
    RETURN total_hasil;
END //

DELIMITER ;

-- Memanggil function GetDaftarPetani
SELECT GetDaftarPetani();
-- Memanggil function GetTotalHasilPanen
SELECT GetTotalHasilPanen(1, '2023-07-08');
-- Menampilkan daftar function
SHOW FUNCTION STATUS WHERE Db = 'Pertanian';


-- B. Procedure
-- Pembuatan procedure ShowAllPetani
DELIMITER //
 
CREATE PROCEDURE ShowAllPetani()
BEGIN
	SELECT * FROM Petani;
END //
 
DELIMITER ;

-- Pembuatan procedure GetHasilPanenByTanamanAndDate
DELIMITER //

CREATE PROCEDURE GetHasilPanenByTanamanAndDate(IN tanamanID INT, IN tanggalPanen DATE)
BEGIN
	DECLARE hasil INT;	
	SELECT SUM(jumlah_hasil) INTO hasil
	FROM Panen
	WHERE tanaman_id = tanamanID AND tanggal = tanggalPanen;
    
	IF hasil IS NULL THEN
    	SET hasil = 0;
	END IF;
	
	SELECT hasil AS total_hasil_panen;
END //
 
DELIMITER ;

-- Pembuatan function ShowAllPetaniWithLoop
DELIMITER //
 
CREATE PROCEDURE ShowAllPetaniWithLoop()
BEGIN
	DECLARE done INT DEFAULT 0;
	DECLARE petani_id INT;
	DECLARE nama VARCHAR(100);
	DECLARE alamat VARCHAR(255);
	DECLARE petani_cursor CURSOR FOR SELECT petani_id, nama, alamat FROM Petani;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
 
	OPEN petani_cursor;
	
	read_loop: LOOP
    	FETCH petani_cursor INTO petani_id, nama, alamat;
    	IF done THEN
        	LEAVE read_loop;
    	END IF;
    	SELECT petani_id, nama, alamat;
	END LOOP;
	
	CLOSE petani_cursor;
END //
 
DELIMITER ;

-- Eksesuksi procedure
CALL ShowAllPetani();
CALL GetHasilPanenByDate('2023-07-01');


-- C. Trigger
-- Pembuatan tabel log_aktivitas
CREATE TABLE IF NOT EXISTS log_aktivitas (
  log_id int NOT NULL AUTO_INCREMENT,
  tabel varchar(255) DEFAULT NULL,
  aksi varchar(255) DEFAULT NULL,
  waktu datetime DEFAULT NULL,
  data_lama text,
  data_baru text,
  PRIMARY KEY (log_id)
)

-- trigger before insert
DELIMITER //
CREATE TRIGGER before_tanaman_insert
BEFORE INSERT ON tanaman
FOR EACH ROW
BEGIN
  INSERT INTO log_aktivitas (tabel, aksi, waktu, data_lama, data_baru)
  VALUES ('tanaman', 'INSERT', NOW(), NULL, CONCAT('nama:', NEW.nama, ', deskripsi:', NEW.deskripsi, ', harga:', NEW.harga));
END;
//
DELIMITER ;
-- testing 
INSERT INTO tanaman (nama, deskripsi, waktu_panen, harga, harga_satuan) VALUES
	('Kentang', 'Kentang cerah', 150, 18000, 'kg');

-- trigger before update
DELIMITER //
CREATE TRIGGER before_hasil_panen_update
BEFORE UPDATE ON hasil_panen
FOR EACH ROW
BEGIN
  INSERT INTO log_aktivitas (tabel, aksi, waktu, data_lama, data_baru)
  VALUES ('hasil_panen', 'UPDATE', NOW(), CONCAT('petani_id:', OLD.petani_id, ', stok:', OLD.stok, ', satuan_stok:', OLD.satuan_stok), CONCAT('petani_id:', NEW.petani_id, ', stok:', NEW.stok, ', satuan_stok:', NEW.satuan_stok));
END;
//
DELIMITER ;
-- testing
UPDATE hasil_panen SET stok=500 WHERE hasil_panen_id = 2;

-- trigger before delete
DELIMITER //
CREATE TRIGGER before_lahan_delete
BEFORE DELETE ON lahan
FOR EACH ROW
BEGIN
  INSERT INTO log_aktivitas (tabel, aksi, waktu, data_lama, data_baru)
  VALUES ('lahan', 'DELETE', NOW(), CONCAT('lokasi:', OLD.lokasi, ', luas:', OLD.luas), NULL);
END;
//
DELIMITER ;
-- testing
DELETE FROM lahan WHERE lahan_id = 3;

-- trigger after insert
DELIMITER //
CREATE TRIGGER after_transaksi_insert
AFTER INSERT ON transaksi_penjualan
FOR EACH ROW
BEGIN
  INSERT INTO log_aktivitas (tabel, aksi, waktu, data_lama, data_baru)
  VALUES ('transaksi_penjualan', 'INSERT', NOW(), NULL, CONCAT('pembeli_id:', NEW.pembeli_id, ', status:', NEW.status));
END;
//
DELIMITER ;
-- testing
INSERT INTO transaksi_penjualan (pembeli_id, status) VALUES
	(3, 'gagal')

-- trigger after update
DELIMITER //
CREATE TRIGGER after_pembeli_update
AFTER UPDATE ON pembeli
FOR EACH ROW
BEGIN
  INSERT INTO log_aktivitas (tabel, aksi, waktu, data_lama, data_baru)
  VALUES ('pembeli', 'UPDATE', NOW(), CONCAT('nama:', OLD.nama, ', alamat:', OLD.alamat), CONCAT('nama:', NEW.nama, ', alamat:', NEW.alamat));
END;
//
DELIMITER ;
-- testing
UPDATE pembeli SET alamat="Putusibau, Kalimantan Selatan" WHERE 
pembeli_id = 1;

-- trigger after delete
DELIMITER //
CREATE TRIGGER after_detail_transaksi_delete
AFTER DELETE ON detail_transaksi_penjualan
FOR EACH ROW
BEGIN
  INSERT INTO log_aktivitas (tabel, aksi, waktu, data_lama, data_baru)
  VALUES ('detail_transaksi_penjualan', 'DELETE', NOW(), CONCAT('transaksi_id:', OLD.transaksi_id, ', petani_id:', OLD.petani_id, ', tanaman_id:', OLD.tanaman_id), NULL);
END;
//
DELIMITER ;
-- testing
DELETE FROM detail_transaksi_penjualan WHERE transaksi_detail_id = 1;

-- Menampilkan daftar trigger
SHOW TRIGGERS FROM pertanian;



-- D. Index
CREATE TABLE orders (
    order_id INT,
    user_id INT,
    product_id INT,
    order_date DATE,
    PRIMARY KEY (order_id, user_id),
    INDEX idx_user_product (user_id, product_id)
);
-- index dg create index
CREATE INDEX idx_order_date_user ON orders (order_date, user_id);
-- index alter table
ALTER TABLE orders ADD INDEX idx_product_order (product_id, order_date);
-- tampilkan daftar index
SHOW INDEX FROM orders;


-- E. View
-- horizontal view
CREATE VIEW horizontal_view AS
SELECT 
    dtp.transaksi_detail_id, 
    tp.transaksi_id, 
    p.nama AS petani_nama, 
    t.nama AS tanaman_nama, 
    tp.status
FROM 
    detail_transaksi_penjualan dtp
JOIN 
    transaksi_penjualan tp 
    ON dtp.transaksi_id = tp.transaksi_id
JOIN 
    petani p 
    ON dtp.petani_id = p.petani_id
JOIN 
    tanaman t 

-- vertical view
CREATE VIEW vertical_view AS
SELECT 
    petani_id, 
    nama, 
    alamat
FROM 
    petani;

-- 
CREATE VIEW base_view AS
SELECT 
    dtp.transaksi_detail_id, 
    p.nama AS petani_nama, 
    t.nama AS tanaman_nama
FROM 
    detail_transaksi_penjualan dtp
JOIN 
    petani p ON dtp.petani_id = p.petani_id
JOIN 
    tanaman t ON dtp.tanaman_id = t.tanaman_id;

CREATE VIEW view_inside_view AS
SELECT 
    bv.transaksi_detail_id, 
    bv.petani_nama, 
    bv.tanaman_nama, 
    tp.status
FROM 
    base_view bv
JOIN 
    transaksi_penjualan tp ON bv.transaksi_detail_id = tp.transaksi_id;

-- clause with check option
CREATE VIEW base_view AS
SELECT dtp.transaksi_detail_id, p.nama AS petani_nama, t.nama AS tanaman_nama
FROM detail_transaksi_penjualan dtp
JOIN petani p ON dtp.petani_id = p.petani_id
JOIN tanaman t ON dtp.tanaman_id = t.tanaman_id;

CREATE VIEW view_inside_view AS
SELECT bv.transaksi_detail_id, bv.petani_nama, bv.tanaman_nama, tp.status
FROM base_view bv
JOIN transaksi_penjualan tp ON bv.transaksi_detail_id = tp.transaksi_id
WITH CASCADED CHECK OPTION;

-- eksekusi dengan update
UPDATE view_inside_view SET status = 'selesai' WHERE transaksi_detail_id = 1;
-- eksekusi dengan insert
INSERT INTO detail_transaksi_penjualan (transaksi_detail_id, transaksi_id, petani_id, tanaman_id) VALUES (10, 2, 1, 1);
-- tampilkan daftar view
SHOW FULL TABLES IN pertanian WHERE TABLE_TYPE LIKE 'VIEW';


-- F. Database Security
-- buat user
CREATE USER 'user1'@'localhost' IDENTIFIED BY '12345';
CREATE USER 'user2'@'localhost' IDENTIFIED BY '12345';
CREATE USER 'user3'@'localhost' IDENTIFIED BY '12345';

-- buat role
CREATE ROLE 'finance';
CREATE ROLE 'human_dev';
CREATE ROLE 'warehouse';

-- hak akses user1
GRANT SELECT, INSERT, UPDATE, DELETE ON pertanian.tanaman TO 'user1'@'localhost';
-- hak akses user2
GRANT SELECT ON pertanian.vertical_view TO 'user2'@'localhost';
-- hak akses role finance
GRANT EXECUTE ON PROCEDURE pertanian.ShowAllPetani TO 'finance';
-- hak akses user3 dengan akses role "finance"
GRANT 'finance' TO 'user3'@'localhost';
SET DEFAULT ROLE 'finance' TO 'user3'@'localhost';

