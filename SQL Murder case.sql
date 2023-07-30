/* You vaguely remember that the crime was a murder that occurred sometime on Jan.15,2018 
and that it took place in SQL City. Start by retrieving the corresponding crime scene 
report from the police department's database*/

SELECT * FROM Crime_scene_report
WHERE Date = '20180115' AND city = 'SQL City'




/* Security footage shows that there were 2 witnesses. The first witness lives at the last house on
""Northwestern Dr"". The second witness, named Annabel, lives somewhere on ""Franklin Ave"". */

SELECT * FROM Person

-- Find the first witness and find what he/she said - The first witness lives on 'Northwestern Dr' 

SELECT * FROM  Person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_Number DESC

-- Our first witness is Morty Schapiro and our second witness is Annabel Miller

-- Find Witness Two

SELECT * FROM Person
WHERE Name LIKE 'Annabel%' AND address_street_name = 'Franklin Ave'

/* Our first witness is MORTY SCHAPIRO -Id- 14887, licence id 118009, address number 4919
on Northwestern Dr with ssn 111564949 */

/* Our Second witness is Annabel Millar - with Id 16371, licence Id 490173 address_number 103
on Franklin Ave with ssn 318771143 */

SELECT * FROM Interview
WHERE Person_id IN (14887,16371)

/* The first witness Mr Morty with person Id 14887 said - "I heard a gunshot and 
then saw a man run out.He had a "Get Fit Now Gym" bag. The membership number on the bag
started with ""48Z"".Only gold members have those bags. The man got into a car with
a plate that included ""H42W"".*/

/* The second witness Annabel Miller with person Id 16371 said - "I saw the murder happen,
and I recognized the killer from my gym when I was working out last week on January the 9th." */

-- MY OWN CONTINUATION-- Check the gold member and also see if any of the witness is a gold member
SELECT * FROM Get_fit_now_member
WHERE membership_status = 'gold'
AND person_id IN (14887,16371)

/* Annabel Miller is also a gold member */

-- Using the like function i filter out the plate number and get the owner of the car
SELECT * FROM Drivers_license
WHERE plate_number LIKE 'H42W%' 

/* The plate number belongs to id 193779, age-21, height-65, eye_color-blue,
hair_color-blonde, gender-female plate_number-H42WOX, Car_make-Toyota, Car_model-Prius */

/* Now i'd go back to the get_fit_now_check_in of Jan, 09,2018 as started 
by the second witness seeing the killer there while working out */

SELECT * FROM Get_fit_now_check_in
WHERE membership_id LIKE '48Z%'
AND check_in_date = '20180109'

/* membership_id - 48Z7A with check_in_date - 20180109 and check_in_time-1600
and check_out_time-1730 */
/* membership_id - 48Z55 with check_in_date - 20180109 and check_in_time-1530 
and check_out_time-1700 */

 /* Now i'd go back to the get_fit_now_member and filter out both
 membership_id gotten from the check in */

SELECT * FROM Get_fit_now_member
WHERE id = '48Z7A'

SELECT * FROM Get_fit_now_member
WHERE id = '48Z55'

/* membership_id -48Z7A with person_id 28819, name- JOE GERMUSKA, membership_start_date-20160305
with a gold membership */

/* membership_id-48Z55 with person_id-67319, name-JEREMY BOWERS, membership_start_date-20160101 
with a gold membership */ 

-- Mentors continuation

SELECT * FROM get_fit_now_member
WHERE Id LIKE '48Z%'
AND membership_status = 'gold'

/* Based on the witness of te first witness, our suspects are Joe germuska with id 48Z7A, person id
28819, with memebership start date 20160305 and gold membership */

/* second suspect is jeremy bowers wit id 48Z55, person id 67318, start date 20160101 and
a gold membership */

SELECT dl.age, dl.height, dl.hair_color, dl.gender, dl.plate_number, dl.car_make,
        dl.car_model, p.name, p.ssn, p.address_street_name, p.id
FROM drivers_license AS dl
LEFT JOIN Person AS p
ON dl.id = p.license_id

SELECT * FROM drivers_license
WHERE plate_number LIKE '%H42W%' or plate_number LIKE 'H42W%'
or plate_number LIKE '%H42W'

-- Our Culprit is Jeremy Bowers

SELECT * FROM Interview
WHERE person_id = 67318

/* "I was hired by a woman with a lot of money. I don't know her name but I know 
she's around 5'5"" (65"") or 5'7"" (67""). She has red hair and she drives a 
Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017."  */

CREATE TABLE suspect AS ( SELECT * FROM drivers_license
WHERE height BETWEEN 65 AND 67
AND Hair_color = 'red'
AND gender = 'female'
AND car_make = 'Tesla'
AND car_model = 'Model S' )

SELECT * FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert'
AND date BETWEEN 20171201 AND 20171231

-- person id -- 99716,24556

SELECT * FROM person

SELECT s.id, s.age, s.height, p.id AS person_Id, p.name,
       p.address_street_name, p.ssn
FROM suspect AS s
RIGHT JOIN Person AS P
ON s.id = p.license_id

-- id we are looking for is 99716, 90700, 7881

SELECT * FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert'
AND Date BETWEEN 20171201 AND 20171231
AND Person_id IN (99716,90700,78881)

SELECT * FROM person
WHERE id = 99716

-- The real killer is Miranda Priestly --
