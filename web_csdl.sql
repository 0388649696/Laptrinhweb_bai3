-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Máy chủ: mariadb:3306
-- Thời gian đã tạo: Th10 06, 2025 lúc 04:53 PM
-- Phiên bản máy phục vụ: 10.11.14-MariaDB-ubu2204
-- Phiên bản PHP: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `web`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `CHITIETDONHANG`
--

CREATE TABLE `CHITIETDONHANG` (
  `id` int(11) NOT NULL,
  `ma_don_hang` int(11) DEFAULT NULL,
  `ma_san_pham` int(11) DEFAULT NULL,
  `so_luong` int(11) NOT NULL,
  `gia_tai_thoi_diem_dat` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `DONHANG`
--

CREATE TABLE `DONHANG` (
  `id` int(11) NOT NULL,
  `ma_khach_hang` int(11) DEFAULT NULL,
  `ten_nguoi_nhan` varchar(100) DEFAULT NULL,
  `dia_chi_giao` text DEFAULT NULL,
  `sdt` varchar(15) DEFAULT NULL,
  `ngay_dat_hang` datetime DEFAULT current_timestamp(),
  `trang_thai` enum('MOI','XAC_NHAN','DANG_GIAO','HOAN_THANH','HUY') DEFAULT 'MOI',
  `ma_cod` varchar(50) DEFAULT NULL,
  `tong_tien` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `DONHANG`
--

INSERT INTO `DONHANG` (`id`, `ma_khach_hang`, `ten_nguoi_nhan`, `dia_chi_giao`, `sdt`, `ngay_dat_hang`, `trang_thai`, `ma_cod`, `tong_tien`) VALUES
(1, 1, 'Nguyen Duc Anh Tu', 'Phu Xa, Thai nguyen', '0399037647', '2025-11-06 14:48:30', 'XAC_NHAN', 'DHKFV658', 95000.00),
(2, 3, 'Nguyễn Đức Kính', 'Đống Đa, Hà Nội', '039565996', '2025-11-06 14:55:33', 'DANG_GIAO', NULL, 607050.00),
(3, 3, 'Nguyễn Đức Ký', 'Hai Bà Trưng, Hà Nội', '09441694', '2025-11-06 14:56:46', 'XAC_NHAN', NULL, 55000.00),
(4, 2, 'Nguyễn Đức Tú', 'Yên Dũng, Bắc Ninh', '086342352', '2025-11-06 15:00:27', 'MOI', NULL, 475000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `NGUOIDUNG`
--

CREATE TABLE `NGUOIDUNG` (
  `id` int(11) NOT NULL,
  `tendangnhap` varchar(50) NOT NULL,
  `matkhau` varchar(255) NOT NULL,
  `ho_ten` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` enum('ADMIN','USER') DEFAULT 'USER'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `NGUOIDUNG`
--

INSERT INTO `NGUOIDUNG` (`id`, `tendangnhap`, `matkhau`, `ho_ten`, `email`, `role`) VALUES
(1, 'admin', '123456', 'Quản trị viên', NULL, 'ADMIN'),
(2, 'anhtu', '123456', 'Nguyen Tu', NULL, 'USER'),
(3, 'test1', '123456', 'Hoang Duc Kýnh', NULL, 'USER');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `NHOMSANPHAM`
--

CREATE TABLE `NHOMSANPHAM` (
  `id` int(11) NOT NULL,
  `ten_nhom` varchar(100) NOT NULL,
  `mo_ta` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `NHOMSANPHAM`
--

INSERT INTO `NHOMSANPHAM` (`id`, `ten_nhom`, `mo_ta`) VALUES
(1, 'Sách & Văn phòng phẩm', 'Các loại sách, truyện, và dụng cụ học tập.'),
(2, 'Thiết bị Điện tử', 'Điện thoại, máy tính bảng, phụ kiện, v.v.'),
(3, 'Đồ gia dụng', 'Thiết bị nhà bếp, đồ dùng sinh hoạt hàng ngày.'),
(4, 'Thời trang Nam', 'Áo, quần, phụ kiện thời trang nam.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `SANPHAM`
--

CREATE TABLE `SANPHAM` (
  `id` int(11) NOT NULL,
  `ma_nhom` int(11) DEFAULT NULL,
  `ten_sp` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `gia_ban` decimal(10,2) NOT NULL,
  `so_luong_ton` int(11) DEFAULT NULL,
  `sp_ban_chay` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `SANPHAM`
--

INSERT INTO `SANPHAM` (`id`, `ma_nhom`, `ten_sp`, `mo_ta`, `gia_ban`, `so_luong_ton`, `sp_ban_chay`) VALUES
(1, 1, 'Sách: Khai Sáng Tinh Thần', 'Sách kỹ năng sống, phát triển bản thân.', 133800.00, 150, 1),
(2, 1, 'Sách: Lập Trình Cơ Bản', 'Cẩm nang học lập trình Python.', 95000.00, 80, 0),
(3, 2, 'Cốc giữ nhiệt inox 304', 'Cốc giữ nhiệt cao cấp 304 Elmich.', 132050.00, 200, 1),
(4, 3, 'Bình đun siêu tốc Toshiba', 'Ấm đun nước siêu tốc dung tích 1.7L.', 475000.00, 50, 1),
(5, 3, 'Bình xịt tưới cây tự động', 'Bình xịt mini dùng pin tiện dụng.', 55000.00, 120, 0),
(6, 1, 'Áo Thun Basic Xanh', 'Chất liệu Cotton 100%, thoáng mát, phù hợp mặc hàng ngày.', 150000.00, 50, 1),
(7, 2, 'Quần Jeans Slim Fit Đen', 'Kiểu dáng ôm vừa, chất liệu co giãn tốt, màu đen không phai.', 450000.00, 30, 0),
(8, 1, 'Áo Khoác Hoodie Trắng', 'Áo hoodie dày dặn, ấm áp, có mũ, thích hợp cho mùa đông.', 320000.00, 25, 1),
(9, 3, 'Giày Sneaker Da Lộn', 'Thiết kế cổ điển, đế cao su chống trượt, phong cách thể thao.', 680000.00, 40, 0),
(10, 2, 'Váy Suông Đuôi Cá', 'Vải lụa mềm mại, kiểu dáng nữ tính, phù hợp đi tiệc.', 550000.00, 15, 1),
(11, 3, 'Ốp Lưng Điện Thoại Da Cá Sấu', 'Ốp lưng cao cấp, bảo vệ tối ưu, vân da cá sấu sang trọng.', 180000.00, 75, 0),
(12, 1, 'Áo Polo Thể Thao Đỏ', 'Vải poly co giãn 4 chiều, thấm hút mồ hôi, logo thêu nổi bật.', 210000.00, 60, 1),
(13, 2, 'Chân Váy Chữ A Kẻ Caro', 'Thiết kế trẻ trung, chất vải dày dặn, dễ phối đồ.', 280000.00, 22, 1),
(14, 3, 'Đồng Hồ Thông Minh X8', 'Màn hình AMOLED, đo nhịp tim, chống nước IP68.', 950000.00, 18, 0),
(15, 1, 'Quần Short Kaki Xám', 'Chất liệu Kaki cao cấp, phù hợp mặc đi biển hoặc dạo phố.', 195000.00, 45, 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `CHITIETDONHANG`
--
ALTER TABLE `CHITIETDONHANG`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ma_don_hang` (`ma_don_hang`),
  ADD KEY `ma_san_pham` (`ma_san_pham`);

--
-- Chỉ mục cho bảng `DONHANG`
--
ALTER TABLE `DONHANG`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ma_khach_hang` (`ma_khach_hang`);

--
-- Chỉ mục cho bảng `NGUOIDUNG`
--
ALTER TABLE `NGUOIDUNG`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tendangnhap` (`tendangnhap`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Chỉ mục cho bảng `NHOMSANPHAM`
--
ALTER TABLE `NHOMSANPHAM`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ten_nhom` (`ten_nhom`);

--
-- Chỉ mục cho bảng `SANPHAM`
--
ALTER TABLE `SANPHAM`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ma_nhom` (`ma_nhom`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `CHITIETDONHANG`
--
ALTER TABLE `CHITIETDONHANG`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `DONHANG`
--
ALTER TABLE `DONHANG`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `NGUOIDUNG`
--
ALTER TABLE `NGUOIDUNG`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `NHOMSANPHAM`
--
ALTER TABLE `NHOMSANPHAM`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `SANPHAM`
--
ALTER TABLE `SANPHAM`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Ràng buộc đối với các bảng kết xuất
--

--
-- Ràng buộc cho bảng `CHITIETDONHANG`
--
ALTER TABLE `CHITIETDONHANG`
  ADD CONSTRAINT `chitietdonhang_ibfk_1` FOREIGN KEY (`ma_don_hang`) REFERENCES `DONHANG` (`id`),
  ADD CONSTRAINT `chitietdonhang_ibfk_2` FOREIGN KEY (`ma_san_pham`) REFERENCES `SANPHAM` (`id`);

--
-- Ràng buộc cho bảng `DONHANG`
--
ALTER TABLE `DONHANG`
  ADD CONSTRAINT `donhang_ibfk_1` FOREIGN KEY (`ma_khach_hang`) REFERENCES `NGUOIDUNG` (`id`);

--
-- Ràng buộc cho bảng `SANPHAM`
--
ALTER TABLE `SANPHAM`
  ADD CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`ma_nhom`) REFERENCES `NHOMSANPHAM` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
