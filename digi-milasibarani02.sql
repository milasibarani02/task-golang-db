CREATE TABLE public.auths (
	auth_id int8 GENERATED ALWAYS AS IDENTITY NOT NULL,
	username varchar NOT NULL,
	"password" varchar NOT NULL,
	CONSTRAINT auths_pk null,
	CONSTRAINT auths_unique UNIQUE (username)
);

CREATE TABLE public.accounts (
	account_id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"name" varchar NOT NULL,
	balance int8 DEFAULT 0 NOT NULL,
	referral_account_id int8 NULL,
	CONSTRAINT account_pk PRIMARY KEY (account_id),
	CONSTRAINT fk_account FOREIGN KEY (referral_account_id) REFERENCES public.accounts(account_id)
);

CREATE TABLE public.transaction_categories (
	transaction_category_id int4 GENERATED ALWAYS AS IDENTITY NOT NULL,
	"name" varchar NULL,
	CONSTRAINT transaction_categories_pk PRIMARY KEY (transaction_category_id)
);


CREATE TABLE public."transaction" (
	transaction_id int8 GENERATED ALWAYS AS IDENTITY NOT NULL,
	transaction_category_id int8 NULL,
	account_id int8 NOT NULL,
	from_account_id int8 NULL,
	to_account_id int8 NULL,
	amount int8 NULL,
	transaction_date timestamp NULL,
	CONSTRAINT transaction_pk PRIMARY KEY (transaction_id)
);



ALTER TABLE public."transaction" ADD CONSTRAINT transaction_category_id FOREIGN KEY (transaction_category_id) REFERENCES public.transaction_categories(transaction_category_id);

INSERT INTO public.accounts ("name",balance,referral_account_id) VALUES
	 ('Nia',300000,NULL),
	 ('Indah',400000,NULL),
	 ('Sibarani',500000,NULL),
	 ('Mila',100000,NULL),
	 ('Mile',7000000,NULL);
	
INSERT INTO public.transaction_categories ("name") VALUES
	 ('Minuman'),
	 ('Makanan');

INSERT INTO public."transaction" (transaction_category_id,account_id,from_account_id,to_account_id,amount,transaction_date) VALUES
	 (1,1,2,3,10000,'2023-01-01 00:00:01'),
	 (2,4,4,2,100000,'2023-02-26 11:10:23'),
	 (1,1,3,4,50000,'2023-03-25 12:00:00'),
	 (2,4,3,4,10000,'2023-04-15 16:52:13'),
	 (1,1,5,1,75000,'2023-05-27 17:56:20'),
	 (2,4,4,2,31000,'2024-06-26 01:02:40'),
	 (1,1,1,2,43000,'2024-07-14 21:49:00'),
	 (1,4,4,1,56000,'2024-08-17 13:36:11'),
	 (2,1,2,5,7000,'2023-09-02 22:35:09'),
	 (1,4,5,3,231400,'2023-10-22 20:58:00'),
	 (2,1,2,3,34500,'2023-11-05 14:43:26'),
	 (1,4,5,1,96700,'2024-12-31 23:59:59');


UPDATE accounts
SET name = 'Mila Sibarani'
WHERE account_id = '1';

UPDATE accounts
SET balance = '1000000'
WHERE account_id = '2';

SELECT * FROM accounts;

SELECT transaction.*, accounts.name
FROM transaction
JOIN accounts ON transaction.account_id = accounts.account_id;

SELECT * FROM accounts
ORDER BY balance DESC
LIMIT 1;

SELECT * FROM transaction
WHERE EXTRACT(MONTH FROM transaction_date) = 5;
