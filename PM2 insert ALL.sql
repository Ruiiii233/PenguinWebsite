USE Project_User;

LOAD DATA INFILE '/home/jeoker/Documents/database/project/camera.csv'
  INTO TABLE Camera
  FIELDS TERMINATED BY ',' 
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 0 ROWS;

LOAD DATA INFILE '/home/jeoker/Documents/database/project/site.csv'
  INTO TABLE Site
  FIELDS TERMINATED BY ',' 
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 0 ROWS;

LOAD DATA INFILE '/home/jeoker/Documents/database/project/image.csv'
  INTO TABLE Image
  FIELDS TERMINATED BY ',' 
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 0 ROWS
  (idImage,fname,ftype,siteID,mediaLink,size,@vtimestamp,@vwidth,@vheight,@vlongitude,@vlatitude,camID)
  SET
  timestamp = NULLIF(@vtimestamp,'0'),
  width = NULLIF(@vwidth,'0'),
  height = NULLIF(@vheight,'0'),
  longitude = NULLIF(@vlongitude,'0'),
  latitude = NULLIF(@vlatitude,'0');
  
  

LOAD DATA INFILE '/home/jeoker/Documents/database/project/label.csv'
  INTO TABLE Annotation
  FIELDS TERMINATED BY ',' 
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 0 ROWS;

insert into UAV(model,camID,weight)
  values("DJI Mavic Air",1,430),("Phantom 3 Professional",3,1280),("DJI Mavic 2 Pro",4,907);

insert into Model(name,createTime)
  values("withoutChick0","2020:05:28 12:00:00");

insert into Detection(imageID,totalCount,pathOnCloud,modelID)
  values(1524,55,"xxx",1);





#INSERT USER
INSERT INTO User(UserName,Password,DoB,Email)
VALUES('JinyuNa','12345','1997-08-27','568246499@outlook.com');
INSERT INTO User(UserName,Password,DoB,Email)
VALUES('KaiHe','12345','1997-03-17','568246499@qq.com');
INSERT INTO User(UserName,Password,DoB,Email)
VALUES('YangLiu','12345','1996-12-06','568246499@gmail.com');
INSERT INTO User(UserName,Password,DoB,Email)
VALUES('XinruiWu','12345','1997-05-21','568246499@neu.edu.cn');
INSERT INTO User(UserName,Password,DoB,Email)
VALUES('SanZhang','88888','1989-11-01','568248769@126.com');
INSERT INTO User(UserName,Password,DoB,Email)
VALUES('SiLi','66666','1992-07-29','568232499@noreastern.com');

#INSERT Administrator
INSERT INTO Administrator(UserKeyFK)
VALUES('1');
INSERT INTO Administrator(UserKeyFK)
VALUES('2');
INSERT INTO Administrator(UserKeyFK)
VALUES('3');
INSERT INTO Administrator(UserKeyFK)
VALUES('4');

#INSERT NormalUser
INSERT INTO NormalUser(UserKeyFK)
VALUES('5');
INSERT INTO NormalUser(UserKeyFK)
VALUES('6');

#INSERT Researcher
INSERT INTO Researcher(UserKeyFK,FirstName,LastName,Gender,institute,AcademicPaper)
VALUES('1','Heather','Lynch','F','Stony Brook University','Low-temperature fate of the 0.7 structure in a point contact: A Kondo-like correlated state in an open system；Neutral metacommunity models predict fish diversity patterns in Mississippi–Missouri basin'),
       ('2','Tom','Hart','M','Oxford University','Mitogenomes Uncover Extinct Penguin Taxa and Reveal Island Formation as a Key Driver of Speciation；Comparative population genomics reveals key barriers to dispersal in Southern Ocean penguins'),
	   ('3','Alexander','Borowicz','M','Stony Brook University','Aerial-trained deep learning networks for surveying cetaceans from satellite imagery；Multi-modal survey of Adélie penguin mega-colonies reveals the Danger Islands as a seabird hotspot. Scientific Reports 3926'),
       ('4','A. Raya','Rey','M','National Scientific and Technical Research Council','Cryptic speciation in gentoo penguins is driven by geographic isolation and regional marine conditions: Unforeseen vulnerabilities to global change'),
       ('5','Casey','Youngflesh','M','University of California,Los Angeles','Multi-modal survey of Adélie penguin mega-colonies reveals the Danger Islands as a seabird hotspot;Circumpolar analysis of the Adélie Penguin reveals the importance of environmental variability in phenological mismatch');


#INSERT Post
INSERT INTO Post(UserKeyFK,Title,PostContent,Published)
VALUES('1','Which penguin is the most beautiful','Almost all the birds that has been here during the antarctic summer, now find their way north. Only on bird does the oppsite. It moves south, into the interior of this cold place. That is the Emperor Penguin, the largest, tallest and most beautiful of all the penguins.','1');
INSERT INTO Post(UserKeyFK,Title,PostContent,Published)
VALUES('2','26 types of penguin: The only list you will ever need','Warning: High risk of controversy and/or cuteness. The world penguins are a diverse and interesting bunch. Part of that diversity is the range of species - but where the species line is drawn is difficult to determine, especially in animals that are as closely related as penguins. Taxonomists agree that there are at least 16 penguin species, but there are arguments to be made for up to 22! Whether species, subspecies or colour morphs* - here are the 26 "types" of penguins that walk the earth.','1');

#INSERT Comment
INSERT INTO Comment(UserKeyFK,PostKeyFK,CommentContent)
VALUES('3','1','Amazing, they are so beautiful!');
INSERT INTO Comment(UserKeyFK,PostKeyFK,CommentContent)
VALUES('6','1','I like them!!!!');
INSERT INTO Comment(UserKeyFK,PostKeyFK,CommentContent)
VALUES('3','2','Thankyou for sharing.');

#INSERT Share
INSERT INTO Share(UserKeyFK,PostKeyFK)
VALUES('5','1');
INSERT INTO Share(UserKeyFK,CommentKeyFK)
VALUES('1','3');

#INSERT Save
INSERT INTO Save(UserKeyFK,PostKeyFK)
VALUES('2','1');
INSERT INTO Share(UserKeyFK,CommentKeyFK)
VALUES('2','2');

#INSERT LikeOrDislike
INSERT INTO LikeOrDislike(UserKeyFK,PostKeyFK,LikeOrDislike)
VALUES('2','1','1');
INSERT INTO LikeOrDislike(UserKeyFK,CommentKeyFK,LikeOrDislike)
VALUES('3','3','0');

#INSERT Participate
INSERT INTO Participate(idSiteFK,researcherKeyFK)
VALUES('1','1'),
('2','1'),
('3','1'),
('4','1'),
('5','1'),
('6','1'),
('7','2'),
('8','2'),
('9','2'),
('10','2'),
('11','2'),
('12','2'),
('13','2'),
('14','2'),
('15','2'),
('16','3'),
('17','3'),
('18','3'),
('19','3'),
('20','3'),
('21','3'),
('22','3'),
('23','4'),
('24','4'),
('25','4'),
('26','4'),
('27','5'),
('28','5'),
('29','5'),
('30','5'),
('31','5');











LOAD DATA INFILE '/home/jeoker/Documents/database/project/weather/2015(-54,-63).csv' INTO TABLE Weather
 FIELDS TERMINATED BY ',' 
 LINES TERMINATED BY '\n'
 IGNORE 1 LINES;
 
LOAD DATA INFILE '/home/jeoker/Documents/database/project/weather/2015(-59,-62).csv' INTO TABLE Weather
 FIELDS TERMINATED BY ',' 
 LINES TERMINATED BY '\n'
 IGNORE 1 LINES;
 
LOAD DATA INFILE '/home/jeoker/Documents/database/project/weather/2018(-54,-63).csv' INTO TABLE Weather
 FIELDS TERMINATED BY ',' 
 LINES TERMINATED BY '\n'
 IGNORE 1 LINES;
 
LOAD DATA INFILE '/home/jeoker/Documents/database/project/weather/2018(-59,-62).csv' INTO TABLE Weather
 FIELDS TERMINATED BY ',' 
 LINES TERMINATED BY '\n'
 IGNORE 1 LINES;
 
 LOAD DATA INFILE '/home/jeoker/Documents/database/project/weather/2019(-54,-63).csv' INTO TABLE Weather
 FIELDS TERMINATED BY ',' 
 LINES TERMINATED BY '\n'
 IGNORE 1 LINES;
 
 LOAD DATA INFILE '/home/jeoker/Documents/database/project/weather/2019(-59,-62).csv' INTO TABLE Weather
 FIELDS TERMINATED BY ',' 
 LINES TERMINATED BY '\n'
 IGNORE 1 LINES;