# Chapter 3
# Lesson 9: Install MySQL & Database

CREATE SCHEMA `mydatabase` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
-- Character Sets and Collations in MySQL: https://dev.mysql.com/doc/refman/8.0/en/charset-mysql.html
-- NOTE: there is a difference between ` vs. ' (or ") in MySQL
-- `` for enclosing identifiers such as table and column names
-- '' for enclosing string literals
-- "" By default the " character can be used to enclose string literals just like '

-- Delete database
DROP DATABASE `mydatabase`;

## Sakila Database Install
-- database download: https://dev.mysql.com/doc/index-other.html
-- File > Open SQL Script > ...sakila-schema.sql
-- File > Open SQL Script > ...sakila-data.sql

USE sakila;
SELECT * FROM city LIMIT 100;
SELECT
	F.title AS FiltTitle,
    CONCAT(A.first_name, " ", A.last_name) AS ActorName
FROM film F
LEFT JOIN film_actor FA
ON F.film_id = FA.film_id
LEFT JOIN actor A
ON A.actor_id = FA.actor_id
LIMIT 100;