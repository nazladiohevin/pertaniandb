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
	('Sri Handayani', 'Sleman');


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