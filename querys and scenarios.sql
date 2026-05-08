
-- Q1: All movies with their genre ──────────────────────────
SELECT m.movie_id, m.title, g.genre_name, m.language,
       m.duration_min, m.rating, m.release_date
FROM movies m
JOIN genres g ON m.genre_id = g.genre_id
ORDER BY m.rating DESC;

-- ── Q2: All shows for a specific movie ───────────────────────
SELECT s.show_id, m.title, t.name AS theater, sc.screen_name,
       s.show_date, s.show_time, s.ticket_price
FROM shows s
JOIN movies   m  ON s.movie_id    = m.movie_id
JOIN screens  sc ON s.screen_id   = sc.screen_id
JOIN theaters t  ON sc.theater_id = t.theater_id
WHERE m.title = 'Galactic War';

-- ── Q3: All confirmed bookings with customer & movie details ─
SELECT b.booking_id, c.full_name, m.title AS movie,
       sh.show_date, sh.show_time, b.total_amount, b.status
FROM bookings b
JOIN customers c  ON b.customer_id = c.customer_id
JOIN shows     sh ON b.show_id     = sh.show_id
JOIN movies    m  ON sh.movie_id   = m.movie_id
WHERE b.status = 'Confirmed'
ORDER BY b.booked_on;

-- ── Q4: Total revenue from successful payments ───────────────
SELECT SUM(paid_amount) AS total_revenue
FROM payments
WHERE payment_status = 'Success';

-- ── Q5: Revenue earned per movie ─────────────────────────────
SELECT m.title, SUM(p.paid_amount) AS revenue
FROM payments p
JOIN bookings b ON p.booking_id = b.booking_id
JOIN shows    s ON b.show_id    = s.show_id
JOIN movies   m ON s.movie_id   = m.movie_id
WHERE p.payment_status = 'Success'
GROUP BY m.title
ORDER BY revenue DESC;

-- ── Q6: Seats booked per booking ─────────────────────────────
SELECT b.booking_id, c.full_name, m.title,
       GROUP_CONCAT(CONCAT(se.row_label, se.seat_number)
                    ORDER BY se.row_label, se.seat_number) AS seats
FROM booking_seats bs
JOIN bookings  b  ON bs.booking_id = b.booking_id
JOIN customers c  ON b.customer_id = c.customer_id
JOIN shows     sh ON b.show_id     = sh.show_id
JOIN movies    m  ON sh.movie_id   = m.movie_id
JOIN seats     se ON bs.seat_id    = se.seat_id
GROUP BY b.booking_id, c.full_name, m.title;

-- ── Q7: Booking count and total spend per customer ───────────
SELECT c.customer_id, c.full_name,
       COUNT(b.booking_id) AS total_bookings,
       SUM(b.total_amount) AS total_spent
FROM customers c
LEFT JOIN bookings b ON c.customer_id = b.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_bookings DESC;

-- ── Q8: Most popular movies by booking count ─────────────────
SELECT m.title, COUNT(b.booking_id) AS bookings_count
FROM movies m
JOIN shows    s ON m.movie_id = s.movie_id
JOIN bookings b ON s.show_id  = b.show_id
GROUP BY m.title
ORDER BY bookings_count DESC;

-- ── Q9: Cancelled bookings with refund status ────────────────
SELECT b.booking_id, c.full_name, m.title,
       b.total_amount, p.payment_status, p.transaction_ref
FROM bookings b
JOIN customers c  ON b.customer_id = c.customer_id
JOIN shows     s  ON b.show_id     = s.show_id
JOIN movies    m  ON s.movie_id    = m.movie_id
LEFT JOIN payments p ON p.booking_id = b.booking_id
WHERE b.status = 'Cancelled';

-- ── Q10: Payment method transaction breakdown ────────────────
SELECT payment_method,
       COUNT(*)         AS total_transactions,
       SUM(paid_amount) AS total_amount_paid
FROM payments
WHERE payment_status = 'Success'
GROUP BY payment_method
ORDER BY total_amount_paid DESC;

-- ── Q11: Available seats for a specific show (show_id = 1) ───
SELECT se.seat_id, se.row_label, se.seat_number, se.seat_type
FROM seats se
WHERE se.screen_id = (SELECT screen_id FROM shows WHERE show_id = 1)
  AND se.seat_id NOT IN (
      SELECT bs.seat_id
      FROM booking_seats bs
      JOIN bookings b ON bs.booking_id = b.booking_id
      WHERE b.show_id = 1 AND b.status != 'Cancelled'
  );

-- ── Q12: Theaters with screen and seat summary ───────────────
SELECT t.name AS theater, t.city, t.state,
       COUNT(sc.screen_id) AS screens,
       SUM(sc.total_seats) AS total_seats
FROM theaters t
JOIN screens sc ON t.theater_id = sc.theater_id
GROUP BY t.theater_id, t.name, t.city, t.state
ORDER BY total_seats DESC;

-- ── Q13: Movies with rating above average ────────────────────
SELECT title, language, rating
FROM movies
WHERE rating > (SELECT AVG(rating) FROM movies)
ORDER BY rating DESC;

-- ── Q14: Daily booking revenue report ────────────────────────
SELECT DATE(b.booked_on)    AS booking_date,
       COUNT(b.booking_id)  AS total_bookings,
       SUM(p.paid_amount)   AS daily_revenue
FROM bookings b
JOIN payments p ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Success'
GROUP BY DATE(b.booked_on)
ORDER BY booking_date;

-- ── Q15: Customers who have never booked ─────────────────────
SELECT c.customer_id, c.full_name, c.email
FROM customers c
LEFT JOIN bookings b ON c.customer_id = b.customer_id
WHERE b.booking_id IS NULL;

-- ── Q16: Shows from today onwards (upcoming) ─────────────────
SELECT s.show_id, m.title, t.name AS theater,
       s.show_date, s.show_time, s.ticket_price
FROM shows s
JOIN movies   m  ON s.movie_id    = m.movie_id
JOIN screens  sc ON s.screen_id   = sc.screen_id
JOIN theaters t  ON sc.theater_id = t.theater_id
WHERE s.show_date >= CURDATE()
ORDER BY s.show_date, s.show_time;

-- ── Q17: Seat-type distribution ───────────────────────────────
SELECT seat_type, COUNT(*) AS total_seats
FROM seats
GROUP BY seat_type;

-- ── Q18: Top 10 highest spending customers ────────────────────
SELECT c.full_name, c.email,
       COUNT(b.booking_id) AS bookings,
       SUM(p.paid_amount)  AS total_spent
FROM customers c
JOIN bookings  b ON c.customer_id = b.customer_id
JOIN payments  p ON b.booking_id  = p.booking_id
WHERE p.payment_status = 'Success'
GROUP BY c.customer_id, c.full_name, c.email
ORDER BY total_spent DESC
LIMIT 10;

-- ── Q19: All IMAX shows ───────────────────────────────────────
SELECT m.title, t.name AS theater, sc.screen_name,
       s.show_date, s.show_time, s.ticket_price
FROM shows s
JOIN screens  sc ON s.screen_id    = sc.screen_id
JOIN theaters t  ON sc.theater_id  = t.theater_id
JOIN movies   m  ON s.movie_id     = m.movie_id
WHERE sc.screen_type = 'IMAX';

-- ── Q20: Pending payments older than 1 day ────────────────────
SELECT p.payment_id, c.full_name, m.title,
       b.booked_on, b.total_amount, p.payment_status
FROM payments  p
JOIN bookings  b ON p.booking_id  = b.booking_id
JOIN customers c ON b.customer_id = c.customer_id
JOIN shows     s ON b.show_id     = s.show_id
JOIN movies    m ON s.movie_id    = m.movie_id
WHERE p.payment_status = 'Pending'
  AND b.booked_on < NOW() - INTERVAL 1 DAY;

-- ── Q21: Booking count per show ───────────────────────────────
SELECT s.show_id, m.title, s.show_date, s.show_time,
       COUNT(b.booking_id) AS total_bookings
FROM shows s
JOIN movies m ON s.movie_id = m.movie_id
LEFT JOIN bookings b ON s.show_id = b.show_id AND b.status != 'Cancelled'
GROUP BY s.show_id, m.title, s.show_date, s.show_time
ORDER BY total_bookings DESC;

-- ── Q22: Full master booking summary ─────────────────────────
SELECT b.booking_id,
       c.full_name        AS customer,
       m.title            AS movie,
       t.name             AS theater,
       sc.screen_name,
       sc.screen_type,
       s.show_date,
       s.show_time,
       b.total_amount,
       b.status           AS booking_status,
       p.payment_method,
       p.payment_status,
       p.transaction_ref
FROM bookings  b
JOIN customers c  ON b.customer_id  = c.customer_id
JOIN shows     s  ON b.show_id      = s.show_id
JOIN movies    m  ON s.movie_id     = m.movie_id
JOIN screens   sc ON s.screen_id    = sc.screen_id
JOIN theaters  t  ON sc.theater_id  = t.theater_id
LEFT JOIN payments p ON b.booking_id = p.booking_id
ORDER BY b.booking_id;
