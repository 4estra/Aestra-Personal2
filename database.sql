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
        'Rp 100.000',
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
        'Hampers Makanan Ringan'
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
    (2, 'Buket Balon'),
    (3, 'Hampers');

SELECT * FROM pelanggan;

ALTER TABLE pelanggan
ADD COLUMN tanggal_ultah DATE NULL DEFAULT NULL AFTER alamat_lengkap;