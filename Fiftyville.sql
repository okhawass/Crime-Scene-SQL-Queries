--searching descriptions from crime scene reports matching the date/location of crime
SELECT description FROM crime_scene_reports
WHERE year = "2021"
    AND day = "28"
    AND month = "07"
    AND street = "Humphrey Street"

--Searching for transcripts that mention the bakery
SELECT transcript FROM interviews
WHERE year = "2021"
    AND day = "28"
    AND month = "07"
    AND transcript LIKE "%bakery%"

--Getting name based on license plates of cars exiting bakery within 10 mins of crime scene
SELECT activity FROM bakery_security_logs
SELECT name FROM people JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
WHERE day = "28"
    AND month = "7"
    AND year = "2021"
    AND hour = "10"
    AND minute >= "15"
    AND minute < "25"
    AND activity = "exit"

--Searching names of atm withdrawals on Leggett Street on day of crime
SELECT
    DISTINCT name
FROM
    people
    JOIN bank_accounts ON people.id = bank_accounts.person_id
    JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number
WHERE day = "28"
    AND month = "7"
    AND year = "2021"
    AND transaction_type = "withdraw"
    AND atm_location = "Leggett Street"

        --Names in both atm withdrawals & related to license plates
            -- Bruce, Luca, Iman, Diana

--Finding names of people who took the earliest flight on the 29th
SELECT name
FROM
    people
    JOIN passengers ON people.passport_number = passengers.passport_number
WHERE
    flight_id = (
        SELECT id
        FROM flights
        WHERE day = "29"
            AND month = "7"
            AND year = "2021"
        ORDER BY hour, minute
        LIMIT 1
    )
            --Names in all 3 queries
                    -- Bruce, Luca

 -- Getting names of people who made a call less than one minute
 SELECT name
 FROM
    people
    JOIN phone_calls ON people.phone_number = phone_calls.caller
WHERE
    day = "28"
    AND month = "7"
    AND year = "2021"
    AND duration < "60"
            -- BRUCE

--Get destination
SELECT city FROM airports
WHERE id = (
    SELECT destination_airport_id
    FROM flights
    WHERE day = "29"
        AND month = "7"
        AND year = "2021"
    ORDER BY hour, minute
    LIMIT 1
)
            --NEW YORK CITY

--Finding accomplice (reciever of phone call)
SELECT name
FROM
    people
    JOIN phone_calls ON people.phone_number = phone_calls.receiver
WHERE day = "28"
    AND month = "7"
    AND year = "2021"
    AND duration < 60
    AND caller = (
        SELECT phone_number
        FROM people
        WHERE name = "Bruce"
    )
            --ROBIN