-- Enums
CREATE TYPE "price_range" AS ENUM ('low', 'medium', 'high');
CREATE TYPE "cafe_style" AS ENUM ('modern', 'traditional', 'vintage', 'outdoor', 'workspace');
CREATE TYPE "drink_type" AS ENUM ('coffee', 'tea', 'smoothie', 'juice', 'other');

-- Table cafes
CREATE TABLE "cafes" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL,
    "address" TEXT NOT NULL,
    "imageUrls" TEXT[], -- camelCase column name
    "priceRange" "price_range" NOT NULL,
    "style" "cafe_style" NOT NULL,
    "googleRating" DECIMAL(2,1) CHECK ("googleRating" >= 0 AND "googleRating" <= 5),
    "openingTime" TIME NOT NULL,
    "closingTime" TIME NOT NULL,
    "distanceFromSun" DECIMAL(5,2) NOT NULL,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for cafes
CREATE INDEX "idx_distanceFromSun" ON "cafes" ("distanceFromSun");
CREATE INDEX "idx_priceRange" ON "cafes" ("priceRange");