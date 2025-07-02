-- Active: 1748054981637@@127.0.0.1@3306@wb_bouquet
USE wb_bouquet;


CREATE TABLE detail_pesanan (
    id_detail int(11) NOT NULL,
    id_pesanan int(11) DEFAULT NULL,
    id_produk int(11) DEFAULT NULL,
    jumlah int(11) DEFAULT NULL,
    nuansa_warna varchar(255) DEFAULT NULL,
    ukuran enum('Small', 'Large', 'Big') DEFAULT NULL,
    referensi_gambar varchar(255) DEFAULT NULL,
    kategori_harga enum(
        'Rp 15.000 - 50.000',
        'Rp 85.000',
        'Rp 100.000',
        'Rp 135.000',
        'Rp 150.000',
        'Rp 200.000',
        'Rp 250.000',
        'Rp 350.000',
        'Rp 500.000',
        'Rp 150.000 - 185.000'
    ) DEFAULT NULL,
    jenis_buket enum(
        'Buket Wisuda',
        'Buket Ulang Tahun',
        'Buket Anniversary',
        'Balon Karakter',
        'Balon Angka/Huruf',
        'Balon Custom',
        'Hampers Lebaran',
        'Hampers Natal',
        'Hampers Makanan Ringan',
        '10 Lembar',
        '20 Lembar',
        '50 lembar'
    ) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

CREATE TABLE kategori_produk (
    id_kategori int(11) NOT NULL,
    nama_kategori enum(
        'Buket Bunga',
        'Buket Balon',
        'Hampers'
    ) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

CREATE TABLE pelanggan (
    id_pelanggan int(11) NOT NULL,
    nama_pelanggan varchar(255) DEFAULT NULL,
    nomor_wa varchar(13) DEFAULT NULL,
    alamat_lengkap text DEFAULT NULL,
    tanggal_ultah DATE NULL DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

CREATE TABLE pesanan (
    id_pesanan int(11) NOT NULL,
    id_pelanggan int(11) DEFAULT NULL,
    tanggal_order timestamp NOT NULL DEFAULT current_timestamp(),
    tanggal_jadi date DEFAULT NULL,
    opsi_pengambilan enum('Diambil Sendiri', 'Diantar') DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

CREATE TABLE produk (
    id_produk int(11) NOT NULL,
    id_kategori int(11) DEFAULT NULL,
    gambar varchar(255) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

ALTER TABLE detail_pesanan
ADD PRIMARY KEY (id_detail),
ADD KEY `id_pesanan` (id_pesanan),
ADD KEY `id_produk` (id_produk);

ALTER TABLE kategori_produk ADD PRIMARY KEY (id_kategori);

ALTER TABLE pelanggan ADD PRIMARY KEY (id_pelanggan);

ALTER TABLE pesanan
ADD PRIMARY KEY (id_pesanan),
ADD KEY id_pelanggan (id_pelanggan);

ALTER TABLE produk
ADD PRIMARY KEY (id_produk),
ADD KEY id_kategori (id_kategori);

ALTER TABLE detail_pesanan
MODIFY id_detail int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE kategori_produk
MODIFY id_kategori int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE pelanggan
MODIFY id_pelanggan int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE pesanan
MODIFY id_pesanan int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE produk MODIFY id_produk int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE detail_pesanan
ADD CONSTRAINT detail_pesanan_ibfk_1 FOREIGN KEY (id_pesanan) REFERENCES pesanan (id_pesanan),
ADD CONSTRAINT detail_pesanan_ibfk_2 FOREIGN KEY (id_produk) REFERENCES produk (id_produk);

ALTER TABLE pesanan
ADD CONSTRAINT pesanan_ibfk_1 FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan);

ALTER TABLE produk
ADD CONSTRAINT produk_ibfk_1 FOREIGN KEY (id_kategori) REFERENCES kategori_produk (id_kategori);

ALTER TABLE produk
ADD unggulan TINYINT(1) NOT NULL DEFAULT 0 AFTER gambar;

ALTER TABLE pesanan
ADD struk_path VARCHAR(255) NULL AFTER opsi_pengambilan;

ALTER TABLE pesanan
ADD status VARCHAR(20) NOT NULL DEFAULT 'Diproses';

insert into
    kategori_produk (id_kategori, nama_kategori)
values (1, 'Buket Bunga'),
    (2, 'Buket Uang'),
    (3, 'Buket Balon'),
    (4, 'Hampers');

SELECT * FROM pelanggan;

ALTER TABLE pelanggan
ADD COLUMN tanggal_ultah DATE NULL DEFAULT NULL AFTER alamat_lengkap;

SELECT
    id_pelanggan,
    nama_pelanggan,
    nomor_wa,
    alamat_lengkap,
    tanggal_ultah
FROM pelanggan
ORDER BY nama_pelanggan ASC;

insert into
    kategori_produk (id_kategori, nama_kategori)
values (6, 'Buket Uang');

alter Table kategori_produk
MODIFY nama_kategori ENUM (  'Buket Bunga','Buket Uang',
        'Buket Balon',
        'Hampers')


INSERT INTO `produk` (`id_produk`, `id_kategori`, `gambar`, `unggulan`) VALUES
(6, 1, 'images/685a0c7ccbe28-68599fa8c8aa0-flower_item_1.jpg', 1),
(7, 3, 'images/685a0c6ed8518-flower_item_2.jpg', 1),
(9, 3, 'images/685c100700242-Screenshot_25-6-2025_214955_www.instagram.com.jpeg', 0),
(11, 3, 'images/685c119adcdaa-Screenshot_25-6-2025_211640_www.instagram.com.jpeg', 0),
(14, 3, 'images/685c1359f2971-Screenshot_25-6-2025_21139_www.instagram.com.jpeg', 0),
(15, 1, 'images/685c146f5b3df-Screenshot_25-6-2025_21822_www.instagram.com.jpeg', 0),
(22, 1, 'images/685c18f1721fe-Screenshot_25-6-2025_22428_www.instagram.com.jpeg', 0),
(26, 3, 'images/685c1c2302995-Screenshot_25-6-2025_225030_www.instagram.com.jpeg', 0),
(28, 1, 'images/685c1dcad2e47-Screenshot_25-6-2025_23238_www.instagram.com.jpeg', 0),
(29, 3, 'images/685c2064303ad-Screenshot_25-6-2025_231358_www.instagram.com.jpeg', 0),
(31, 2, 'images/685c20ca81fbf-Screenshot_25-6-2025_231545_www.instagram.com.jpeg', 0),
(32, 2, 'images/685c2154044d2-Screenshot_25-6-2025_23180_www.instagram.com.jpeg', 0),
(33, 3, 'images/685c21bdd6e24-Screenshot_25-6-2025_231950_www.instagram.com.jpeg', 0),
(34, 3, 'images/685c2226954c8-Screenshot_25-6-2025_232131_www.instagram.com.jpeg', 0),
(35, 3, 'images/685c22812ebb0-Screenshot_25-6-2025_23233_www.instagram.com.jpeg', 0),
(36, 1, 'images/685c22f311917-Screenshot_25-6-2025_232456_www.instagram.com.jpeg', 0),
(37, 3, 'images/685c23860dcff-Screenshot_25-6-2025_232728_www.instagram.com.jpeg', 0),
(39, 1, 'images/685c25ea46852-Screenshot_25-6-2025_232857_www.instagram.com.jpeg', 0),
(40, 1, 'images/685c27476c7be-Screenshot_25-6-2025_23432_www.instagram.com.jpeg', 0),
(41, 3, 'images/685c27a7e1a85-Screenshot_25-6-2025_234453_www.instagram.com.jpeg', 0),
(42, 1, 'images/685c281c190c9-Screenshot_25-6-2025_234648_www.instagram.com.jpeg', 0),
(43, 1, 'images/685c2866433cf-Screenshot_25-6-2025_23487_www.instagram.com.jpeg', 0),
(44, 3, 'images/685c28a5bc679-Screenshot_25-6-2025_234921_www.instagram.com.jpeg', 0),
(45, 3, 'images/685c292471ba3-Screenshot_25-6-2025_235121_www.instagram.com.jpeg', 0),
(46, 2, 'images/685c297d916ce-Screenshot_25-6-2025_235246_www.instagram.com.jpeg', 0),
(47, 3, 'images/685c29bb44106-Screenshot_25-6-2025_235355_www.instagram.com.jpeg', 0),
(49, 1, 'images/685c2a950da1e-Screenshot_25-6-2025_235737_www.instagram.com.jpeg', 0),
(50, 1, 'images/685c2b0c60e48-Screenshot_25-6-2025_235934_www.instagram.com.jpeg', 0),
(51, 1, 'images/685c2b9bb4a3f-Screenshot_26-6-2025_0146_www.instagram.com.jpeg', 0),
(52, 2, 'images/685c2c68dd431-Screenshot_26-6-2025_0450_www.instagram.com.jpeg', 0),
(53, 1, 'images/685c2cc0cc30a-Screenshot_26-6-2025_0645_www.instagram.com.jpeg', 0),
(54, 3, 'images/685c2d1298131-Screenshot_26-6-2025_0811_www.instagram.com.jpeg', 0),
(55, 1, 'images/685c2dcd954b9-Screenshot_26-6-2025_0951_www.instagram.com.jpeg', 0),
(56, 2, 'images/685c2e52c3a20-Screenshot_26-6-2025_01251_www.instagram.com.jpeg', 0),
(57, 1, 'images/685c2ebf656e3-Screenshot_26-6-2025_01511_www.instagram.com.jpeg', 1),
(58, 1, 'images/685c2f351c6cf-Screenshot_26-6-2025_01717_www.instagram.com.jpeg', 0),
(59, 1, 'images/685c2faaa68fb-Screenshot_26-6-2025_01913_www.instagram.com.jpeg', 1),
(60, 2, 'images/685c300615984-Screenshot_26-6-2025_02053_www.instagram.com.jpeg', 0),
(61, 3, 'images/685c305bd5855-Screenshot_26-6-2025_0228_www.instagram.com.jpeg', 0),
(62, 2, 'images/685c30b2a5a24-Screenshot_26-6-2025_02342_www.instagram.com.jpeg', 0);