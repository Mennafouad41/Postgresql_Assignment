CREATE TABLE countries (
    code integer Primary Key NOT NULL,
    name character varying NOT NULL,
    continent_name character varying NOT NULL
);
INSERT INTO countries(
	code, name, continent_name)
	VALUES (1, 'Egypt', 'African');
CREATE TABLE users (
    id integer Primary Key NOT NULL,
    full_name character varying NOT NULL,
    email character varying NOT NULL,
    gender character varying NOT NULL,
    date_of_birth character varying NOT NULL,
    country_code integer NOT NULL REFERENCES countries(code),
    created_at character varying NOT NULL);
INSERT INTO users(
	id, full_name, email,gender,date_of_birth,country_code,created_at)
	VALUES (1, 'Menna', 'menna@gmail.com','female','4/1/1999',1,'march');
INSERT INTO users(
	id, full_name,email,gender,date_of_birth,country_code,created_at)
	VALUES (2, 'Aya', 'aya.gmail.com','female','9/1/1999',1,'may');
CREATE TABLE orders (
    id integer NOT NULL Primary Key,
    status character varying NOT NULL,
    created_at character varying NOT NULL,
    user_id integer NOT NULL REFERENCES users(id) 
);
INSERT INTO orders(
	id, status, created_at,user_id)
	VALUES (1, 'true', 'march',1);
INSERT INTO orders(
	id, status, created_at,user_id)
	VALUES (2, 'true', 'may',2);
CREATE TABLE merchants (
    id integer NOT NULL Primary Key,
    merchant_name character varying NOT NULL,
    admin_id integer NOT NULL REFERENCES users(id),
    country_code integer NOT NULL REFERENCES countries(code),
    created_at character varying NOT NULL
);
INSERT INTO merchants(
	id, merchant_name, admin_id,country_code,created_at)
	VALUES (1, 'Soper', 1,1,'march');
INSERT INTO merchants(
	id, merchant_name, admin_id,country_code,created_at)
	VALUES (2, 'Soper', 1,1,'may');
CREATE TABLE products (
    id integer Primary Key NOT NULL,
    merchant_id integer NOT NULL REFERENCES merchants(id),
    name character varying NOT NULL,
    price integer NOT NULL,
    status character varying NOT NULL,
    created_at character varying NOT NULL
);
INSERT INTO products(
	id, merchant_id, name,price,status,created_at)
	VALUES (1, 1, 'rise',10,'true','march');
INSERT INTO products(
	id, merchant_id, name,price,status,created_at)
	VALUES (2, 1, 'cheese',10,'true','march');
CREATE TABLE order_items (
    product_id integer NOT NULL REFERENCES products(id),
    quantity integer NOT NULL,
    order_id integer NOT NULL REFERENCES orders(id)
);
INSERT INTO order_items(
	product_id, quantity, order_id )
	VALUES (1, 3,1);
INSERT INTO order_items(
	product_id, quantity, order_id )
	VALUES (2, 3,1);
INSERT INTO order_items(
	product_id, quantity, order_id )
	VALUES (1, 5,2);
INSERT INTO order_items(
	product_id, quantity, order_id )
	VALUES (2, 5,2);
  
select full_name as user_name,orders.id as order_id,sum(order_items.quantity * products.price)as total_price
from users,orders,order_items,products
where users.id=orders.user_id
and order_items.order_id=orders.id
and order_items.product_id=products.id
GROUP BY full_name,orders.id 