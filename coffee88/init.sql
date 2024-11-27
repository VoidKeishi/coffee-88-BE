-- Enums
CREATE TYPE price_range AS ENUM ('low', 'medium', 'high');
CREATE TYPE cafe_style AS ENUM ('modern', 'traditional', 'vintage', 'outdoor', 'workspace');
CREATE TYPE drink_type AS ENUM ('coffee', 'tea', 'smoothie', 'juice', 'other');

-- Table cafes
CREATE TABLE cafes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    image_urls TEXT[], -- Array of image URLs
    price_range price_range NOT NULL,
    style cafe_style NOT NULL,
    google_rating DECIMAL(2,1) CHECK (google_rating >= 0 AND google_rating <= 5), -- 0-5 rating
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL,
    distance_from_sun DECIMAL(5,2) NOT NULL, -- Distance in kilometers
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for cafes
CREATE INDEX idx_distance_from_sun ON cafes(distance_from_sun);
CREATE INDEX idx_price_range ON cafes(price_range);

-- Table drinks
CREATE TABLE drinks (
    id SERIAL PRIMARY KEY,
    cafe_id INTEGER NOT NULL REFERENCES cafes(id) ON DELETE CASCADE, -- Foreign key to cafes
    name VARCHAR(100) NOT NULL,
    type drink_type NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0), -- Must be > 0
    description TEXT,
    image_url TEXT,
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for drinks
CREATE INDEX idx_cafe_id ON drinks(cafe_id);
CREATE INDEX idx_type ON drinks(type);


-- Insert quán cà phê
INSERT INTO cafes (name, address, image_urls, price_range, style, google_rating, opening_time, closing_time, distance_from_sun) VALUES
('Secret Garden Cafe', 
 'Lô 39 (TT4) đường đỗ đình thiện Khu đô thị mới Mỹ Đình - Mễ Trì, P. Mỹ Đình 1, Nam Từ Liêm, 100000, Việt Nam', 
 '{"https://res.cloudinary.com/ddfbcat7h/image/upload/v1732721496/Picture4_plm7af.png"}', 
 'medium', 'vintage', 4.5, '09:00', '23:00', 0.6),
 
('Adogen Cafe', 
 'Lo 15 TT4, P. Trần Văn Lai, Mỹ Đình, song da, Việt Nam', 
 '{"https://res.cloudinary.com/ddfbcat7h/image/upload/v1732721495/Picture5_pi2yrn.png"}', 
 'medium', 'modern', 4.4, '08:00', '23:00', 0.8),
 
('Cafe Alex', 
 '2Q8G+8F8, 106 TT3, Mỹ Đình, Nam Từ Liêm, Hà Nội, Việt Nam', 
 '{"https://res.cloudinary.com/ddfbcat7h/image/upload/v1732721496/Picture6_udc8b7.png"}', 
 'high', 'modern', 4.7, '07:00', '23:00', 1.1),
 
('Cafe Vũ', 
 'Mễ Trì Hạ, Nam Từ Liêm, Hà Nội, Việt Nam', 
 '{"https://res.cloudinary.com/ddfbcat7h/image/upload/v1732721496/Picture7_xd1wfi.png"}', 
 'medium', 'outdoor', 4.0, '07:00', '23:00', 0.27),
 
('Vinh Cafe', 
 'Lô BT1-35, Khu đô thị Mễ Trì Hạ, Nam Từ Liêm, Hà Nội, Việt Nam', 
 '{"https://res.cloudinary.com/ddfbcat7h/image/upload/v1732721498/Picture8_hfin3w.png"}', 
 'medium', 'traditional', 4.0, '07:00', '23:00', 0.3),
 
('Cafe Sài Gòn', 
 'Khu đô thị Mễ Trì Hạ, Nam Từ Liêm, Hà Nội, Việt Nam', 
 '{"https://res.cloudinary.com/ddfbcat7h/image/upload/v1732721499/Picture9_h4sjuo.png"}', 
 'high', 'outdoor', 4.7, '07:00', '23:30', 0.6),
 
('Café de Măng Đen Nguyễn Chánh', 
 '126 P. Nguyễn Chánh, Yên Hoà, Cầu Giấy, Hà Nội, Việt Nam', 
 '{"https://res.cloudinary.com/ddfbcat7h/image/upload/v1732721499/Picture10_ft5pmg.png"}', 
 'medium', 'modern', 4.5, '07:00', '22:00', 0.85),
 
('Coffee Quân', 
 'Yên Hoà, Cầu Giấy, Hà Nội, Việt Nam', 
 '{"https://res.cloudinary.com/ddfbcat7h/image/upload/v1732721498/Picture11_cjwdb3.png"}', 
 'medium', 'vintage', 4.3, '06:30', '23:00', 2.2),
 
('Mơ Cà phê', 
 '2 Đ. Trung Yên 10A, Yên Hoà, Cầu Giấy, Hà Nội, Việt Nam', 
 '{"https://res.cloudinary.com/ddfbcat7h/image/upload/v1732721500/Picture12_dqve8r.png"}', 
 'high', 'modern', 4.6, '07:00', '03:00', 2.7),
 
('La Jolie Café', 
 '28 Ngõ 62 Nguyễn Chí Thanh, Láng Thượng, Đống Đa, Hà Nội 00120, Việt Nam', 
 '{"https://res.cloudinary.com/ddfbcat7h/image/upload/v1732721495/Picture13_bjuhqc.png"}', 
 'medium', 'modern', 4.3, '08:00', '22:30', 4.2),
 
('Gosiwon Coffee In Bed', 
 '18 Ngõ 34 Nguyễn Thị Định, Trung Hoà, Cầu Giấy, Hà Nội, Việt Nam', 
 '{"https://res.cloudinary.com/ddfbcat7h/image/upload/v1732721496/Picture14_h9hrqx.png"}', 
 'low', 'workspace', 4.6, '09:00', '23:30', 3.6);

INSERT INTO drinks (cafe_id, name, type, price) VALUES
(1, 'ESPRESSO', 'coffee', 50000),
(1, 'AMERICANO', 'coffee', 50000),
(1, 'COFFEE LATTE', 'coffee', 65000),
(1, 'CAPUCHINO', 'coffee', 68000),
(1, 'COCONUT COFFEE', 'coffee', 65000),
(1, 'CHOCOLATE COFFEE', 'coffee', 68000),
(1, 'AVOCADO COFFEE', 'coffee', 68000),
(1, 'DETOX JUICE (CURLY KALE + CARROT + CUCUMBER + APPLE)', 'juice', 79000),
(1, 'DETOX VITAMIN (CURLY KALE + CARROT + ORANGE + PINEAPPLE)', 'juice', 79000),
(1, 'JASMINE TEA', 'tea', 60000),
(1, 'LEMON TEA', 'tea', 60000),
(1, 'GREEN TEA', 'tea', 60000),
(1, 'VOI TEA', 'tea', 60000),
(1, 'GINGER TEA', 'tea', 65000),
(1, 'COCOA', 'tea', 55000),
(1, 'PINEAPPLE JUICE', 'juice', 60000),
(1, 'CARROT JUICE', 'juice', 60000),
(1, 'WATERMELON JUICE', 'juice', 60000),
(1, 'ORANGE JUICE', 'juice', 60000),
(1, 'PASSION FRUIT JUICE', 'juice', 60000),
(1, 'COCONUT JUICE', 'juice', 60000),
(1, 'MOJITO', 'juice', 98000),
(1, 'AVOCADO SHAKE', 'smoothie', 65000),
(1, 'MANGO SHAKE', 'smoothie', 65000),
(1, 'BANANA SHAKE', 'smoothie', 65000),
(1, 'LEMON SHAKE', 'smoothie', 65000);


INSERT INTO drinks (cafe_id, name, type, price) VALUES
(2, 'Americano', 'coffee', 60000),
(2, 'Latte', 'coffee', 70000),
(2, 'Flat White', 'coffee', 75000),
(2, 'Cappuccino', 'coffee', 80000),
(2, 'Café Mocha', 'coffee', 80000),
(2, 'Cloud Mocha', 'coffee', 90000),
(2, 'Caramel Macchiato', 'coffee', 90000),
(2, 'Vienna Coffee', 'coffee', 90000),
(2, 'Matcha Café Latte', 'coffee', 90000),
(2, 'Cold Brew', 'coffee', 90000),
(2, 'Cold Brew Latte', 'coffee', 100000),
(2, 'Cold Brew Einspanner', 'coffee', 110000),
(2, 'Matcha Latte', 'tea', 70000),
(2, 'Ssuk Latte', 'tea', 70000),
(2, 'Black tea Latte', 'tea', 75000),
(2, 'Cacao Latte', 'tea', 70000),
(2, 'Lime Snow', 'smoothie', 75000),
(2, 'Mango', 'smoothie', 75000),
(2, 'Matcha', 'smoothie', 75000),
(2, 'Ssuk', 'smoothie', 80000),
(2, 'Mixed Grains Latte', 'smoothie', 80000),
(2, 'pineapple Juice', 'juice', 75000),
(2, 'Lime Juice', 'juice', 70000);



INSERT INTO drinks (cafe_id, name, type, price) VALUES
(3, 'Cà phê đen nóng/ đá pha máy', 'coffee', 40000),
(3, 'Cà phê cốt dừa', 'coffee', 55000),
(3, 'Cà phê trứng nướng', 'coffee', 60000),
(3, 'Caramel muối (Salted caramel)', 'coffee', 70000),
(3, 'Espresso', 'coffee', 40000),
(3, 'Latte', 'coffee', 65000),
(3, 'Cappuccino', 'coffee', 55000),
(3, 'Guồng kem máy', 'coffee', 80000),
(3, 'Vanilla latte', 'coffee', 75000),
(3, 'Ôn đới sữa đặc (Condensed milk latte)', 'coffee', 75000),
(3, 'Caramel macchiato', 'coffee', 75000),
(3, 'Americano', 'coffee', 55000),
(3, 'Trà tắc hồng bì', 'tea', 60000),
(3, 'Trà đào cam sả', 'tea', 80000),
(3, 'Trà búp dâm xoài cam', 'tea', 60000),
(3, 'Trà ô long nhãn hạt dẻ cười', 'tea', 70000),
(3, 'Trà sữa ô long', 'tea', 70000),
(3, 'Trà sữa earl grey', 'tea', 50000),
(3, 'Trà sữa sinh tố bơ', 'tea', 50000),
(3, 'Trà sữa hạt dẻ cười kem trứng nướng', 'tea', 70000),
(3, 'Trà lychee hibiscus', 'tea', 50000),
(3, 'Trà bạc hà', 'tea', 50000),
(3, 'Trà gừng', 'tea', 70000),
(3, 'Nước chanh', 'juice', 60000),
(3, 'Lavie en rose', 'juice', 60000),
(3, 'Nước ép dứa', 'juice', 60000),
(3, 'Nước chanh leo', 'juice', 60000),
(3, 'Nước cam', 'juice', 60000),
(3, 'Nước dừa dứa nha đam', 'juice', 70000),
(3, 'Sinh tố bơ sen hạnh nhân', 'smoothie', 50000),
(3, 'Quất hồng bì tuyết', 'smoothie', 80000),
(3, 'Sinh tố xoài', 'smoothie', 70000),
(3, 'Sinh tố bổ', 'smoothie', 70000),
(3, 'Sinh tố avocado', 'smoothie', 70000),
(3, 'Sinh tố kim quất', 'smoothie', 70000);



INSERT INTO drinks (cafe_id, name, type, price) VALUES
(4, 'Cà phê cốt dừa', 'coffee', 40000),
(4, 'Cafe muối', 'coffee', 35000),
(4, 'Bạc xỉu', 'coffee', 35000),
(4, 'Cafe nâu đen', 'coffee', 25000),
(4, 'Cafe Tiramisu', 'coffee', 50000),
(4, 'Cafe kem trứng', 'coffee', 60000),
(4, 'Cafe hạnh nhân', 'coffee', 60000),
(4, 'Trà chanh nhiệt độ', 'tea', 40000),
(4, 'Trà chanh nhiệt độ đá', 'tea', 40000),
(4, 'Đào bưởi kem trứng', 'tea', 45000),
(4, 'Matcha cốt dừa', 'tea', 45000),
(4, 'Ô long hồng', 'tea', 60000),
(4, 'Matcha kem cheese', 'tea', 40000),
(4, 'Sen vàng', 'tea', 40000),
(4, 'Hồng trà sữa', 'tea', 40000),
(4, 'Bào ngư cam', 'tea', 35000),
(4, 'Cam quế', 'tea', 35000),
(4, 'Đào cam sả', 'tea', 35000),
(4, 'Cam tươi', 'juice', 45000),
(4, 'Ổi cóc (Dứa)', 'juice', 45000),
(4, 'Dứa xiêm', 'juice', 40000),
(4, 'Cam', 'juice', 40000),
(4, 'Chanh leo/ Dưa hấu', 'juice', 35000),
(4, 'Ổi cóc dừa cà rốt', 'juice', 45000),
(4, 'Bơ', 'smoothie', 55000),
(4, 'Mango', 'smoothie', 50000),
(4, 'Việt quất', 'smoothie', 55000);




-- Quán Vinh Cafe (id = 5)
INSERT INTO drinks (cafe_id, name, type, price) VALUES
(5, 'Cà phê đen nóng/ đá', 'coffee', 25000),
(5, 'Nâu nóng/ đá', 'coffee', 25000),
(5, 'Bạc xỉu', 'coffee', 35000),
(5, 'Cà phê cốt dừa', 'coffee', 40000),
(5, 'Cà phê đá xay', 'smoothie', 35000),
(5, 'Cà phê socola', 'smoothie', 45000),
(5, 'Cà phê vani', 'smoothie', 40000),
(5, 'Matcha đá xay', 'smoothie', 45000),
(5, 'Socola cookies', 'smoothie', 45000),
(5, 'Cốt dừa hoa đậu biếc', 'smoothie', 45000),

(5, 'Dừa tươi', 'juice', 45000),
(5, 'Chanh tươi', 'juice', 45000),
(5, 'Chanh dây', 'juice', 45000),
(5, 'Cam tươi', 'juice', 45000),
(5, 'Lựu ép', 'juice', 50000),
(5, 'Ổi ép', 'juice', 45000),
(5, 'Bưởi ép', 'juice', 45000),
(5, 'Táo ép', 'juice', 40000),
(5, 'Dứa ép', 'juice', 45000),
(5, 'Nước ép', 'juice', 40000),
(5, 'Sinh tố bơ', 'smoothie', 40000),
(5, 'Sinh tố mãng cầu', 'smoothie', 45000),
(5, 'Sinh tố xoài', 'smoothie', 40000),
(5, 'Sinh tố chanh leo', 'smoothie', 45000),
(5, 'Sinh tố sữa chua', 'smoothie', 45000);

-- Quán Cafe Sài Gòn (id = 6)
INSERT INTO drinks (cafe_id, name, type, price) VALUES
(6, 'Cafe đen', 'coffee', 30000),
(6, 'Cafe sữa', 'coffee', 28000),
(6, 'Bạc xỉu', 'coffee', 35000),
(6, 'Bạc xỉu Sài Gòn', 'coffee', 35000),
(6, 'Cafe muối', 'coffee', 35000),
(6, 'Cafe kem cheese', 'coffee', 35000),
(6, 'Matcha Latte', 'coffee', 45000),
(6, 'Cacao', 'coffee', 45000),
(6, 'Trà chanh hạt đác', 'tea', 35000),
(6, 'Trà vải', 'tea', 40000),
(6, 'Trà đào cam sả', 'tea', 45000),
(6, 'Trà đào chanh dây', 'tea', 45000),
(6, 'Trà xoài chanh dây', 'tea', 45000),
(6, 'Trà bưởi hồng T.Long', 'tea', 45000),
(6, 'Chanh tươi', 'juice', 30000),
(6, 'Chanh leo', 'juice', 35000),
(6, 'Dưa hấu', 'juice', 35000),
(6, 'Chanh dây', 'juice', 40000),
(6, 'Cam ép', 'juice', 40000),
(6, 'Thơm', 'juice', 35000),
(6, 'Táo', 'juice', 35000),
(6, 'Bơ', 'smoothie', 45000),
(6, 'Mãng cầu', 'smoothie', 45000),
(6, 'Xoài', 'smoothie', 45000),
(6, 'Mix (2 loại)', 'smoothie', 50000),
(6, 'Dâu tầm sữa chua', 'smoothie', 50000);

-- Quán Café de Măng Đen Nguyễn Chánh (id = 7)
INSERT INTO drinks (cafe_id, name, type, price) VALUES
(7, 'Americano', 'coffee', 50000),
(7, 'Cappuccino', 'coffee', 50000),
(7, 'Cà phê sữa đặc', 'coffee', 35000),
(7, 'Cà phê sữa đá muối', 'coffee', 35000),
(7, 'Cà phê đen đá', 'coffee', 30000),
(7, 'Bạc xỉu', 'coffee', 45000),
(7, 'Cà phê cốt dừa', 'coffee', 50000),
(7, 'Cà phê sữa đá mang đen', 'coffee', 40000),
(7, 'Trà đào cam sả', 'tea', 45000),
(7, 'Trà xoài chanh leo', 'tea', 45000),
(7, 'Trà bưởi hồng', 'tea', 45000),
(7, 'Trà gừng', 'tea', 35000),
(7, 'Trà tắc', 'tea', 35000),
(7, 'Cam nguyên chất', 'juice', 50000),
(7, 'Chanh dây', 'juice', 45000),
(7, 'Dưa hấu', 'juice', 45000),
(7, 'Cam chanh dây', 'juice', 50000),
(7, 'Cam cà rốt', 'juice', 50000),
(7, 'Bơ', 'smoothie', 50000),
(7, 'Xoài', 'smoothie', 50000),
(7, 'Dâu', 'smoothie', 50000),
(7, 'Kem dâu sữa chua', 'smoothie', 58000),
(7, 'Kem chuối sữa chua', 'smoothie', 58000),
(7, 'Xoài chanh leo', 'smoothie', 58000);

-- Quán Coffee Quân (id = 8)
INSERT INTO drinks (cafe_id, name, type, price) VALUES
(8, 'Nâu', 'coffee', 20000),
(8, 'Đen', 'coffee', 20000),
(8, 'Nâu/Đen pha phin', 'coffee', 25000),
(8, 'Bạc xỉu', 'coffee', 20000),
(8, 'Cacao', 'coffee', 25000),
(8, 'Cacao cốt dừa', 'coffee', 30000),
(8, 'Cafe cốt dừa', 'coffee', 30000),
(8, 'Sữa chua đá', 'smoothie', 20000),
(8, 'Sữa chua cacao', 'smoothie', 25000),
(8, 'Sữa chua chanh leo', 'smoothie', 25000),
(8, 'Hộp sữa chua', 'smoothie', 15000),
(8, 'Trà gừng mật ong', 'tea', 20000),
(8, 'Trà đào', 'tea', 25000),
(8, 'Trà chanh sả/đào sả/quất sả', 'tea', 25000),
(8, 'Trà đào cam sả', 'tea', 30000),
(8, 'Trà đào chanh leo', 'tea', 30000),
(8, 'Trà táo bạc hà', 'tea', 35000),
(8, 'Trà táo quế', 'tea', 35000),
(8, 'Trà cam quế mật ong', 'tea', 30000),
(8, 'Trà dưa hấu nha đam', 'tea', 30000);



-- Quán id 9: Mơ Cà phê
INSERT INTO drinks (cafe_id, name, type, price) VALUES
(9, 'Phê đen (nóng/đá)', 'coffee', 29000),
(9, 'Phê nâu (nóng/đá)', 'coffee', 35000),
(9, 'Phê sữa tươi', 'coffee', 39000),
(9, 'Phê kem', 'coffee', 39000),
(9, 'Phê kem muối', 'coffee', 39000),
(9, 'Sữa chua là nếp', 'smoothie', 45000),
(9, 'Sữa chua cà phê', 'smoothie', 45000),
(9, 'Sữa chua cacao', 'smoothie', 45000),
(9, 'Sữa chua coco', 'smoothie', 45000),
(9, 'Quất mật', 'tea', 45000),
(9, 'Nho dứa', 'tea', 45000),
(9, 'Dâu rừng hoa hồng', 'tea', 49000),
(9, 'Bưởi hồng cánh sen', 'tea', 49000),
(9, 'Ôlong sữa', 'tea', 49000),
(9, 'Ôlong bơ sữa', 'tea', 55000),
(9, 'Hướng dương', 'tea', 25000);

-- Quán id 10: La Jolie Café
INSERT INTO drinks (cafe_id, name, type, price) VALUES
(10, 'Cà phê đen', 'coffee', 35000),
(10, 'Cà phê nâu', 'coffee', 35000),
(10, 'Bạc xỉu', 'coffee', 40000),
(10, 'La Jolie Café', 'coffee', 55000),
(10, 'Cà phê cốt dừa', 'coffee', 45000),
(10, 'Latte', 'coffee', 55000),
(10, 'Trà thạch đào', 'tea', 55000),
(10, 'Trà dâu dứa', 'tea', 60000),
(10, 'La Jolie Tea', 'tea', 60000),
(10, 'Trà ổi hồng', 'tea', 60000),
(10, 'Trà xoài dứa', 'tea', 60000),
(10, 'Nước ép cam', 'juice', 55000),
(10, 'Nước ép dứa', 'juice', 55000),
(10, 'Nước ép dưa hấu', 'juice', 55000),
(10, 'Matcha đá xay', 'smoothie', 55000),
(10, 'Chococookies đá xay', 'smoothie', 55000),
(10, 'Xoài dừa đá xay', 'smoothie', 55000);

-- Quán id 11: Gosiwon Coffee In Bed
INSERT INTO drinks (cafe_id, name, type, price) VALUES
(11, 'Cà phê đen', 'coffee', 35000),
(11, 'Cà phê nâu', 'coffee', 35000),
(11, 'Bạc xỉu', 'coffee', 40000),
(11, 'Cà phê cốt dừa', 'coffee', 45000),
(11, 'Trà Ô long', 'tea', 35000),
(11, 'Trà Nhài Táo Xanh', 'tea', 35000),
(11, 'Trà Sen Vang Sả', 'tea', 35000),
(11, 'Ô long Dứa Lưới', 'tea', 35000),
(11, 'Trà Đào Cam Sả Nóng', 'tea', 40000),
(11, 'Trà Đào Chanh Leo Nóng', 'tea', 40000),
(11, 'Chanh leo', 'smoothie', 35000),
(11, 'Cam Táo', 'smoothie', 35000),
(11, 'Dứa Ổi', 'smoothie', 35000),
(11, 'Sinh tố Bơ', 'smoothie', 40000),
(11, 'Sinh tố Bơ Xoài', 'smoothie', 40000),
(11, 'Sinh tố Xoài Hạnh Nhân', 'smoothie', 40000);