SELECT * FROM items 
WHERE title REGEXP '(?i)^Silicon.Valley.S06.*'
--AND imdb REGEXP 'tt2575988'
--AND title REGEXP '2018'
AND title REGEXP '(?i)264|avc'
AND title REGEXP '1080' 
AND title NOT REGEXP '3D'
ORDER BY size DESC;


--you'll probably need this as well
magnet:?xt=urn:btih:
