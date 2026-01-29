-- non parametrized

DELIMITER $$
CREATE PROCEDURE get_products_warehouses_report()
BEGIN
    SELECT 
        p.product_id,
        p.name AS product_name,
        w.warehouse_id,
        w.name AS warehouse_name,
        wp.quantity
    FROM 
        product p
    JOIN 
        warehouse_product wp ON p.product_id = wp.product_id
    JOIN 
        warehouse w ON wp.warehouse_id = w.warehouse_id;
END$$
DELIMITER ;

-- parametrised

DELIMITER $$
CREATE PROCEDURE get_products_warehouses_report()
BEGIN
    SELECT 
        p.product_id,
        p.name AS product_name,
        w.warehouse_id,
        w.name AS warehouse_name,
        wp.quantity
    FROM 
        product p
    JOIN 
        warehouse_product wp ON p.product_id = wp.product_id
    JOIN 
        warehouse w ON wp.warehouse_id = w.warehouse_id;
END$$
DELIMITER ;