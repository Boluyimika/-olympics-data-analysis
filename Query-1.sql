1. How many olympics games have been held?

127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history
Your SQL query has been executed successfully.

SELECT COUNT(DISTINCT games)
FROM olympics_history;

52	
2.ist down all Olympics games held so far
127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history

   Showing rows 0 - 24 (52 total, Query took 0.0024 seconds.)


SELECT DISTINCT games,city
FROM `olympics_history`;


games	city	
Games	City	
1992 Summer	Barcelona	
2012 Summer	London	
1920 Summer	Antwerpen	
1900 Summer	Paris	
1988 Winter	Calgary	
1992 Winter	Albertville	
1994 Winter	Lillehammer	
1932 Summer	Los Angeles	
2002 Winter	Salt Lake City	
1952 Summer	Helsinki	
1980 Winter	Lake Placid	
2000 Summer	Sydney	
1996 Summer	Atlanta	
1912 Summer	Stockholm	
1924 Summer	Paris	
2014 Winter	Sochi	
1948 Summer	London	
1998 Winter	Nagano	
2006 Winter	Torino	
2008 Summer	Beijing	
2016 Summer	Rio de Janeiro	
2004 Summer	Athina	
1960 Winter	Squaw Valley	
1964 Winter	Innsbruck	

3.Mention the total no of nations who participated in each olympics game?
127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/sql&db=olympics&table=olympics_history&sql_query=SELECT+COUNT%28region%29%2C+olympics_history.games%0D%0AFROM+%60olympics_history_noc_regions%60+%0D%0AJOIN+olympics_history%0D%0AON+olympics_history.noc%3Dolympics_history_noc_regions.noc%0D%0AGROUP+BY+olympics_history.games%2Cregion++%0AORDER+BY+%60olympics_history%60.%60games%60+DESC&sql_signature=c8a0185ac5dbf8166f8bbeb1df2279648682065e612f1479ccce627b199dc505&session_max_rows=25&is_browse_distinct=0

   Showing rows 0 - 24 (52 total, Query took 0.8287 seconds.) [games: 1896 SUMMER... - 1964 WINTER...]


SELECT COUNT(region) AS Total_country, olympics_history.games
FROM `olympics_history_noc_regions` 
JOIN olympics_history
ON olympics_history.noc=olympics_history_noc_regions.noc
GROUP BY olympics_history.games
ORDER BY `olympics_history`.`games`;


Total_country	games   	
4	1896 Summer	
19	1900 Summer	
14	1904 Summer	
23	1906 Summer	
39	1908 Summer	
116	1912 Summer	
72	1920 Summer	
78	1924 Summer	
12	1924 Winter	
91	1928 Summer	
4	1928 Winter	
30	1932 Summer	
4	1932 Winter	
126	1936 Summer	
4	1936 Winter	
246	1948 Summer	
6	1948 Winter	
165	1952 Summer	
20	1952 Winter	
62	1956 Summer	
14	1956 Winter	
207	1960 Summer	
16	1960 Winter	
170	1964 Summer	
31	1964 Winter	


4.Which year saw the highest and lowest no of countries participating in olympics?

127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=subquery

   Showing rows 0 -  0 (2 total, Query took 0.1858 seconds.)


(SELECT 
    games, 
    COUNT(DISTINCT noc) AS country_count,
    'Highest' AS participation_type
FROM 
    olympics_history
GROUP BY 
    games
ORDER BY 
    country_count DESC
LIMIT 1)

UNION ALL

(SELECT 
    games, 
    COUNT(DISTINCT noc) AS country_count,
    'Lowest' AS participation_type
FROM 
    olympics_history
GROUP BY 
    games
ORDER BY 
    country_count ASC
LIMIT 1);


games	country_count   	participation_type	
2016 Summer	82	Highest	
1896 Summer	1	Lowest	


5.Which nation has participated in all of the olympic games
SELECT region AS country 
FROM `olympics_history_noc_regions` 
JOIN olympics_history 
ON olympics_history.noc = olympics_history_noc_regions.noc 
GROUP BY region 
HAVING COUNT(DISTINCT olympics_history.games) = (SELECT COUNT(DISTINCT games) FROM olympics_history);
No Nation has participated  in every Olympic Games

6.Identify the sport which was played in all summer olympics.
SELECT sport, COUNT(games) AS total_games FROM `olympics_history`
GROUP BY sport 
HAVING COUNT(DISTINCT games) = (SELECT COUNT(DISTINCT games) FROM olympics_history);
No sport has appeared in every Olympic Games

7.Which Sports were just played only once in the olympics?

127.0.0.1/olympics/olympics_history_noc_regions/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history_noc_regions

   Showing rows 0 -  6 (7 total, Query took 0.1154 seconds.)


WITH t1 AS (
    SELECT DISTINCT games, sport 
    FROM olympics_history
),
t2 AS (
    SELECT sport, COUNT(1) AS no_of_games 
    FROM t1 
    GROUP BY sport
)
SELECT 
    t2.sport, 
    t2.no_of_games, 
    t1.games 
FROM 
    t2 
JOIN 
    t1 
ON 
    t1.sport = t2.sport 
WHERE 
    t2.no_of_games = 1 
ORDER BY 
    t1.sport;


sport	no_of_games	games	
Rugby	1	1900 Summer	
Rugby Sevens	1	2016 Summer	
Skeleton	1	2002 Winter	
Snowboarding	1	2006 Winter	
Sport	1	Games	
Trampolining	1	2016 Summer	
Tug-Of-War	1	1900 Summer	

8. Fetch the total no of sports played in each olympic games
127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history

   Showing rows 0 - 24 (52 total, Query took 0.1564 seconds.)


SELECT DISTINCT games,COUNT(sport)AS no_sports
FROM `olympics_history`
GROUP BY games
ORDER BY no_sports DESC;


games	no_sports   	
2016 Summer	485	
2008 Summer	420	
2012 Summer	415	
1988 Summer	388	
1992 Summer	375	
2000 Summer	371	
1996 Summer	368	
1984 Summer	357	
2004 Summer	308	
1948 Summer	246	
1980 Summer	241	
1972 Summer	223	
1960 Summer	207	
1968 Summer	185	
1976 Summer	176	
1964 Summer	170	
1952 Summer	165	
1936 Summer	126	
1912 Summer	116	
1994 Winter	93	
1928 Summer	91	
1992 Winter	82	
1924 Summer	78	
1998 Winter	76	
2002 Winter	73	

9.Fetch details of the oldest athletes to win a gold medal
127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history

   Showing rows 0 -  0 (1 total, Query took 0.0170 seconds.)


SELECT * 
FROM `olympics_history`
WHERE medal = 'gold'
ORDER BY 
    CAST(
        CASE 
            WHEN age = 'NA' THEN '0'
            ELSE age 
        END AS INT
    ) DESC
    LIMIT 1;



1858	Fehaid Al-Deehani	M	49	178	95	Individual Olympic Athletes	IOA	2016 Summer	2016	Summer	Rio de Janeiro	Shooting	Shooting Men's Double Trap	Gold	

10.Find the Ratio of male and female athletes participated in all olympic games

a.created a stored procedure to store GCD
CREATE PROCEDURE GetGCD(IN num1 INT, IN num2 INT, OUT gcd INT) BEGIN DECLARE temp INT; -- Ensure num1 >= num2 IF num1 < num2 THEN SET temp = num1; SET num1 = num2; SET num2 = temp; END IF; -- Calculate GCD using Euclidean algorithm WHILE num2 != 0 DO SET temp = num2; SET num2 = num1 % num2; SET num1 = temp; END WHILE; SET gcd = num1; END;
-- Set the counts of males and females
SET @male_count = (SELECT SUM(CASE WHEN sex = 'M' THEN 1 ELSE 0 END) FROM olympics_history);
SET @female_count = (SELECT SUM(CASE WHEN sex = 'F' THEN 1 ELSE 0 END) FROM olympics_history);

-- Call the GCD stored procedure
CALL GetGCD(@male_count, @female_count, @gcd);

-- Calculate and display the simplified ratio
SELECT CONCAT(
    @male_count DIV @gcd,
    ':',
    @female_count DIV @gcd
) AS simplified_ratio;
   explanation: Computes a simplified ratio by dividing the counts by their GCD.

another approach
WITH t1 AS ( SELECT sex, COUNT(1) AS cnt FROM olympics_history GROUP BY sex ), t2 AS ( SELECT *, ROW_NUMBER() OVER (ORDER BY cnt) AS rn FROM t1 ), min_cnt AS ( SELECT cnt FROM t2 WHERE rn = 1 ), max_cnt AS ( SELECT cnt FROM t2 WHERE rn = 2 ) SELECT CONCAT('1 : ', ROUND(CAST(max_cnt.cnt AS DECIMAL(10, 2)) / CAST(min_cnt.cnt AS DECIMAL(10, 2)), 2)) AS ratio FROM min_cnt, max_cnt;
[ Edit inline ] [ Edit ] [ Create PHP code ]
 Show all	|			Number of rows: 
25
Filter rows: 
Search this table
ratio
1 : 657.00
   explanation:Provides a direct ratio of the maximum to minimum counts, formatted as 1 : X.

11.SQL query to fetch the top 5 athletes who have won the most gold medals.

127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history

   Showing rows 0 -  4 (5 total, Query took 0.0201 seconds.)


SELECT 
    name, 
    team, 
    COUNT(medal) AS gold_medals
FROM 
    olympics_history
WHERE 
    medal = 'gold'
GROUP BY 
    name, 
    team
ORDER BY 
    gold_medals DESC
LIMIT 5;


name	team	gold_medals   	
Nathan Ghar-Jun Adrian	United States	10	
Kjetil Andr Aamodt	Norway	8	
Paavo Johannes Aaltonen	Finland	6	
Meghan Christina Agosta (-Marciano)	Canada	6	
Agostino Abbagnale	Italy	6	

12. Fetch the top 5 athletes who have won the most medals (gold/silver/bronze)
127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history

   Showing rows 0 -  5 (6 total, Query took 0.1284 seconds.)


-- Step 1: Calculate the total number of medals for each athlete
WITH MedalCounts AS (
    SELECT 
        name, 
        team, 
        COUNT(*) AS total_medals
    FROM 
        olympics_history
    WHERE 
        medal IN ('Gold', 'Silver', 'Bronze')
    GROUP BY 
        name, 
        team
),

-- Step 2: Rank athletes based on their total medals
RankedAthletes AS (
    SELECT 
        name, 
        team, 
        total_medals,
        DENSE_RANK() OVER (ORDER BY total_medals DESC) AS rnk
    FROM 
        MedalCounts
)

-- Step 3: Fetch the top 5 athletes with their medal types and counts
SELECT 
    ra.name, 
    ra.team, 
    ra.total_medals,
    m.medal AS medal_type,
    COUNT(m.medal) AS medal_count
FROM 
    RankedAthletes ra
JOIN 
    olympics_history m ON ra.name = m.name AND ra.team = m.team
WHERE 
    ra.rnk <= 5
GROUP BY 
    ra.name, 
    ra.team, 
    ra.total_medals,
    m.medal
ORDER BY 
    ra.total_medals DESC, 
    m[...]

name	team	total_medals	medal_type	medal_count	
Kjetil Andr Aamodt	Norway	16	NA	24	
Nathan Ghar-Jun Adrian	United States	16	Gold	10	
Kjetil Andr Aamodt	Norway	16	Gold	8	
Kjetil Andr Aamodt	Norway	16	Silver	4	
Kjetil Andr Aamodt	Norway	16	Bronze	4	
Nathan Ghar-Jun Adrian	United States	16	Bronze	4	

13. Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history

   Showing rows 0 -  4 (5 total, Query took 0.6404 seconds.)


SELECT region,COUNT(*) AS total_no_medals
FROM `olympics_history` 
INNER JOIN olympics_history_noc_regions
ON olympics_history_noc_regions.noc=olympics_history.noc
GROUP BY
    region
    ORDER BY total_no_medals DESC
    LIMIT 5;


region	total_no_medals   	
Egypt	451	
USA	256	
Sweden	250	
Russia	224	
Kuwait	222	

    Another approach
    127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history

   Showing rows 0 -  4 (5 total, Query took 0.8346 seconds.)


-- Step 1: Create a CTE that joins olympics_history with olympics_history_noc_regions
WITH MedalCounts AS (
    SELECT 
        region, 
        COUNT(*) AS total_no_medals
    FROM 
        olympics_history 
    INNER JOIN 
        olympics_history_noc_regions
    ON 
        olympics_history_noc_regions.noc = olympics_history.noc
    GROUP BY 
        region
)

-- Step 2: Select the top 5 regions with the most medals
SELECT 
    region, 
    total_no_medals
FROM 
    MedalCounts
ORDER BY 
    total_no_medals DESC
LIMIT 5;


region	total_no_medals	
Egypt	451	
USA	256	
Sweden	250	
Russia	224	
Kuwait	222	


14.List down total gold, silver and bronze medals won by each country
127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history

   Showing rows 0 - 24 (149 total, Query took 0.7775 seconds.)


WITH t1 AS
    (SELECT olympics_history_noc_regions.region ,
   SUM(CASE WHEN olympics_history.medal= 'gold' THEN 1 ELSE 0 END)AS GOLD_MEDAL,
   SUM(CASE WHEN olympics_history.medal= 'silver' THEN 1 ELSE 0 END)AS SILVER_MEDAL,
   SUM(CASE WHEN olympics_history.medal= 'bronze' THEN 1 ELSE 0 END)AS BRONZE_MEDAL
FROM `olympics_history`
INNER JOIN olympics_history_noc_regions
ON olympics_history_noc_regions.noc=olympics_history.noc
GROUP BY olympics_history_noc_regions.region)

SELECT 
    region,
    GOLD_MEDAL,
    SILVER_MEDAL,
    BRONZE_MEDAL
FROM 
    t1
ORDER BY 
    GOLD_MEDAL DESC, 
    SILVER_MEDAL DESC, 
    BRONZE_MEDAL DESC;


region	GOLD_MEDAL	SILVER_MEDAL	BRONZE_MEDAL	
USA	47	25	12	
France	23	6	2	
Pakistan	18	7	6	
UK	17	11	11	
Italy	16	13	10	
Norway	16	10	10	
Russia	14	25	33	
Sweden	12	15	18	
Canada	10	1	5	
Spain	7	4	8	
Germany	6	18	9	
Finland	6	6	14	
Netherlands	6	4	4	
New Zealand	6	2	0	
Switzerland	4	10	6	
Hungary	4	6	4	
Japan	4	3	6	
Argentina	4	2	4	
Cuba	4	1	6	
Brazil	2	8	4	
Turkey	2	4	1	
Azerbaijan	2	2	2	
Indonesia	2	2	0	
Bulgaria	2	1	0	
Romania	2	0	6	
Greece	2	0	3	
Ethiopia	2	0	2	
Uzbekistan	2	0	1	
Jordan	2	0	0	
Cameroon	2	0	0	
Belarus	2	0	0	
Denmark	2	0	0	
Nigeria	1	9	2	
Australia	1	1	6	
Individual Olympic Athletes	1	0	1	
Ukraine	1	0	0	
Uganda	1	0	0	
United Arab Emirates	1	0	0	
Poland	0	4	2	
Czech Republic	0	2	0	
Egypt	0	2	0	
Mexico	0	2	0	
Chile	0	2	0	
Tajikistan	0	2	0	
Saudi Arabia	0	1	3	
Austria	0	1	2	
South Africa	0	0	6	
Ghana	0	0	6	
Morocco	0	0	4	
Kuwait	0	0	2	
Iran	0	0	2	
Uruguay	0	0	2	
Lithuania	0	0	2	
Puerto Rico	0	0	2	
Syria	0	0	1	
Qatar	0	0	1	
Ivory Coast	0	0	0	
Oman	0	0	0	
Suriname	0	0	0	
Togo	0	0	0	
El Salvador	0	0	0	
Kyrgyzstan	0	0	0	
Peru	0	0	0	
Belize	0	0	0	
Georgia	0	0	0	
Malaysia	0	0	0	
Republic of Congo	0	0	0	
Yemen	0	0	0	
Honduras	0	0	0	
Monaco	0	0	0	
Croatia	0	0	0	
Iraq	0	0	0	
Nicaragua	0	0	0	
South Korea	0	0	0	
American Samoa	0	0	0	
Dominica	0	0	0	
Palestine	0	0	0	
Bahrain	0	0	0	
Liberia	0	0	0	
Portugal	0	0	0	
Malta	0	0	0	
Rwanda	0	0	0	
China	0	0	0	
India	0	0	0	
Namibia	0	0	0	
Sierra Leone	0	0	0	
Cyprus	0	0	0	
Sudan	0	0	0	
Thailand	0	0	0	
Armenia	0	0	0	
Paraguay	0	0	0	
Belgium	0	0	0	
Luxembourg	0	0	0	
region	0	0	0	
Virgin Islands, US	0	0	0	
Haiti	0	0	0	
Samoa	0	0	0	
Costa Rica	0	0	0	
Algeria	0	0	0	
Djibouti	0	0	0	

Palau	0	0	0	
Tunisia	0	0	0	
Estonia	0	0	0	
Lebanon	0	0	0	
Bermuda	0	0	0	
Mali	0	0	0	
Iceland	0	0	0	
Seychelles	0	0	0	
Curacao	0	0	0	
Israel	0	0	0	
Sri Lanka	0	0	0	
Tanzania	0	0	0	
Ecuador	0	0	0	
Kenya	0	0	0	
Papua New Guinea	0	0	0	
Venezuela	0	0	0	
Guyana	0	0	0	
Mauritius	0	0	0	
Saint Vincent	0	0	0	
Comoros	0	0	0	
Somalia	0	0	0	
Afghanistan	0	0	0	
Jamaica	0	0	0	
Trinidad	0	0	0	
Eritrea	0	0	0	
Latvia	0	0	0	
Philippines	0	0	0	
Benin	0	0	0	
Maldives	0	0	0	
Chad	0	0	0	
Mongolia	0	0	0	
Serbia	0	0	0	
Ireland	0	0	0	
Niger	0	0	0	
Angola	0	0	0	
Dominican Republic	0	0	0	
Kazakhstan	0	0	0	
Panama	0	0	0	
Turkmenistan	0	0	0	
Bangladesh	0	0	0	
Fiji	0	0	0	
Libya	0	0	0	
Brunei	0	0	0	
Guinea	0	0	0	
Mauritania	0	0	0	
Saint Kitts	0	0	0	
Colombia	0	0	0	
Nepal	0	0	0	
Slovenia	0	0	0	
15.List down total gold, silver and bronze medals won by each country corresponding to each olympic games.
WITH t1 AS (SELECT games,olympics_history_noc_regions.region , SUM(CASE WHEN olympics_history.medal= 'gold' THEN 1 ELSE 0 END)AS GOLD_MEDAL, SUM(CASE WHEN olympics_history.medal= 'silver' THEN 1 ELSE 0 END)AS SILVER_MEDAL, SUM(CASE WHEN olympics_history.medal= 'bronze' THEN 1 ELSE 0 END)AS BRONZE_MEDAL FROM `olympics_history` INNER JOIN olympics_history_noc_regions ON olympics_history_noc_regions.noc=olympics_history.noc GROUP BY olympics_history_noc_regions.region,olympics_history.games) SELECT games, region, GOLD_MEDAL, SILVER_MEDAL, BRONZE_MEDAL FROM t1 ORDER BY games DESC, GOLD_MEDAL DESC, SILVER_MEDAL DESC, BRONZE_MEDAL DESC;

16. Identify which country won the most gold, most silver and most bronze medals in each olympic games.

127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history

   Showing rows 0 - 24 (52 total, Query took 0.8451 seconds.)


WITH MedalCounts AS (
    SELECT 
        games,
        olympics_history_noc_regions.region AS country,
        SUM(CASE WHEN olympics_history.medal = 'gold' THEN 1 ELSE 0 END) AS gold_medals,
        SUM(CASE WHEN olympics_history.medal = 'silver' THEN 1 ELSE 0 END) AS silver_medals,
        SUM(CASE WHEN olympics_history.medal = 'bronze' THEN 1 ELSE 0 END) AS bronze_medals
    FROM 
        olympics_history
    INNER JOIN 
        olympics_history_noc_regions
    ON 
        olympics_history.noc = olympics_history_noc_regions.noc
    GROUP BY 
        games, 
        olympics_history_noc_regions.region
),
RankedMedals AS (
    SELECT 
        games,
        country,
        gold_medals,
        silver_medals,
        bronze_medals,
        ROW_NUMBER() OVER (PARTITION BY games ORDER BY gold_medals DESC) AS gold_rank,
        ROW_NUMBER() OVER (PARTITION BY games ORDER BY silver_medals DESC) AS silver_rank,
        ROW_NUMBER() OVER (PARTITION BY games ORDER[...]

games	most_gold_country	most_gold_medals	most_silver_country	most_silver_medals	most_bronze_country	most_bronze_medals	
Games	region	0	region	0	region	0	
2016 Summer	USA	5	Russia	4	USA	8	
2014 Winter	Canada	2	Ukraine	0	Finland	2	
2012 Summer	France	8	Russia	4	UK	4	
2010 Winter	Canada	2	Germany	2	Russia	0	
2008 Summer	France	6	Nigeria	5	Russia	3	
2006 Winter	Canada	4	USA	2	Russia	4	
2004 Summer	France	2	USA	4	Argentina	2	
2002 Winter	Norway	4	Germany	4	Russia	3	
2000 Summer	USA	5	Argentina	2	Brazil	4	
1998 Winter	France	0	Russia	1	France	0	
1996 Summer	USA	5	Nigeria	2	Norway	2	
1994 Winter	Switzerland	2	Switzerland	4	Norway	2	
1992 Winter	Switzerland	2	South Korea	0	Switzerland	2	
1992 Summer	USA	4	Italy	4	Ghana	6	
1988 Winter	Sweden	0	Sweden	0	Switzerland	2	
1988 Summer	Italy	6	Brazil	2	Hungary	2	
1984 Winter	Poland	0	Poland	0	Sweden	2	
1984 Summer	Pakistan	6	Brazil	4	Romania	2	
1980 Winter	Norway	0	Norway	0	Sweden	2	
1980 Summer	Russia	7	UK	2	Russia	4	
1976 Winter	USA	0	USA	0	USA	0	
1976 Summer	Germany	2	Czech Republic	2	Romania	2	
1972 Winter	USA	0	USA	2	USA	0	
1972 Summer	Russia	3	Russia	3	Russia	2	
1968 Winter	Japan	0	Japan	0	Russia	2	
1968 Summer	Pakistan	5	Russia	0	UK	1	
1964 Winter	Italy	0	Italy	0	Italy	0	
1964 Summer	Hungary	2	Germany	6	Russia	2	
1960 Winter	Norway	2	Sweden	0	Sweden	0	
1960 Summer	Pakistan	7	Poland	2	Russia	1	
1956 Winter	Sweden	0	Sweden	0	Sweden	0	
1956 Summer	France	2	Japan	2	South Africa	2	
1952 Winter	Canada	2	France	0	Norway	2	
1952 Summer	USA	2	Sweden	1	Sweden	2	
1948 Winter	France	0	France	0	France	0	
1948 Summer	Finland	6	Italy	2	Finland	2	
1936 Winter	Japan	0	Switzerland	2	Japan	0	
1936 Summer	Germany	2	Canada	1	Sweden	4	
1932 Winter	Japan	0	Japan	0	Japan	0	
1932 Summer	USA	2	Sweden	2	Finland	2	
1928 Winter	Sweden	0	Sweden	2	Sweden	0	
1928 Summer	Italy	2	Sweden	0	Sweden	0	
1924 Winter	USA	0	USA	2	USA	0	
1924 Summer	UK	2	Finland	2	Sweden	0	
1920 Summer	USA	2	Norway	6	Finland	4	
1912 Summer	Sweden	6	Sweden	4	Sweden	2	
1908 Summer	UK	2	Italy	0	Sweden	2	
1906 Summer	Greece	2	Greece	0	Greece	2	
1904 Summer	USA	2	USA	2	USA	0	
1900 Summer	USA	4	Germany	0	Germany	0	
1896 Summer	Greece	0	Greece	0	Greece	0

17. Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.
127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history

   Showing rows 0 - 24 (52 total, Query took 0.8143 seconds.)


WITH MedalCounts AS (
    SELECT 
        games,
        olympics_history_noc_regions.region AS country,
        SUM(CASE WHEN olympics_history.medal = 'gold' THEN 1 ELSE 0 END) AS gold_medals,
        SUM(CASE WHEN olympics_history.medal = 'silver' THEN 1 ELSE 0 END) AS silver_medals,
        SUM(CASE WHEN olympics_history.medal = 'bronze' THEN 1 ELSE 0 END) AS bronze_medals,
        COUNT(olympics_history.medal) AS total_medals
    FROM 
        olympics_history
    INNER JOIN 
        olympics_history_noc_regions
    ON 
        olympics_history.noc = olympics_history_noc_regions.noc
    GROUP BY 
        games, 
        olympics_history_noc_regions.region
),
RankedMedals AS (
    SELECT 
        games,
        country,
        gold_medals,
        silver_medals,
        bronze_medals,
        total_medals,
        ROW_NUMBER() OVER (PARTITION BY games ORDER BY gold_medals DESC) AS gold_rank,
        ROW_NUMBER() OVER (PARTITION BY games ORDER BY silver_me[...]

games	most_gold_country	most_gold_medals	most_silver_country	most_silver_medals	most_bronze_country	most_bronze_medals	most_total_medals_country	most_total_medals	
Games	region	0	region	0	region	0	region	2	
2016 Summer	USA	5	Russia	4	USA	8	Egypt	53	
2014 Winter	Canada	2	Turkey	0	UK	2	Belarus	10	
2012 Summer	France	8	Russia	4	UK	4	Egypt	35	
2010 Winter	Canada	2	Germany	2	Lebanon	0	Russia	8	
2008 Summer	France	6	Nigeria	5	Russia	3	Egypt	47	
2006 Winter	Canada	4	USA	2	Russia	4	Russia	13	
2004 Summer	USA	2	USA	4	Germany	2	Egypt	24	
2002 Winter	Norway	4	Germany	4	Russia	3	Switzerland	12	
2000 Summer	USA	5	Argentina	2	Brazil	4	Egypt	47	
1998 Winter	Czech Republic	0	Russia	1	Czech Republic	0	Switzerland	12	
1996 Summer	USA	5	Azerbaijan	2	Norway	2	Saudi Arabia	26	
1994 Winter	Japan	2	Switzerland	4	Norway	2	USA	16	
1992 Winter	Switzerland	2	Netherlands	0	Switzerland	2	USA	16	
1992 Summer	USA	4	Italy	4	Ghana	6	Egypt	31	
1988 Winter	Virgin Islands, US	0	Virgin Islands, US	0	Switzerland	2	Spain	6	
1988 Summer	Italy	6	Brazil	2	Netherlands	2	Germany	32	
1984 Winter	Poland	0	Poland	0	Sweden	2	Sweden	10	
1984 Summer	Pakistan	6	Brazil	4	Canada	2	Saudi Arabia	39	
1980 Winter	Norway	0	Norway	0	Sweden	2	Sweden	8	
1980 Summer	Russia	7	UK	2	Russia	4	Kuwait	47	
1976 Winter	Sweden	0	Sweden	0	Sweden	0	Japan	5	
1976 Summer	Germany	2	Czech Republic	2	Russia	2	Kuwait	19	
1972 Winter	Sweden	0	USA	2	Sweden	0	Sweden	6	
1972 Summer	Russia	3	Russia	3	Russia	2	Germany	18	
1968 Winter	Russia	0	Russia	0	Russia	2	Russia	8	
1968 Summer	Pakistan	5	Bulgaria	0	UK	1	Mexico	18	
1964 Winter	USA	0	USA	0	USA	0	Iran	6	
1964 Summer	Hungary	2	Germany	6	Japan	2	Ghana	24	
1960 Winter	Norway	2	USA	0	USA	0	Norway	10	
1960 Summer	Pakistan	7	Germany	2	Russia	1	Syria	42	
1956 Winter	Sweden	0	Sweden	0	Sweden	0	France	6	
1956 Summer	France	2	Japan	2	Russia	2	Japan	12	
1952 Winter	Canada	2	Norway	0	Norway	2	France	6	
1952 Summer	USA	2	Sweden	1	Finland	2	Egypt	36	
1948 Winter	UK	0	UK	0	UK	0	UK	2	
1948 Summer	Finland	6	UK	2	Finland	2	Egypt	70	
1936 Winter	Switzerland	0	Switzerland	2	Switzerland	0	Switzerland	2	
1936 Summer	USA	2	Canada	1	Sweden	4	Romania	16	
1932 Winter	Japan	0	Japan	0	Japan	0	Japan	4	
1932 Summer	USA	2	Sweden	2	Italy	2	Belgium	6	
1928 Winter	Sweden	0	Sweden	2	Sweden	0	Sweden	2	
1928 Summer	Italy	2	Belgium	0	Belgium	0	Belgium	14	
1924 Winter	Sweden	0	Sweden	2	Sweden	0	Switzerland	6	
1924 Summer	UK	2	Switzerland	2	Turkey	0	Mexico	10	
1920 Summer	USA	2	Norway	6	Finland	4	Norway	14	
1912 Summer	Sweden	6	Sweden	4	Finland	2	Sweden	33	
1908 Summer	UK	2	USA	0	Sweden	2	UK	12	
1906 Summer	Greece	2	Germany	0	Greece	2	Finland	12	
1904 Summer	USA	2	USA	2	USA	0	USA	14	
1900 Summer	USA	4	USA	0	USA	0	France	9	
1896 Summer	Greece	0	Greece	0	Greece	0	Greece	4	
18.Which countries have never won gold medal but have won silver/bronze medals?
127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history

   Showing rows 0 - 17 (18 total, Query took 0.7058 seconds.)


WITH MedalCounts AS (
    SELECT 
        olympics_history_noc_regions.region AS country,
        SUM(CASE WHEN olympics_history.medal = 'gold' THEN 1 ELSE 0 END) AS gold_medals,
        SUM(CASE WHEN olympics_history.medal = 'silver' THEN 1 ELSE 0 END) AS silver_medals,
        SUM(CASE WHEN olympics_history.medal = 'bronze' THEN 1 ELSE 0 END) AS bronze_medals
    FROM 
        olympics_history
    INNER JOIN 
        olympics_history_noc_regions
    ON 
        olympics_history.noc = olympics_history_noc_regions.noc
    GROUP BY 
        olympics_history_noc_regions.region
)
SELECT 
    country,
    gold_medals,
    silver_medals,
    bronze_medals
FROM 
    MedalCounts
WHERE 
    gold_medals = 0 
    AND (silver_medals > 0 OR bronze_medals > 0);


country	gold_medals	silver_medals	bronze_medals	
Austria	0	1	2	
Chile	0	2	0	
Czech Republic	0	2	0	
Egypt	0	2	0	
Ghana	0	0	6	
Iran	0	0	2	
Kuwait	0	0	2	
Lithuania	0	0	2	
Mexico	0	2	0	
Morocco	0	0	4	
Poland	0	4	2	
Puerto Rico	0	0	2	
Qatar	0	0	1	
Saudi Arabia	0	1	3	
South Africa	0	0	6	
Syria	0	0	1	
Tajikistan	0	2	0	
Uruguay	0	0	2	
19.In which Sport/event, India has won highest medals.
127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history
Your SQL query has been executed successfully.

SELECT 
    sport, 
    COUNT(*) AS total_medals
FROM 
    olympics_history
INNER JOIN 
    olympics_history_noc_regions
ON 
    olympics_history.noc = olympics_history_noc_regions.noc
WHERE 
    olympics_history_noc_regions.region = 'India'
GROUP BY 
    sport
ORDER BY 
    total_medals DESC
LIMIT 1;



Athletics	17	
20..Break down all olympic games where india won medal for Hockey and how many medals in each olympic games.
127.0.0.1/olympics/olympics_history/		http://localhost/phpmyadmin/index.php?route=/table/sql&db=olympics&table=olympics_history
Your SQL query has been executed successfully.

SELECT 
   team,sport, games, 
    COUNT(*) AS total_medals
FROM 
    olympics_history
INNER JOIN 
    olympics_history_noc_regions
ON 
    olympics_history.noc = olympics_history_noc_regions.noc
WHERE 
    olympics_history_noc_regions.region = 'India'
    AND olympics_history.sport = 'Hockey'
GROUP BY 
    games,team,sport
ORDER BY 
    games DESC;



India	Hockey	1992 Summer	2	
