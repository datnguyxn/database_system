CREATE DATABASE NGUYENTRONGDAT_52100176
GO
USE NGUYENTRONGDAT_52100176
GO
CREATE TABLE nhacungcap
(
    macongty NVARCHAR(10) NOT NULL
    CONSTRAINT pk_nhacungcap
    PRIMARY KEY(macongty),
    tencongty NVARCHAR(40) NOT NULL,
    tengiaodich NVARCHAR(30) NULL,
    diachi NVARCHAR(60) NULL,
    dienthoai NVARCHAR(20) NULL,
    fax NVARCHAR(20) NULL,
    email NVARCHAR(50) NULL
)
CREATE TABLE loaihang
(
    maloaihang INT NOT NULL
    CONSTRAINT pk_loaihang
    PRIMARY KEY(maloaihang),
    tenloaihang NVARCHAR(15) NOT NULL
)
CREATE TABLE mathang
(
    mahang NVARCHAR(10) NOT NULL
    CONSTRAINT pk_mathang
    PRIMARY KEY(mahang),
    tenhang NVARCHAR(50) NOT NULL,
    macongty NVARCHAR(10) NULL ,
    maloaihang INT NULL ,
    soluong INT NULL,
    donvitinh NVARCHAR(20) NULL ,
    giahang MONEY NULL
)
CREATE TABLE nhanvien
(
    manhanvien NVARCHAR(10) NOT NULL
    CONSTRAINT pk_nhanvien
    PRIMARY KEY(manhanvien),
    ho NVARCHAR(20) NOT NULL ,
    ten NVARCHAR(10) NOT NULL ,
    ngaysinh DATETIME NULL ,
    ngaylamviec DATETIME NULL ,
    diachi NVARCHAR(50) NULL ,
    dienthoai NVARCHAR(15) NULL ,
    luongcoban MONEY NULL ,
    phucap MONEY NULL
)
CREATE TABLE khachhang
(
    makhachhang NVARCHAR(10) NOT NULL
    CONSTRAINT pk_khachhang
    PRIMARY KEY(makhachhang),
    tencongty NVARCHAR(50) NOT NULL ,
    tengiaodich NVARCHAR(30) NOT NULL ,
    diachi NVARCHAR(50) NULL ,
    email NVARCHAR(30) NULL ,
    dienthoai NVARCHAR(15) NULL ,
    fax NVARCHAR(15) NULL
)
CREATE TABLE dondathang
(
    msohoadon INT NOT NULL
    CONSTRAINT pk_dondathang
    PRIMARY KEY(sohoadon),
    makhachhang NVARCHAR(10) NULL ,
    manhanvien NVARCHAR(10) NULL ,
    ngaydathang SMALLDATETIME NULL ,
    ngaygiaohang SMALLDATETIME NULL ,
    ngaychuyenhang SMALLDATETIME NULL ,
    noigiaohang NVARCHAR(50) NULL
)
CREATE TABLE chitietdathang
(
    sohoadon INT NOT NULL ,
    mahang NVARCHAR(10) NOT NULL ,
    giaban MONEY NOT NULL ,
    soluong SMALLINT NOT NULL ,
    mucgiamgia REAL NOT NULL,
    CONSTRAINT pk_chitietdathang
    PRIMARY KEY(sohoadon,mahang)
)

INSERT INTO nhacungcap
VALUES
    ('A01', 'Vincom', 'hanghoa', 'TP HCM', '0915337513', '0934782332', 'vincom@gmailcom'),
    ('A02',	'Apple', 'laptop',	'USA', '8421958341', '3423432432', 'apple@gmailcom'),
    ('A03',	'Samsung', 'galaxy', 'Korea', '3738478933',	'9757156104', 'samsung@gmailcom'),
    ('A04', 'Microsoft', 'phanmem', 'USA', '0238343822', '0358157144', 'microsoft@gmailcom'),
    ('A05',	'Tesla', 'xedien', 'USA', '3283375233', '7592576925', 'tesla@gmailcom')

INSERT INTO loaihang
VALUES
    (12, N'Nước hoa'),
    (21, 'Laptop'),
    (23, N'Điện thoại'),
    (13, N'Phần mềm'),
    (34, N'Xe điện')

INSERT INTO mathang
VALUES
    ('D01',	'Macbook', 'A02', 21, 10, 'vnd', 35000000),
    ('D02',	'Galaxy Z Fold 4', 'A03', 23, 30, 'vnd', 25000000),
    ('D03',	'Microsoft 365', 'A04',	13,	100, 'vnd', 1000000),
    ('D04',	N'Nước hoa', 'A01', 12,	50,	'vnd', 1000000),
    ('D05',	'Tesla Modal X', 'A05',	34,	5, 'vnd', 7000000000)

INSERT INTO nhanvien
VALUES
    ('D48',	N'Nguyễn', N'Đạt', '1995/04/23', '2022/10/10', 'TP HCM', '0238283333', 2000000,	2500000),
    ('D72',	N'Trần', N'Linh', '2001/02/04',	'2022/10/11', 'TP HCM',	'0573281545', 4000000, 1500000),
    ('D16',	N'Hồ', 'Lan', '2003/07/31',	'2022/10/13', 'TP HCM',	'0147147453', 3500000, 3000000),
    ('D05',	N'Trịnh', N'Thông', '2001/06/12', '2022/10/09', 'TP HCM', '0792520522', 5000000, 2500000),
    ('D92',	N'Trần', 'Anh', '1997/01/10', '2022/10/05',	'TP HCM', '0685685694', 1500000, 2000000)

INSERT INTO khachhang
VALUES
    ('F01',	'Apple', 'laptop', 'TP HCM', 'nhu@gmail.com', '0134710651',	'0584347522'),
    ('F02',	'Samsung', 'galaxy', N'TP Hà Nội', 'lam@gmail.com',	'0935322333', '0683453453'),
    ('F03',	'Vincom', 'hanghoa', N'TP Đà Nẵng',	'bui@gmail.com', '0235236266', '0826464644'),
    ('F04',	'Microsoft', 'phanmem', N'TP Cần Thơ', 'trang@gmail.com', '0353473456', '0869734435'),
    ('F05',	'Tesla', 'xedien', 'TP HCM', 'dat@gmail.com', '0523532666', '0262845775')

INSERT INTO dondathang
VALUES
    (1,	'F02', 'D16', '2022/10/01',	'2022/10/11', '2022/10/15',	N'TP Hà Nội'),
    (2,	'F05', 'D48', '2021/10/12',	'2022/08/11', '2022/10/11',	'TP HCM'),
    (3,	'F03', 'D72', '2022/10/02',	'2022/10/05', '2022/10/07',	N'TP Đà Nẵng'),
    (4,	'F01', 'D05', '2022/10/18',	'2022/10/17', '2022/10/30',	'TP HCM'),
    (5,	'F04', 'D92', '2022/09/12',	'2022/09/12', '2022/09/12',	N'TP Cần Thơ')

INSERT INTO chitietdathang
VALUES
    (1, 'D02', 25000000, 2, 0.5),
    (2, 'D05', 7000000000, 1, 0.3),
    (3, 'D04', 1000000, 5, 0.1),
    (4, 'D01', 35000000, 3, 0.2),
    (5, 'D03', 1000000, 6, 0.4)

SELECT * FROM nhacungcap
SELECT * FROM loaihang
SELECT * FROM mathang
SELECT * FROM nhanvien
SELECT * FROM khachhang
SELECT * FROM dondathang
SELECT * FROM chitietdathang

DROP TABLE nhacungcap
DROP TABLE loaihang
DROP TABLE mathang
DROP TABLE nhanvien
DROP TABLE khachhang
DROP TABLE dondathang
DROP TABLE chitietdathang


ALTER TABLE mathang ADD CONSTRAINT fk_mathang_loaihang FOREIGN KEY (maloaihang) REFERENCES loaihang
(maloaihang)
ON DELETE CASCADE ON UPDATE CASCADE ,
CONSTRAINT fk_mathang_nhacungcap FOREIGN KEY (macongty) REFERENCES nhacungcap(macongty)
ON DELETE CASCADE ON UPDATE CASCADE

ALTER TABLE dondathang ADD CONSTRAINT fk_dondathang_khachhang FOREIGN KEY (makhachhang)
REFERENCES khachhang(makhachhang) ON DELETE CASCADE ON UPDATE CASCADE ,
CONSTRAINT fk_dondathang_nhanvien FOREIGN KEY (manhanvien) REFERENCES nhanvien(manhanvien)
ON DELETE CASCADE ON UPDATE CASCADE

ALTER TABLE chitietdathang ADD CONSTRAINT fk_chitiet_dondathang FOREIGN KEY (sohoadon) REFERENCES
dondathang(sohoadon)
ON DELETE CASCADE ON UPDATE CASCADE ,
CONSTRAINT fk_chitiet_mathang FOREIGN KEY (mahang) REFERENCES mathang(mahang)
ON DELETE CASCADE ON UPDATE CASCADE

/*1    Hãy cho biết có những khách hàng nào lại chính là đối tác cung cấp hàng của công ty (tức là có cùng tên giao dịch)*/
SELECT khachhang.tencongty, khachhang.tengiaodich, khachhang.diachi
FROM   khachhang INNER JOIN nhacungcap ON khachhang.tengiaodich = nhacungcap.tengiaodich
/*2  Những đơn đặt hàng nào yêu cầu giao hàng ngay tại cty đặt hàng và những đơn đó là của công ty nào? */
SELECT dondathang.sohoadon,noigiaohang,khachhang.tencongty,tengiaodich
FROM dondathang INNER JOIN khachhang
ON khachhang.makhachhang = dondathang.makhachhang
WHERE khachhang.diachi = dondathang.noigiaohang
/*3  Những mặt hàng nào chưa từng được khách hàng đặt mua?*/
SELECT mahang, tenhang FROM mathang
WHERE NOT EXISTS (select mahang from chitietdathang where chitietdathang.mahang=mathang.mahang)
/*4  Những nhân viên nào của công ty chưa từng lập bất kỳ một hoá đơn đặt hàng nào? */
SELECT ho, ten FROM nhanvien
WHERE NOT EXISTS (select manhanvien from dondathang where dondathang.manhanvien = nhanvien.manhanvien)
/*5  Trong năm 2003, những mặt hàng nào chỉ được đặt mua đúng một lần*/
SELECT mathang.mahang, tenhang
FROM (mathang INNER JOIN chitietdathang
            ON mathang.mahang=chitietdathang.mahang)
            INNER JOIN dondathang
            ON chitietdathang.sohoadon=dondathang.sohoadon
WHERE year(ngaydathang)=2003
GROUP BY mathang.mahang, tenhang
HAVING COUNT (chitietdathang.mahang)=1
/*6  Hãy cho biết mỗi một khách hàng đã phải bỏ ra bao nhiêu tiền để đặt mua hàng của công ty? */
SELECT khachhang.makhachhang,tencongty,tengiaodich,
            SUM (soluong*giaban-soluong*giaban*mucgiamgia/100)AS giatien
FROM (khachhang INNER JOIN dondathang
            ON khachhang.makhachhang=dondathang.makhachhang)
            INNER JOIN chitietdathang
            ON dondathang.sohoadon=chitietdathang.sohoadon
GROUP BY khachhang.makhachhang,tencongty,tengiaodich
/*7  Mỗi một nhân viên của công ty đã lập bao nhiêu đơn đặt hàng (nếu nhân viên chưa hề lập một hoá đơn nào thì cho kết quả là 0)*/
SELECT nhanvien.manhanvien,ho,ten,COUNT(sohoadon) AS tongsohoadon
FROM nhanvien LEFT OUTER JOIN dondathang
       ON nhanvien.manhanvien=dondathang.manhanvien
GROUP BY nhanvien.manhanvien,ho,ten
/*8  Cho biết tổng số tiền hàng mà cửa hàng thu được trong mỗi tháng của năm 2003 (thời được gian tính theo ngày đặt hàng) */
SELECT MONTH(ngaydathang)AS thang,
         SUM (soluong*giaban-soluong*giaban*mucgiamgia/100)AS sotien
FROM dondathang INNER JOIN chitietdathang
       ON dondathang.sohoadon=chitietdathang.sohoadon
WHERE YEAR(ngaydathang)=2003
GROUP BY month (ngaydathang)
/*9  Hãy cho biết tổng số lượng hàng của mỗi mặt hàng mà cty đã có (tổng số lượng hàng hiện có và đã bán) */
SELECT mathang.mahang,tenhang,mathang.soluong+
         CASE
                  WHEN SUM(chitietdathang.soluong) IS NULL THEN 0
                  ELSE SUM(chitietdathang.soluong)
            END AS tongsoluong
FROM mathang LEFT OUTER JOIN chitietdathang
ON mathang.mahang=chitietdat.hangmahang
GROUP BY mathang.mahang, tenhang, mathang.soluong
/*10 Nhân viên nào của cty bán được số lượng hàng nhiều nhất và số lượng hàng bán được của nhân viên này là bao nhiêu?*/

SELECT nhanvien.manhanvien, ho,ten,SUM(soluong)as tongsoluong
FROM (nhanvien INNER JOIN dondathang
        ON nhanvien.manhanvien=dondathang.manhanvien)
        INNER JOIN chitietdathang
        ON dondathang.sohoadon=chitietdathang.sohoadon
GROUP BY nhanvien.manhanvien,ho,ten
HAVING SUM(soluong) >= ALL
         (SELECT sum(soluong)
            FROM (nhanvien INNER JOIN dondathang
                    ON nhanvien.manhanvien=dondathang.manhanvien)
                    INNER JOIN chitietdathang ON
                    dondathang.sohoadon=chitietdathang.sohoadon
            GROUP BY nhanvien.manhanvien,ho,ten)
/*11 Mỗi một đơn đặt hàng đặt mua những mặt hàng nào và tổng số tiền mà mỗi đơn đặt hàng phải trả là bao nhiêu? */
SELECT A.sohoadon,B.mahang,tenhang,
         B.soluong*giaban-B.soluong*giaban*mucgiamgia/100
FROM (dondathang AS A INNER JOIN chitietdathang AS B
        ON A.sohoadon=B.sohoadon)
        INNER JOIN mathang AS C ON B.mathang = C.mathang
ORDER BY A.sohoadon
COMPUTE SUM(B.soluong*giaban-B.soluong*giaban*mucgiamgia/100)
        BY A.sohoadon
/*12 Hãy cho biết mỗi một loại hàng bao gồm những mặt hàng nào, tổng số lượng hàng của mỗi loại và tổng số lượng của tất cả các
mặt hàng hiện có trong công ty là bao nhiêu? */
SELECT loaihangmaloaihang,tenloaihang,mahang,tenhang,soluong
FROM loaihang INNER JOIN mathang
       ON loaihangmaloaihang=mathangmaloaihang
ORDER BY loaihang.maloaihang
COMPUTE SUM(soluong)BY loaihangmaloaihang
COMPUTE SUM(soluong)
/*13 Thống kê xem trong năm 2003, mỗi một mặt hàng trong mỗi tháng và trong cả năm bán được với số lượng bao nhiêu*/
SELECT Bmahang,tenhang,
         SUM(CASE MONTH(ngaydathang)WHEN 1 THEN Bsoluong
               ELSE 0 END) AS thang1,
       SUM(CASE MONTH(ngaydathang)WHEN 2 THEN Bsoluong
               ELSE 0 END) AS thang2,
         SUM(CASE MONTH(ngaydathang)WHEN 3 THEN Bsoluong
               ELSE 0 END) AS thang3,
         SUM(CASE MONTH(ngaydathang)WHEN 4 THEN Bsoluong
               ELSE 0 END) AS thang4,
       SUM(CASE MONTH(ngaydathang)WHEN 5 THEN Bsoluong
               ELSE 0 END) AS thang5,
       SUM(CASE MONTH(ngaydathang)WHEN 6 THEN Bsoluong
               ELSE 0 END) AS thang6,
       SUM(CASE MONTH(ngaydathang)WHEN 7 THEN Bsoluong
               ELSE 0 END) AS thang7,
       SUM(CASE MONTH(ngaydathang)WHEN 8 THEN Bsoluong
               ELSE 0 END) AS thang8,
       SUM(CASE MONTH(ngaydathang)WHEN 9 THEN Bsoluong
               ELSE 0 END) AS thang9,
       SUM(CASE MONTH(ngaydathang)WHEN 10 THEN Bsoluong
               ELSE 0 END) AS thang10,
       SUM(CASE MONTH(ngaydathang)WHEN 11 THEN Bsoluong
               ELSE 0 END) AS thang11,
       SUM(CASE MONTH(ngaydathang)WHEN 12 THEN Bsoluong
               ELSE 0 END) AS thang12,
       SUM (Bsoluong) AS canam
FROM (dondathang AS A INNER JOIN chitietdathang AS B

        ON Asohoadon=Bsohoadon)
        INNER JOIN mathang AS C ON Bmahang=Cmahang
WHERE YEAR(ngaydathang)=2003
GROUP BY Bmathang,tenhang
/*14 Cập nhật lại giá trị NGAYCHUYENHANG của những bản ghi có giá trị NGAYCHUYENHANG chưa xác định (NULL) trong
bảng DONDATHANG bằng với giá trị của trường NGAYDATHANG*/
UPDATE dondathang
SET ngaychuyenhang=ngaydathang
WHERE ngaychuyenhang IS NULL
/*15 Cập nhật giá trị của trường NOIGIAOHANG trong bảng DONDATHANG bằng địa chỉ của khách hàng đối với những đơn đặt
hàng chưa xác định được nơi giao hàng (có giá trị trường NOIGIAOHANG bằng NULL)*/
UPDATE dondathang
SET noigiaohang=diachi
FROM khachhang
WHERE dondathangmakhachhang=khachhangmakhachhang
      AND noigiaohang IS NULL
/*16 Cập nhật lại dữ liệu trong bảng KHACHHANG sao cho nếu tên công ty và tên giao dịch của khách hàng trùng với tên công ty
và tên giao dịch của một nhà cung cấp nào đó thì địa chỉ, điện thoại, fax và email phải giống nhau*/
UPDATE khachhang
SET khachhangdiachi=nhacungcapdiachi,
      khachhangdienthoai=nhacungcapdienthoai,
      khachhangfax=nhacungcapfax,
      khachhangemail=nhacungcapemail
FROM nhacungcap
WHERE khachhangtencongty=nhacungcaptencongty
        AND khachhangtengiaodich=nhacungcaptengiaodich
/*17 Tăng lương lên gấp rưỡi cho những nhân viên bán được số lượng hàng nhiều hơn 100 trong năm 2003 */
UPDATE nhanvien
SET luongcoban=luongcoban*15
WHERE manhanvien=
        (SELECT manhanvien
         FROM dondathang INNER JOIN chitietdathang
       ON dondathangsohoadon=chitietdathangsohoadon
       WHERE manhanvien=nhanvienmanhanvien
       GROUP BY manhanvien
       HAVING  SUM(soluong)&gt;100 AND YEAR (ngaygiaohang)=2003)
 
/*18  Tăng phụ cấp lên bằng 50% lương cho những nhân viên bán được hàng nhiều nhất*/
UPDATE nhanvien
SET phucap=luongcoban/2
WHERE manhanvien IN
                  (select manhanvien
                  from dondathang, chitietdathang
                  where dondathangsohoadon=chitietdathangsohoadon
                  group by manhanvien
                  having sum (soluong) >= all
                                         
(select sum (soluong)from dondathang,chitietdathang
                  where dondathangsohoadon=chitietdathangsohoadon
                                          group by manhanvien))
/*19 Giảm 25% lương của những nhân viên trong năm 2003 ko lập được bất kỳ đơn đặt hàng nào */
UPDATE nhanvien
SET luongcoban= luongcoban-luongcoban*025
WHERE NOT EXISTS (select manhanvien from dondathang where dondathangmanhanvien=nhanvienmanhanvien)

/*20 Giả sử trong bảng DONDATHANG có them trường SOTIEN cho biết số tiền mà khách hàng phải trả trong mỗi dơn đặt hàng
Hãy tính giá trị cho trường này*/
UPDATE dondathang
SET sotien = (select SUM(soluong*giaban- soluong*giaban*mucgiamgia)
                        from chitietdathang where dondathangsohoadon=chitietdathangsohoadon)
/*21 Xoá khỏi bảng MATHANG những mặt hàng có số lượng bằng 0 và không được đặt mua trong bất kỳ đơn đặt hàng nào*/
DELETE FROM mathang
            WHERE NOT EXISTS (select mahang from chitietdathang where chitietdathangmahang=mathangmahang) AND mathangsoluong =0
GO
CREATE PROCEDURE sp_insert_mathang(

                  @mahang           NVARCHAR(10),
                  @tenhang          NVARCHAR(50),
                  @macongty         NVARCHAR(10) = NULL,
                  @maloaihang INT = NULL,
                  @soluong          INT = 0,
                  @donvitinh  NVARCHAR(20) = NULL,
                  @giahang    money = 0 )
      AS
            IF NOT EXISTS(SELECT mahang FROM mathang WHERE mahang=@mahang)
       IF (@macongty IS NULL OR EXISTS(SELECT macongty  FROM nhacungcap WHERE macongty=@macongty))
AND (@maloaihang IS NULL OR  EXISTS(SELECT maloaihang FROM loaihang
WHERE maloaihang=@maloaihang))     
INSERT INTO mathang VALUES(@mahang, @tenhang, @macongty, @maloaihang, @soluong, @donvitinh, @giahang)
GO
 exec sp_insert_mathang '005','Bom B52','ct03',2,34,'VND', $500000
GO