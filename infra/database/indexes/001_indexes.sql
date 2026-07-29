CREATE INDEX idx_hotel_city_created
ON hotel_bookings(city, created_at);

CREATE INDEX idx_hotel_org_status
ON hotel_bookings(org_id, status);