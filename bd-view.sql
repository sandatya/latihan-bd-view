-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 23 Agu 2023 pada 03.42
-- Versi Server: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `bd-view`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `ambil_mk`
--

CREATE TABLE IF NOT EXISTS `ambil_mk` (
  `nim` varchar(3) NOT NULL,
  `kode_mk` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `ambil_mk`
--

INSERT INTO `ambil_mk` (`nim`, `kode_mk`) VALUES
('', ''),
('', 'PTI123'),
('101', 'PTI447'),
('103', 'TIK333'),
('104', 'PTI333'),
('104', 'PTI777');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen`
--

CREATE TABLE IF NOT EXISTS `dosen` (
  `kode_dos` varchar(2) NOT NULL,
  `nama_dos` varchar(50) NOT NULL,
  `alamat_dos` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `dosen`
--

INSERT INTO `dosen` (`kode_dos`, `nama_dos`, `alamat_dos`) VALUES
('10', 'Suharto', 'Jl. Jombang'),
('11', 'Martono', 'Jl. Kalpataru'),
('12', 'Rahmawati', 'Jl. Jakarta'),
('13', 'Bambang', 'Jl. Bandung'),
('14', 'Nurul', 'Jl. Raya Tidar');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurusan`
--

CREATE TABLE IF NOT EXISTS `jurusan` (
  `kode_jur` varchar(2) NOT NULL,
  `nama_jur` varchar(50) NOT NULL,
  `kode_dos` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `jurusan`
--

INSERT INTO `jurusan` (`kode_jur`, `nama_jur`, `kode_dos`) VALUES
('TE', 'Teknik Elektro', '10'),
('TM', 'Teknik Mesin', '13'),
('TS', 'Teknik Sipil ', '23');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE IF NOT EXISTS `mahasiswa` (
  `nim` varchar(3) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `jk` varchar(1) NOT NULL,
  `alamat` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `mahasiswa`
--

INSERT INTO `mahasiswa` (`nim`, `nama`, `jk`, `alamat`) VALUES
('101', 'Arif', 'L', 'Jl. Kenangan'),
('102', 'Budi', 'L', 'Jl. Jombang'),
('103', 'Wati', 'P', 'Jl. Surabaya'),
('104', 'Ika', 'P', 'Jl. Jombang'),
('105', 'Tono', 'L', 'Jl. Jakarta'),
('106', 'Iwan', 'L', 'Jl. Bandung'),
('107', 'Sari', 'P', 'Jl. Malang');

-- --------------------------------------------------------

--
-- Struktur dari tabel `matakuliah`
--

CREATE TABLE IF NOT EXISTS `matakuliah` (
  `kode_mk` varchar(6) NOT NULL,
  `nama_mk` varchar(50) NOT NULL,
  `sks` int(1) NOT NULL,
  `semester` int(1) NOT NULL,
  `kode_dos` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `matakuliah`
--

INSERT INTO `matakuliah` (`kode_mk`, `nama_mk`, `sks`, `semester`, `kode_dos`) VALUES
('PTI123', 'Grafika Komputer', 3, 5, '12'),
('PTI333', 'Basis Data Terdistribusi', 3, 5, '10'),
('PTI447', 'Praktikum Basis Data', 1, 3, '11'),
('PTI777', 'Sistem Informasi', 2, 3, '99'),
('TIK123', 'Jaringan Komputer', 2, 5, '33'),
('TIK333', 'Sistem Operasi', 3, 5, '10'),
('TIK342', 'Praktikum Basis Data', 1, 3, '11');

-- --------------------------------------------------------

--
-- Stand-in structure for view `nestedviewdosen`
--
CREATE TABLE IF NOT EXISTS `nestedviewdosen` (
`nama_dos` varchar(50)
,`jumlah_mhs` bigint(21)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `vdosen`
--
CREATE TABLE IF NOT EXISTS `vdosen` (
`nama_dos` varchar(50)
,`jumlah_mhs` bigint(21)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `vgetdatamhssks`
--
CREATE TABLE IF NOT EXISTS `vgetdatamhssks` (
`nim` varchar(3)
,`nama` varchar(50)
,`jk` varchar(1)
,`alamat` varchar(50)
,`kode_mk` varchar(6)
,`nama_mk` varchar(50)
,`sks` int(1)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `vgetmhs`
--
CREATE TABLE IF NOT EXISTS `vgetmhs` (
`nim` varchar(3)
,`nama` varchar(50)
,`jk` varchar(1)
,`alamat` varchar(50)
);
-- --------------------------------------------------------

--
-- Struktur untuk view `nestedviewdosen`
--
DROP TABLE IF EXISTS `nestedviewdosen`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nestedviewdosen` AS select `a`.`nama_dos` AS `nama_dos`,`a`.`jumlah_mhs` AS `jumlah_mhs` from `vdosen` `a` where (`a`.`jumlah_mhs` = (select max(`vdosen`.`jumlah_mhs`) from `vdosen`));

-- --------------------------------------------------------

--
-- Struktur untuk view `vdosen`
--
DROP TABLE IF EXISTS `vdosen`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vdosen` AS select `dosen`.`nama_dos` AS `nama_dos`,count(distinct `mahasiswa`.`nama`) AS `jumlah_mhs` from (((`dosen` join `matakuliah` on((`matakuliah`.`kode_dos` = `dosen`.`kode_dos`))) join `ambil_mk` on((`ambil_mk`.`kode_mk` = `matakuliah`.`kode_mk`))) join `mahasiswa` on((`mahasiswa`.`nim` = `ambil_mk`.`nim`))) group by `dosen`.`nama_dos`;

-- --------------------------------------------------------

--
-- Struktur untuk view `vgetdatamhssks`
--
DROP TABLE IF EXISTS `vgetdatamhssks`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vgetdatamhssks` AS select `mahasiswa`.`nim` AS `nim`,`mahasiswa`.`nama` AS `nama`,`mahasiswa`.`jk` AS `jk`,`mahasiswa`.`alamat` AS `alamat`,`matakuliah`.`kode_mk` AS `kode_mk`,`matakuliah`.`nama_mk` AS `nama_mk`,`matakuliah`.`sks` AS `sks` from ((`mahasiswa` join `ambil_mk` on((`ambil_mk`.`nim` = `mahasiswa`.`nim`))) join `matakuliah` on((`ambil_mk`.`kode_mk` = `matakuliah`.`kode_mk`))) where (`matakuliah`.`sks` > 2);

-- --------------------------------------------------------

--
-- Struktur untuk view `vgetmhs`
--
DROP TABLE IF EXISTS `vgetmhs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vgetmhs` AS select `mahasiswa`.`nim` AS `nim`,`mahasiswa`.`nama` AS `nama`,`mahasiswa`.`jk` AS `jk`,`mahasiswa`.`alamat` AS `alamat` from `mahasiswa`;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ambil_mk`
--
ALTER TABLE `ambil_mk`
 ADD KEY `nim` (`nim`,`kode_mk`), ADD KEY `kode_mk` (`kode_mk`), ADD KEY `kode_mk_2` (`kode_mk`), ADD KEY `kode_mk_3` (`kode_mk`);

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
 ADD PRIMARY KEY (`kode_dos`);

--
-- Indexes for table `jurusan`
--
ALTER TABLE `jurusan`
 ADD PRIMARY KEY (`kode_jur`), ADD KEY `kode_dos` (`kode_dos`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
 ADD PRIMARY KEY (`nim`);

--
-- Indexes for table `matakuliah`
--
ALTER TABLE `matakuliah`
 ADD PRIMARY KEY (`kode_mk`), ADD KEY `kode_dos` (`kode_dos`), ADD KEY `kode_mk` (`kode_mk`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
