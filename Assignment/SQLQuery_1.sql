CREATE DATABASE NGUYENTRONGDAT_52100176
GO
USE NGUYENTRONGDAT_52100176
GO

CREATE TABLE tSanPham
(
  maSanPham VARCHAR(10) PRIMARY KEY NOT NULL,
  tenSanPham VARCHAR(30) NOT NULL,
  nhaSanXuat VARCHAR(30) NOT NULL,
  thoiGianBaoHanh VARCHAR(10) NOT NUlL,
  donGia INT NOT NULL
)

CREATE TABLE tKhachHang
(
    maKhachHang VARCHAR(10) NOT NULL,
    tenKhachHang VARCHAR(30) NOT NULL,
    diaChi VARCHAR(50) NOT NULL,
    soDienThoai VARCHAR(10) UNIQUE NOT NULL,
    PRIMARY KEY(maKhachHang)
)

CREATE TABLE tNguoiThan
(
  maKhachHang VARCHAR(10) PRIMARY KEY NOT NULL,
  hoTen VARCHAR(30) UNIQUE NOT NULL,
  soDienThoai VARCHAR(10) NOT NULL,
  moiQuanHe VARCHAR(10) NOT NULL,
  CONSTRAINT FK_maKhachHang FOREIGN KEY(maKhachHang) REFERENCES tKhachHang(maKhachHang)

)

CREATE TABLE tPhieuXuat
(
    soPhieuXuat INT PRIMARY KEY NOT NULL,
    maKhachHang VARCHAR(10) NOT NULL,
    ngayLapPhieu date NOT NULL,
    CONSTRAINT FK_maKhachHang_1 FOREIGN KEY(maKhachHang) REFERENCES tKhachHang(maKhachHang)
)

CREATE TABLE tChiTietPhieuXuat
(
    soPhieuXuat INT NOT NULL,
    maSanPham VARCHAR(10) NOT NULL,
    soLuong INT CHECK(soLuong > 0) NOT NULL,
    PRIMARY KEY(soPhieuXuat, maSanPham),
    CONSTRAINT FK_soPhieuXuat FOREIGN KEY(soPhieuXuat) REFERENCES tPhieuXuat(soPhieuXuat), 
    CONSTRAINT FK_maSanPham FOREIGN KEY(maSanPham) REFERENCES tSanPham(maSanPham)
)

CREATE TABLE tHangSanXuat
(
    maHangSanXuat VARCHAR(10) PRIMARY KEY NOT NULL,
    tenHangSanXuat VARCHAR(10) UNIQUE NOT NULL,
    diaChiVanPhongChinhTaiVietNam VARCHAR(30) NOT NULL,
    soDienThoai VARCHAR(10) NOT NULL,
)

CREATE TABLE tNoiBaoHanh
(
    maHangSanXuat VARCHAR(10) NOT NULL,
    soPhieuXuat INT NOT NULL,
    tenDiemBaoHanh VARCHAR(30) NOT NULL,
    diaChi VARCHAR(30) NOT NULL,
    soDienThoai VARCHAR(10) NOT NULL,
    PRIMARY KEY(maHangSanXuat, soPhieuXuat),
    CONSTRAINT FK_maHangSanXuat FOREIGN KEY (maHangSanXuat) REFERENCES tHangSanXuat(maHangSanXuat),
    CONSTRAINT FK_soPhieuXuat_2 FOREIGN KEY (soPhieuXuat) REFERENCES tPhieuXuat(soPhieuXuat)
)

CREATE TABLE tBinhGas
(
  maSanPham VARCHAR(10) PRIMARY KEY NOT NULL,
  kichThuoc VARCHAR(10) NOT NULL,
  mauSac VARCHAR(10) NOT NULL,
  khoiLuong VARCHAR(10) NOT NULL,
  CONSTRAINT FK_maSanPham_2 FOREIGN KEY (maSanPham) REFERENCES tSanPham(maSanPham)
)

CREATE TABLE tNhaPhanPhoi
(
  maNhaPhanPhoi VARCHAR(10) PRIMARY KEY NOT NULL,
  tenNhaPhanPhoi VARCHAR(30) UNIQUE NOT NULL,
  soDienThoai VARCHAR(10) NOT NULL,
  diaChi VARCHAR(30) NOT NULL
)

CREATE TABLE tBep
(
  maSanPham VARCHAR(10) PRIMARY KEY NOT NULL,
  maNhaPhanPhoi VARCHAR(10) NOT NULL,
  mauSac VARCHAR(10) NOT NULL,
  loaiBep VARCHAR(30) NOT NULL,
  kichTHuoc VARCHAR(10) NOT NULL,
  CONSTRAINT FK_maSanPham_3 FOREIGN KEY (maSanPham) REFERENCES tSanPham(maSanPham),
  CONSTRAINT FK_maNhaPhanPhoi FOREIGN KEY (maNhaPhanPhoi) REFERENCES tNhaPhanPhoi(maNhaPhanPhoi)
)

GO
CREATE FUNCTION AUTO_IDSP()
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(maSanPham) FROM tSanPham) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(maSanPham, 3)) FROM tSanPham
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'SP0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'SP0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO

CREATE FUNCTION AUTO_IDKH()
RETURNS VARCHAR(10)
AS
  BEGIN
    DECLARE @ID VARCHAR(5)
    IF (SELECT COUNT(maKhachHang) FROM tKhachHang) = 0
      SET @ID = '0'
    ELSE
      SELECT @ID = MAX(RIGHT(maKhachHang, 3)) FROM tKhachHang
      SELECT @ID = CASE
        WHEN @ID >=0 and @ID < 9 THEN 'KH0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
        WHEN @ID >= 9 THEN 'KH0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
    END
  RETURN @ID
END

GO
CREATE PROC dataSanPham(
    @tenSanPham VARCHAR(30), 
    @nhaSanXuat VARCHAR(30), 
    @thoiGianBaoHanh VARCHAR(10), 
    @donGia INT)
AS
  DECLARE @temp VARCHAR(10)
  EXECUTE @temp = AUTO_IDSP
  INSERT INTO tSanPham
  VALUES (@temp, @tenSanPham, @nhaSanXuat, @thoiGianBaoHanh, @donGia)
GO

GO
CREATE PROC dataKhachHang(
    @tenKhachHang VARCHAR(30),
    @diaChi VARCHAR(50),
    @soDienThoai VARCHAR(10))
AS
  DECLARE @temp VARCHAR(10)
  EXECUTE @temp = AUTO_IDKH
  INSERT INTO tKhachHang
  VALUES(@temp, @tenKhachHang, @diaChi, @soDienThoai)

GO
CREATE TRIGGER trPhieuXuat ON dbo.tPhieuXuat
INSTEAD OF INSERT
AS
  BEGIN
    DECLARE @temp VARCHAR(10)
    SELECT @temp = maKhachHang FROM inserted
    IF not exists (SELECT * FROM tKhachHang WHERE @temp = maKhachHang)
    BEGIN
      RAISERROR('Khong ton tai ma khach hang', 16, 1)
    END
  END
GO

GO 
CREATE or ALTER TRIGGER checkDonGia ON dbo.tSanPham
FOR INSERT
AS
BEGIN
    DECLARE @count INT
    SET @count = 0
    SELECT @count = COUNT(*) FROM INSERTED
    WHERE donGia < 0

    IF (@count > 0)
    BEGIN
        print(N'Don gia phai > 0')
        ROLLBACK TRAN
    END
END
GO


EXEC dataSanPham 'fkdsaf', 'fkasfkas', 'fksdf', -100
EXEC dataSanPham N'Bếp', 'Toshiba', N'2 năm', 1000000
EXEC dataSanPham N'Bình gas', 'Petrolimex', N'1 năm', 50000
EXEC dataSanPham N'Lò vi sống',	'Electrolux', N'2 năm', 3000000
EXEC dataSanPham N'Lò nướng', 'Sunhouse', N'5 tháng', 3500000
EXEC dataSanPham N'Bếp', 'Kangaroo', N'5 năm', 3000000
EXEC dataSanPham N'Nồi cơm điện', 'Lock&lock', N'2 năm', 2500000
EXEC dataSanPham N'Bếp', 'Sunhouse', N'1 năm', 500000
EXEC dataSanPham N'Bình gas', 'Saigon Petro', N'1 năm', 70000
EXEC dataSanPham N'Bếp', 'Teka', N'1 năm', 4000000
EXEC dataSanPham N'Bình gas', 'Pacific Petro', N'5 tháng', 90000

EXEC dataKhachHang N'Nguyễn Văn A', 'Q7, TP HCM', '0916373503'
EXEC dataKhachHang N'Trần Thị Nga', N'Yên Lãng, TP Hà Nội', '0889524251'
EXEC dataKhachHang N'Lê Thị Bé', N'Hải Châu, TP Đà Nẵng', '0325754773'
EXEC dataKhachHang N'Nguyễn Văn Nụ', N'Ninh Kiều, TP Cần Thơ', '0925634821'
EXEC dataKhachHang N'Võ Văn Xuân', N'TP Bến Tre, Bến Tre', '0128486846'

INSERT INTO tNguoiThan
VALUES 
('KH02', N'Võ Thị Thu', '0914853843', N'Mẹ'),
('KH05',	N'Lê Văn Sỹ', '0847137331',	'Cha'),
('KH04', N'Nguyễn Thị B', '0813746333', N'Em gái'),
('KH01', N'Trịnh Văn An', '0137466475', N'Em Trai'),
('KH03', N'Trần Ánh Nguyệt', '0754748347', N'Vợ')


INSERT INTO tPhieuXuat
VALUES
(1, 'KH03', '2022-11-11'),
(2, 'KH04', '2022-10-02'),
(3, 'KH05', '2022-10-12'),
(4, 'KH02', '2022-10-14'),
(5, 'KH01', '2022-10-20')

INSERT INTO tChiTietPhieuXuat
VALUES
(1, 'SP04', 4),
(2, 'SP02', 10),
(3, 'SP05', 2),
(4, 'SP03', 1),
(5, 'SP01', 6)

INSERT INTO tHangSanXuat
VALUES
('HSX01', 'Toshiba', 'Q10, TP HCM', '18001529'),
('HSX02', 'Petrolimex', N'Thanh Khê, TP Đà Nẵng', '19002828'),
('HSX03', 'Electrolux', N'Ngô Quyền, TP Hải Phòng', '1800588899'),
('HSX04', 'Sunhouse', N'Mỹ Đình, TP Hà Nội', '18006680'),
('HSX05', 'Lock&lock', 'Q11, TP HCM', '0377416362')

INSERT INTO tNoiBaoHanh
VALUES
('HSX04', 1, N'Cửa hàng An Phát', 'Q7, TP HCM', '0935337247'),
('HSX01', 2, 'Fast Store', 'Q1, TP HCM', '0824851242'),
('HSX05', 3, N'Hoàng Phúc Store', N'Cầu Giấy, TP Hà Nội', '0124758454'),
('HSX02', 4, 'Electronic Store', N'Sơn Trà, TP Đà Nẵng', '0889437273'),
('HSX03', 5, N'Của hàng điện tử Vĩnh Khương', 'Q4, TP HCM', '0889834127')

INSERT INTO tBinhGas
VALUES
('SP010', N'Nhỏ', N'Đen', '6kg'),
('SP02', N'Vừa', N'Đỏ', '12kg'),
('SP08', N'Lớn', N'Trắng', '45kg')

INSERT INTO tNhaPhanPhoi
VALUES
('NPP01', 'AVE GROUP', '0245733283', 'Q1, TP HCM'),
('NPP02', N'CDI Việt Nam', '0914274274', N'Hoàng Mai, TP Hà Nội'),
('NPP03', 'VINAMECO', '0866381357', N'Sơn Trà, TP Đà Nẵng'),
('NPP04', N'CÔNG TY TNHH HXC', '0736837817', N'Ninh Kiều, TP Cần Thơ'),
('NPP05', N'CÔNG TY TNHH AKARA', '0248683476', 'Q5, TP HCM')

INSERT INTO tBep
VALUES
('SP01', 'NPP03', N'Đen', N'Bếp điện', N'Nhỏ'),
('SP05', 'NPP05', N'Trắng',	N'Bếp từ', N'Lớn'),
('SP07', 'NPP02', N'Đỏ', N'Bếp gas', N'Vừa'),
('SP09', 'NPP01', N'Đen', N'Bếp hồng ngoại', N'Nhỏ')

SELECT * FROM tSanPham
SELECT * FROM tKhachHang
SELECT * FROM tNguoiThan
SELECT * FROM tPhieuXuat
SELECT * FROM tChiTietPhieuXuat
SELECT * FROM tHangSanXuat
SELECT * FROM tNoiBaoHanh
SELECT * FROM tBinhGas
SELECT * FROM tNhaPhanPhoi
SELECT * FROM tBep

DROP TABLE tSanPham
DROP TABLE tNguoiThan
DROP TABLE tKhachHang
DROP TABLE tPhieuXuat
DROP TABLE tChiTietPhieuXuat
DROP TABLE tHangSanXuat
DROP TABLE tNoiBaoHanh
DROP TABLE tBinhGas
DROP TABLE tNhaPhanPhoi
DROP TABLE tBep

DROP PROC dataSanPham
DROP PROC dataKhachHang

DROP FUNCTION AUTO_IDSP
DROP FUNCTION AUTO_IDKH

DROP TRIGGER trPhieuXuat
DROP TRIGGER checkDonGia












