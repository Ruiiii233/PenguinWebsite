USE PenguinWebsite;

/* 10. link each image to the weather record, where the weather station is closest and time matches best */
select idWeather, time, Weather.longitude, Weather.latitude, idImage, timestamp,
       abs(round(6367000*2*asin(sqrt(pow(sin(((Weather.latitude * pi())/180-(the_image.latitude*pi())/180)/2),2) + cos((the_image.Latitude*pi())/180)*cos((Weather.latitude*pi())/180)*pow(sin(((Weather.longitude*pi())/180-(the_image.longitude * pi())/180)/2), 2))))) as distance
from Weather, (select * from Image where idImage = 5410) as the_image
where the_image.latitude is not null and
      the_image.longitude is not null and
      the_image.timestamp is not null
order by distance, abs(the_image.timestamp-Weather.time)
limit 1;

