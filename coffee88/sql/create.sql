
CREATE TYPE price_range AS ENUM ('low', 'medium', 'high');
CREATE TYPE cafe_style AS ENUM ('modern', 'traditional', 'vintage', 'outdoor', 'workspace');
CREATE TYPE drink_type AS ENUM ('coffee', 'tea', 'smoothie', 'juice', 'cocktail');

CREATE TABLE cafes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
	image_urls TEXT[],
    price_range price_range NOT NULL,
    style cafe_style NOT NULL,
    google_rating DECIMAL(2, 1),
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL,
	distance_from_sun DECIMAL(5, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    
);


CREATE TABLE drinks (
    id SERIAL PRIMARY KEY,
    cafe_id INTEGER NOT NULL REFERENCES cafes(id) ON DELETE CASCADE, 
    name VARCHAR(100) NOT NULL, 
    type drink_type NOT NULL,
    price DECIMAL(10, 2) NOT NULL, 
    description TEXT,  
    image_url TEXT, 
	is_available BOOLEAN default true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_timestamp
BEFORE UPDATE ON cafes
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();