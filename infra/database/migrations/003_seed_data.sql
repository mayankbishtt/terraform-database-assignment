INSERT INTO hotel_bookings (
    id,
    org_id,
    hotel_id,
    city,
    checkin_date,
    checkout_date,
    amount,
    status,
    created_at
)

SELECT

gen_random_uuid(),

CASE
    WHEN gs % 5 = 0 THEN '11111111-1111-1111-1111-111111111111'::uuid
    WHEN gs % 5 = 1 THEN '22222222-2222-2222-2222-222222222222'::uuid
    WHEN gs % 5 = 2 THEN '33333333-3333-3333-3333-333333333333'::uuid
    WHEN gs % 5 = 3 THEN '44444444-4444-4444-4444-444444444444'::uuid
    ELSE '55555555-5555-5555-5555-555555555555'::uuid
END,

'HOTEL-' || (gs % 10 + 1),

CASE
    WHEN gs % 5 = 0 THEN 'delhi'
    WHEN gs % 5 = 1 THEN 'mumbai'
    WHEN gs % 5 = 2 THEN 'bangalore'
    WHEN gs % 5 = 3 THEN 'noida'
    ELSE 'pune'
END,

CURRENT_DATE + (gs % 10),

CURRENT_DATE + (gs % 10) + 2,

1000 + (random() * 9000)::numeric(12,2),

CASE
    WHEN gs % 4 = 0 THEN 'BOOKED'
    WHEN gs % 4 = 1 THEN 'COMPLETED'
    WHEN gs % 4 = 2 THEN 'CANCELLED'
    ELSE 'PENDING'
END,

NOW() - (random() * interval '30 days')

FROM generate_series(1,100) gs;

INSERT INTO booking_events (

booking_id,

event_type,

payload,

created_at

)

SELECT

id,

CASE

WHEN random() < 0.5 THEN 'BOOKING_CREATED'

ELSE 'PAYMENT_COMPLETED'

END,

jsonb_build_object(

'message',

'Auto Generated Event'

),

created_at

FROM hotel_bookings

LIMIT 50;