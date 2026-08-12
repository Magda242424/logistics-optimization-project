SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = 'shipments'
ORDER BY indexname;

SELECT 'cities' AS table_name, COUNT(*) AS rows_count
FROM cities
UNION ALL
SELECT 'clients', COUNT(*)
FROM clients
UNION ALL
SELECT 'products', COUNT(*)
FROM products
UNION ALL
SELECT 'warehouses', COUNT(*)
FROM warehouses
UNION ALL
SELECT 'shipments', COUNT(*)
FROM shipments;

SELECT COUNT(*) AS cities_count
FROM cities;

SELECT *
FROM cities
ORDER BY city_id;

SELECT COUNT(*) AS clients_count
FROM clients;

SELECT *
FROM clients
ORDER BY client_id;

SELECT COUNT(*) AS products_count
FROM products;

SELECT *
FROM products
ORDER BY product_id;

SELECT COUNT(*) AS warehouses_count
FROM warehouses;

SELECT *
FROM warehouses;

SELECT COUNT(*) AS shipments_count
FROM shipments;

SELECT *
FROM shipments;
