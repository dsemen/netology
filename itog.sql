SELECT ('ФИО: Доценко Семен');
-- запрос 1 выводит 10 самых дорогих изделий белого цвета из таблицы Products
SELECT Product_ID, article_no, price 
FROM Products WHERE color='white' 
ORDER BY price DESC 
LIMIT 10;
-- запрос 2 добавляет в таблицу Products информацию о поставщике
SELECT * FROM Products JOIN Products ON Products.Supplier_ID=Suppliers.Supplier_ID;
продажи товаров за месяц по артикулам
-- запрос 3 выводит 10 поставщиков с самым широким ассортиментом
SELECT Supplier_ID, COUNT(Product_ID) as assortment_range FROM Products
GROUP BY Supplier_ID
ORDER BY assortment_range DESC
LIMIT 10;
-- запрос 4 средние продажи на магазин
SELECT DISTINCT Store_ID, 
AVG(Items_Sold) OVER (PARTITION BY Store_ID) as average_day_sales, FROM Sales
ORDER BY Store_ID;
-- запрос 5 сумма продаж по каждому товарам, где в среднем продается больше 3 штук
SELECT Product_ID, SUM(Items_Sold) as sum_sales
FROM Sales
GROUP BY Product_ID
HAVING AVG(Items_Sold) < 3;
-- запрос 6 продажи изделий красного цвета
WITH tmp_table as (SELECT Product_ID,
    SUM(Items_Sold) as sum_sales 
    FROM Sales GROUP BY Product_ID ORDER BY Product_ID ASC)
    SELECT color, Product_ID FROM Products WHERE color='red' JOIN tmp_table ON Products.Product_ID=tmp_table.Product_ID;
-- запрос 7 создаем новую таблицу с продажами 2017 года
SELECT Product_ID, Date_Id, Items_Sold INTO 2017year_Sales FROM Sales JOIN Time ON Sales.Date_Id=Time.Date_Id WHERE Time.Year_ID=2017;
-- запрос 8 сезонность продаж за 2017 год
SELECT Month_ID, (sum(Items_Sold) OVER (PARTITION BY Month_ID) / (sum(Items_Sold)/12)) as season_factor ORDER BY Month_ID;
-- запрос 9 количество магазинов в каждом городе с разбивкой по брэндам
SELECT City, Store_brand, COUNT(Store_ID) OVER (PARTITION BY Store_brand) FROM Stores;
-- запрос 10 коэффицент присутствия по городам
SELECT City, COUNT(Store_ID) OVER (PARTITION BY City) as store_quantity, 
(COUNT(Store_ID) OVER (PARTITION BY City) / COUNT(Store_ID)/COUNT(City)) as store_deviance FROM Stores ORDER BY store_quantity;
