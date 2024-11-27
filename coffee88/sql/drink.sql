DROP TYPE IF EXISTS drinks_type_enum;
DROP INDEX IF EXISTS idx_cafe_id;
DROP INDEX IF EXISTS idx_type;
DROP TABLE IF EXISTS drinks CASCADE;

-- Table drinks
CREATE TABLE "drinks" (
    "id" SERIAL PRIMARY KEY,
    "cafeId" INTEGER NOT NULL REFERENCES "cafes"("id") ON DELETE CASCADE,
    "name" VARCHAR(100) NOT NULL,
    "type" "drink_type" NOT NULL,
    "price" DECIMAL(10,2) NOT NULL CHECK ("price" > 0),
    "description" TEXT,
    "imageUrl" TEXT,
    "isAvailable" BOOLEAN DEFAULT TRUE,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for drinks
CREATE INDEX idx_cafe_id ON drinks("cafeId");
CREATE INDEX idx_type ON drinks("type");