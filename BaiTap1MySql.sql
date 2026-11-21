
-- Kiểm tra tên database hiện tại đang sử dụng
SELECT current_database()

-- Tạo database Baitap1
CREATE DATABASE Baitap1;

-- Kiểm tra tên database và schema đang sử dụng
SELECT current_database(), current_schema();

-- Tạo TABLE user
CREATE TABLE IF NOT EXISTS "user" (
	"id" serial PRIMARY KEY,
	"fullName" VARCHAR(255),
	"email" VARCHAR(255),
	"password" VARCHAR(255),
	"createdAt" timestamp not null default CURRENT_TIMESTAMP,
	"updatedAt" timestamp not null default CURRENT_TIMESTAMP
);

-- Tạo TABLE restaurant
CREATE TABLE IF NOT EXISTS "restaurant" (
	"id" serial PRIMARY KEY,
	"resName" VARCHAR(255),
	"image" VARCHAR(255),
	"desc" VARCHAR(255),
	"createdAt" timestamp not null default CURRENT_TIMESTAMP,
	"updatedAt" timestamp not null default CURRENT_TIMESTAMP
);

-- Tạo TABLE foodType
CREATE TABLE IF NOT EXISTS "foodType" (
	"id" serial PRIMARY KEY,
	"typeName" VARCHAR(255),
	"createdAt" timestamp not null default CURRENT_TIMESTAMP,
	"updatedAt" timestamp not null default CURRENT_TIMESTAMP
);

-- Tạo TABLE food
CREATE TABLE IF NOT EXISTS "food" (
	"id" serial PRIMARY KEY,
	"foodName" VARCHAR(255),
	"image" VARCHAR(255),
	"price" FLOAT,
	"desc" VARCHAR(255),
	"typeId" int,
	FOREIGN KEY ("typeId") REFERENCES "foodType" ("id"),
	"createdAt" timestamp not null default CURRENT_TIMESTAMP,
	"updatedAt" timestamp not null default CURRENT_TIMESTAMP
);

-- Tạo TABLE subFood
CREATE TABLE IF NOT EXISTS "subFood" (
	"id" serial PRIMARY KEY,
	"subName" VARCHAR(255),
	"subPrice" FLOAT,
	"foodId" int,
	FOREIGN KEY ("foodId") REFERENCES "food" ("id"),
	"createdAt" timestamp not null default CURRENT_TIMESTAMP,
	"updatedAt" timestamp not null default CURRENT_TIMESTAMP
);

-- Tạo TABLE order
CREATE TABLE IF NOT EXISTS "order" (
	"id" serial PRIMARY KEY,
	"userId" int,
	"foodId" int,
	"amount" int,
	"code" VARCHAR(255),
	"arrSubId" VARCHAR(255),
	FOREIGN KEY ("userId") REFERENCES "user" ("id"),
	FOREIGN KEY ("foodId") REFERENCES "food" ("id"),
	"createdAt" timestamp not null default CURRENT_TIMESTAMP,
	"updatedAt" timestamp not null default CURRENT_TIMESTAMP
);

-- Tạo TABLE rate
CREATE TABLE IF NOT EXISTS "rate" (
	"id" serial PRIMARY KEY,
	"userId" int,
	"resId" int,
	"amount" int,
	"dateRate" TIMESTAMP,
	FOREIGN KEY ("userId") REFERENCES "user" ("id"),
	FOREIGN KEY ("resId") REFERENCES "restaurant" ("id"),
	"createdAt" timestamp not null default CURRENT_TIMESTAMP,
	"updatedAt" timestamp not null default CURRENT_TIMESTAMP
);

-- Tạo TABLE like
CREATE TABLE IF NOT EXISTS "like" (
	"id" serial PRIMARY KEY,
	"userId" int,
	"resId" int,
	"dateLike" TIMESTAMP,
	FOREIGN KEY ("userId") REFERENCES "user" ("id"),
	FOREIGN KEY ("resId") REFERENCES "restaurant" ("id"),
	"createdAt" timestamp not null default CURRENT_TIMESTAMP,
	"updatedAt" timestamp not null default CURRENT_TIMESTAMP
);

-- Tìm 5 người đã like nhà hàng nhiều nhất
SELECT "user"."id", "fullName", COUNT("like"."userId") FROM "user" 
INNER JOIN "like" ON "user"."id" = "like"."userId"
GROUP BY "user"."id", "fullName"
ORDER BY "count" DESC
LIMIT 5

-- Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT "restaurant"."id", "resName", COUNT("like"."resId") FROM "restaurant" 
INNER JOIN "like" ON "restaurant"."id" = "like"."resId"
GROUP BY "restaurant"."id", "resName"
ORDER BY "count" DESC
LIMIT 2

-- Tìm người đã đặt hàng nhiều nhất
SELECT "user"."id", "fullName", COUNT("order"."userId") FROM "user" 
INNER JOIN "order" ON "user"."id" = "order"."userId"
GROUP BY "user"."id", "fullName"
ORDER BY "count" DESC
LIMIT 1

-- Tìm người dùng không hoạt động trong hệ thống
SELECT "user"."id", "fullName" FROM "user"
LEFT JOIN "order" ON "order"."userId" = "user"."id"
LEFT JOIN "rate" ON "rate"."userId" = "user"."id"
LEFT JOIN "like" ON "like"."userId" = "user"."id"
WHERE "like"."id" IS NULL AND "order"."id" IS NULL AND "rate"."id" IS NULL


-- Below is for data entry

-- -- insert user
-- INSERT INTO "user" ("fullName", "email", "password") VALUES
-- 	('Nguyen Van An', 'an@gmail.com', '123456'),
-- 	('Tran Thi Binh', 'binh@gmail.com', '123456'),
-- 	('Le Van Cuong', 'cuong@gmail.com', '123456'),
-- 	('Pham Thi Dung', 'dung@gmail.com', '123456'),
-- 	('Hoang Van Em', 'em@gmail.com', '123456'),
-- 	('Vo Thi Giang', 'giang@gmail.com', '123456'),
-- 	('Dang Van Hung', 'hung@gmail.com', '123456'),
-- 	('Bui Thi Hoa', 'hoa@gmail.com', '123456'),
-- 	('Do Van Khanh', 'khanh@gmail.com', '123456'),
-- 	('Nguyen Thi Lan', 'lan@gmail.com', '123456'),
--     ('Nguyen Van Minh', 'minh@gmail.com', '123456'),
--     ('Tran Van Nam', 'nam@gmail.com', '123456'),
--     ('Le Thi Ngoc', 'ngoc@gmail.com', '123456'),
--     ('Pham Van Phuc', 'phuc@gmail.com', '123456'),
--     ('Hoang Thi Thao', 'thao@gmail.com', '123456')
	
-- -- insert restaurant
-- INSERT INTO "restaurant" ("resName", "image", "desc") VALUES
-- 	('Pho Viet', 'pho.jpg', 'Quan pho Viet Nam'),
-- 	(
-- 		'Pizza House',
-- 		'pizza.jpg',
-- 		'Chuyen pizza va pasta'
-- 	),
-- 	(
-- 		'Burger King Food',
-- 		'burger.jpg',
-- 		'Chuyen burger va fast food'
-- 	),
-- 	(
-- 		'Sushi Tokyo',
-- 		'sushi.jpg',
-- 		'Nha hang sushi Nhat Ban'
-- 	),
-- 	(
-- 		'Com Tam Sai Gon',
-- 		'comtam.jpg',
-- 		'Com tam Viet Nam'
-- 	),
-- 	(
-- 		'Tra Sua House',
-- 		'trasua.jpg',
-- 		'Tra sua va topping'
-- 	),
-- 	(
-- 		'Chicken BBQ',
-- 		'chicken.jpg',
-- 		'Ga nuong va ga ran'
-- 	),
-- 	(
-- 		'Bun Bo Hue',
-- 		'bunbo.jpg',
-- 		'Bun bo Hue truyen thong'
-- 	),
-- 	(
-- 		'Coffee Corner',
-- 		'coffee.jpg',
-- 		'Cafe va banh ngot'
-- 	),
-- 	(
-- 		'Seafood Restaurant',
-- 		'seafood.jpg',
-- 		'Hai san tuoi song'
-- 	)

-- -- insert foodType
-- INSERT INTO "foodType" ("typeName") VALUES
-- 	('Mon chinh'),
-- 	('Do an nhanh'),
-- 	('Do uong')

-- -- insert food
-- INSERT INTO "food" ("foodName", "image", "price", "desc", "typeId") VALUES
-- 	-- Type 1: Mon chinh
-- 	(
-- 		'Pho Bo',
-- 		'pho_bo.jpg',
-- 		50000,
-- 		'Pho bo truyen thong',
-- 		1
-- 	),
-- 	(
-- 		'Com Tam',
-- 		'com_tam.jpg',
-- 		45000,
-- 		'Com tam suon nuong',
-- 		1
-- 	),
-- 	(
-- 		'Bun Bo Hue',
-- 		'bun_bo.jpg',
-- 		55000,
-- 		'Bun bo Hue cay',
-- 		1
-- 	),
-- 	(
-- 		'Mi Xao',
-- 		'mi_xao.jpg',
-- 		40000,
-- 		'Mi xao thap cam',
-- 		1
-- 	),
-- 	(
-- 		'Banh Mi',
-- 		'banh_mi.jpg',
-- 		25000,
-- 		'Banh mi Viet Nam',
-- 		1
-- 	),
-- 	-- Type 2: Do an nhanh
-- 	(
-- 		'Burger Bo',
-- 		'burger.jpg',
-- 		60000,
-- 		'Burger bo phomai',
-- 		2
-- 	),
-- 	('Pizza', 'pizza.jpg', 120000, 'Pizza hai san', 2),
-- 	('Ga Ran', 'ga_ran.jpg', 45000, 'Ga ran gion', 2),
-- 	(
-- 		'Khoai Tay Chien',
-- 		'fries.jpg',
-- 		30000,
-- 		'Khoai tay chien',
-- 		2
-- 	),
-- 	(
-- 		'Hot Dog',
-- 		'hotdog.jpg',
-- 		35000,
-- 		'Hot dog xuc xich',
-- 		2
-- 	),
-- 	-- Type 3: Do uong
-- 	(
-- 		'Tra Sua',
-- 		'trasua.jpg',
-- 		35000,
-- 		'Tra sua truyen thong',
-- 		3
-- 	),
-- 	(
-- 		'Ca Phe Sua',
-- 		'coffee.jpg',
-- 		30000,
-- 		'Ca phe sua da',
-- 		3
-- 	),
-- 	(
-- 		'Nuoc Cam',
-- 		'orange.jpg',
-- 		25000,
-- 		'Nuoc cam tuoi',
-- 		3
-- 	),
-- 	(
-- 		'Tra Dao',
-- 		'tradao.jpg',
-- 		35000,
-- 		'Tra dao cam sa',
-- 		3
-- 	),
-- 	(
-- 		'Sinh To',
-- 		'smoothie.jpg',
-- 		40000,
-- 		'Sinh to trai cay',
-- 		3
-- 	)

-- -- insert subFood
-- INSERT INTO "subFood" ("subName", "subPrice", "foodId") VALUES
-- 	-- Food ID 1: Pho Bo
-- 	('Them tai', 10000, 1),
-- 	('Them bo', 20000, 1),
-- 	('Them trung', 10000, 1),
-- 	-- Food ID 2: Com Tam
-- 	('Them suon', 25000, 2),
-- 	('Them bi', 10000, 2),
-- 	('Them cha', 15000, 2),
-- 	-- Food ID 3: Bun Bo Hue
-- 	('Them bo', 20000, 3),
-- 	('Them cha', 15000, 3),
-- 	('Them huyet', 10000, 3),
-- 	-- Food ID 4: Mi Xao
-- 	('Them mi', 10000, 4),
-- 	('Them bo', 20000, 4),
-- 	('Them rau', 5000, 4),
-- 	-- Food ID 5: Banh Mi
-- 	('Them pate', 10000, 5),
-- 	('Them trung', 10000, 5),
-- 	('Them thit', 15000, 5),
-- 	-- Food ID 6: Burger Bo
-- 	('Them phomai', 15000, 6),
-- 	('Them thit bo', 25000, 6),
-- 	('Them bacon', 20000, 6),
-- 	-- Food ID 7: Pizza
-- 	('Them phomai', 20000, 7),
-- 	('Them xuc xich', 25000, 7),
-- 	('Them topping', 30000, 7),
-- 	-- Food ID 8: Ga Ran
-- 	('Them dui ga', 30000, 8),
-- 	('Them canh ga', 25000, 8),
-- 	('Them sot', 10000, 8),
-- 	-- Food ID 9: Khoai Tay Chien
-- 	('Them phomai', 15000, 9),
-- 	('Them size lon', 20000, 9),
-- 	('Them sot', 10000, 9),
-- 	-- Food ID 10: Hot Dog
-- 	('Them xuc xich', 15000, 10),
-- 	('Them phomai', 10000, 10),
-- 	('Them bacon', 20000, 10),
-- 	-- Food ID 11: Tra Sua
-- 	('Them tran chau', 10000, 11),
-- 	('Them pudding', 10000, 11),
-- 	('Them thach', 10000, 11),
-- 	-- Food ID 12: Ca Phe Sua
-- 	('Them shot espresso', 10000, 12),
-- 	('Them sua', 5000, 12),
-- 	('Them kem', 10000, 12),
-- 	-- Food ID 13: Nuoc Cam
-- 	('Them cam', 10000, 13),
-- 	('Them duong', 5000, 13),
-- 	('Them da', 0, 13),
-- 	-- Food ID 14: Tra Dao
-- 	('Them dao', 10000, 14),
-- 	('Them tran chau', 10000, 14),
-- 	('Them thach', 10000, 14),
-- 	-- Food ID 15: Sinh To
-- 	('Them sua', 10000, 15),
-- 	('Them chuoi', 10000, 15),
-- 	('Them kem', 10000, 15)

-- -- insert order
-- INSERT INTO "order" ("userId", "foodId", "amount", "code", "arrSubId") VALUES
-- (1, 1, 2, 'ORD001', '1,2'),
-- (2, 2, 1, 'ORD002', '4'),
-- (3, 3, 1, 'ORD003', '7'),
-- (4, 4, 2, 'ORD004', '10,11'),
-- (5, 5, 1, 'ORD005', '13'),
-- (6, 6, 1, 'ORD006', '16'),
-- (7, 7, 2, 'ORD007', '19,20'),
-- (1, 8, 1, 'ORD008', '22'),
-- (2, 9, 2, 'ORD009', '25,26'),
-- (3, 10, 1, 'ORD010', '28'),
-- (4, 11, 2, 'ORD011', '31,32'),
-- (5, 12, 1, 'ORD012', '34'),
-- (5, 6, 1, 'ORD0013', '28')

-- -- insert rate
-- INSERT INTO "rate" ("userId", "resId", "amount", "dateRate") VALUES
-- (1, 1, 5, '2026-11-01 10:00:00'),
-- (2, 2, 4, '2026-11-02 11:00:00'),
-- (3, 3, 5, '2026-11-03 12:00:00'),
-- (4, 4, 3, '2026-11-04 13:00:00'),
-- (5, 5, 4, '2026-11-05 14:00:00'),
-- (6, 6, 5, '2026-11-06 15:00:00'),
-- (7, 7, 4, '2026-11-07 16:00:00'),
-- (1, 8, 5, '2026-11-08 17:00:00')

-- -- insert like
-- INSERT INTO "like" ("userId", "resId", "dateLike") VALUES
-- (1, 1, '2026-11-01 10:00:00'),
-- (2, 2, '2026-11-02 11:00:00'),
-- (3, 3, '2026-11-03 12:00:00'),
-- (4, 4, '2026-11-04 13:00:00'),
-- (5, 5, '2026-11-05 14:00:00'),
-- (6, 6, '2026-11-06 15:00:00'),
-- (7, 7, '2026-11-07 16:00:00'),
-- (1, 8, '2026-11-08 17:00:00'),
-- (2, 9, '2026-11-09 18:00:00'),
-- (3, 5, '2026-11-10 09:15:00'),
-- (4, 2, '2026-11-10 10:30:00'),
-- (5, 8, '2026-11-10 14:20:00'),
-- (6, 3, '2026-11-11 08:45:00'),
-- (7, 1, '2026-11-11 11:10:00'),
-- (8, 4, '2026-11-11 13:25:00'),
-- (9, 6, '2026-11-11 15:40:00'),
-- (10, 7, '2026-11-12 09:00:00'),
-- (3, 9, '2026-11-12 10:15:00'),
-- (4, 10, '2026-11-12 12:30:00'),
-- (5, 1, '2026-11-12 14:45:00'),
-- (6, 5, '2026-11-13 08:20:00'),
-- (7, 8, '2026-11-13 11:35:00'),
-- (8, 2, '2026-11-13 16:10:00'),
-- (9, 3, '2026-11-13 18:25:00'),
-- (1, 3, '2026-11-14 08:15:00'),
-- (1, 5, '2026-11-14 09:20:00'),
-- (1, 6, '2026-11-14 10:30:00'),
-- (1, 9, '2026-11-14 11:45:00'),
-- (2, 1, '2026-11-14 12:10:00'),
-- (2, 4, '2026-11-14 13:25:00'),
-- (2, 6, '2026-11-14 14:40:00'),
-- (2, 8, '2026-11-14 15:55:00'),
-- (3, 1, '2026-11-14 16:20:00'),
-- (3, 2, '2026-11-14 17:35:00'),
-- (3, 4, '2026-11-14 18:50:00'),
-- (3, 7, '2026-11-14 19:05:00'),
-- (4, 3, '2026-11-15 08:10:00'),
-- (4, 5, '2026-11-15 09:25:00'),
-- (4, 7, '2026-11-15 10:40:00'),
-- (4, 9, '2026-11-15 11:55:00'),
-- (5, 2, '2026-11-15 12:15:00'),
-- (5, 3, '2026-11-15 13:30:00'),
-- (5, 6, '2026-11-15 14:45:00'),
-- (5, 10, '2026-11-15 15:50:00'),
-- (6, 1, '2026-11-15 16:05:00'),
-- (6, 4, '2026-11-15 17:20:00'),
-- (6, 7, '2026-11-15 18:35:00'),
-- (6, 9, '2026-11-15 19:40:00'),
-- (7, 2, '2026-11-16 08:15:00'),
-- (7, 3, '2026-11-16 09:30:00'),
-- (7, 5, '2026-11-16 10:45:00'),
-- (7, 10, '2026-11-16 11:50:00'),
-- (8, 1, '2026-11-16 12:05:00'),
-- (8, 6, '2026-11-16 13:20:00'),
-- (8, 7, '2026-11-16 14:35:00'),
-- (8, 9, '2026-11-16 15:40:00'),
-- (9, 2, '2026-11-16 16:15:00'),
-- (9, 4, '2026-11-16 17:30:00'),
-- (9, 5, '2026-11-16 18:45:00'),
-- (9, 8, '2026-11-16 19:50:00'),
-- (10, 1, '2026-11-17 08:20:00'),
-- (10, 3, '2026-11-17 09:35:00'),
-- (10, 5, '2026-11-17 10:50:00'),
-- (10, 6, '2026-11-17 11:55:00'),
-- (1, 2, '2026-11-17 12:15:00'),
-- (2, 3, '2026-11-17 13:30:00'),
-- (3, 6, '2026-11-17 14:45:00'),
-- (4, 8, '2026-11-17 15:50:00'),
-- (5, 7, '2026-11-17 16:05:00'),
-- (6, 10, '2026-11-17 17:20:00'),
-- (7, 4, '2026-11-17 18:35:00'),
-- (8, 5, '2026-11-17 19:40:00'),
-- (9, 1, '2026-11-18 08:15:00'),
-- (10, 2, '2026-11-18 09:30:00')
