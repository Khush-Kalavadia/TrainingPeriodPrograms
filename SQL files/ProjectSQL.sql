CREATE DATABASE ProjectDatabase;

use ProjectDatabase;

CREATE TABLE user(
id int primary key auto_increment,
username varchar(50),
password varchar(50)
);

INSERT INTO user(username, password) VALUES ('admin', 'admin'), ('khush', 'khush');

SELECT * FROM user;

SELECT * FROM user WHERE username like binary 'admin' AND password like binary 'admin';

-- imp ip cannot be primary key as same primary key can have 2 entries
CREATE TABLE discovery(
id int primary key auto_increment,		-- for frontend benifit
name varchar(50),						
ip_hostname varchar(253),               -- ipv4 consumes max 15character while hostname consumes max 253
type varchar(4),						-- ssh or ping
provision tinyint default 0				-- 0 or 1. to show button to provision or not. button appears when we run discovery
);
-- check for ip_host and type as unique while adding

CREATE TABLE credential(
id int primary key auto_increment,
map_discovery_id int,						-- we keep this maping over here because not all devices are ssh. If we keep in discovery all ping field values would be empty
-- then why i haven't kept monitor map id here and mapped credential in monitor? -> Devices that are in provision i.e. monitors would be limited based on the number of cpu cores and time we are scheduling
-- so it is prefered to map credential in monitor to avoid null spaces in credential table because even that null value occupies space
username varchar(32), 						-- max limit is 32 characters
password varchar(100)
);
-- check ip_host if exist update  or else add new 

CREATE table monitor(
id int primary key auto_increment,		-- will be mapped to polling tables. check for ping to decide which table
map_credential_id int,						-- will be mapped with the credential. (Reason above) 
map_discovery_id int,					-- will help to handle provision request if done multiple times. It will update the device
name varchar(50),
ip_hostname varchar(253),
type varchar(4),
availability_status varchar(7) default 'unknown'			-- "up", "down" based on only ping. "unknown" when just added
);
-- check for ip_host and type as unique while adding

-- some queries -----------------
insert into monitor(name, ip_hostname) values("abc", "ip");
delete from monitor where id = 1;
select * from monitor;
select * from discovery;
update discovery set provision = 1 where id=53; 
UPDATE credential SET username = 'ccc', password = 'abc' WHERE map_monitor_id = 8;
select * from credential;
truncate credential;
delete from discovery where id=93;
drop table credential;
insert into discovery(name, ip_hostname, type) values ("khush", "khush-HP-ProBook-430-G3", "ping"), 
("khush", "khush-HP-ProBook-430-G3", "ssh"), ("abc", "def", "ping");

insert into discovery(name, ip_hostname, type, provision) values ("asde", "ae", "ping", 1);
truncate table monitor;
insert into discovery(id, name) values (12,"hi");
describe discovery;
select * from discovery;
select * from credential;
select * from monitor;	
insert into credential(map_discovery_id, username, password) values(4, 'pavan', "Mind@123"), (5, 'shekhar', "Mind@123");
update credential set map_discovery_id=6 where id=2;
delete from discovery where id=37;
update discovery set provision=1 where id=17;
update discovery set id=1 where name='Khush';
update credential set map_discovery_id = 44 where id = 12;
select * from credential;


-- on delete cascade check
insert into monitor(id, type) values(9, "ping"), (10, "ping");
insert into ping_polling(map_monitor_id, average_rtt) values(9,1), (9,2), (10,3); 
select * from discovery;
update discovery set provision = 1 where id = 27;
select * from ping_polling where map_monitor_id = 38;
select availability_status, COUNT(*) as device_count from monitor group by availability_status;
select * from ssh_polling;

SELECT name, ip_hostname, used_memory_gb FROM ssh_polling INNER JOIN monitor ON id = map_monitor_id WHERE 
availability_status = 'up' AND (time, map_monitor_id) in (SELECT MAX(time), map_monitor_id FROM ssh_polling 
GROUP BY map_monitor_id) ORDER BY used_memory_gb DESC LIMIT 3;

SELECT name, ip_hostname, used_memory_gb FROM ssh_polling INNER JOIN monitor ON id = map_monitor_id WHERE availability_status = 'up' AND (time, map_monitor_id) in (SELECT MAX(time), map_monitor_id FROM ssh_polling GROUP BY map_monitor_id) ORDER BY used_memory_gb desc LIMIT 3;


delete from ping_polling where time between '2022-04-29 18.36.42' and '2022-04-30 10.55.04';
SELECT time, packet_loss FROM ping_polling WHERE map_monitor_id = 8 ORDER BY time DESC LIMIT 20; 
select * from monitor;
delete from monitor where id=10;
update monitor set availability_status = "down" where id=13;
INSERT INTO ping_polling(map_monitor_id, time, availability, packet_loss, min_rtt, packet_transmitted, packet_received) VALUES (1, 1, 32, 2, 32, 3);
INSERT INTO ssh_polling(map_monitor_id, time, idle_cpu_percent, total_memory_gb, used_memory_gb, total_disk_gb, used_disk_gb, uptime) VALUES (?, ?, ?, ?, ?, ?, ?, ?);

SELECT AVG(availability) FROM ping_polling WHERE map_monitor_id = ? and time BETWEEN ? AND ?;


-- queries end -----------------


-- even in case of polling a ssh device. It must store its ping data as well. Based on the ping -> 
-- if it is 100% rtt would be null (and not 0). In other case u get rtt so store it. 
-- Even if packet loss is 100% you must do ssh means ssh in any case and also store it's data so we know that it was polled. 
CREATE TABLE ping_polling(
map_monitor_id int,
time datetime,
availability tinyint,
packet_loss float,		   			-- set float from int. Eg. 33.3333 
avg_rtt float,	     				-- set float
packet_transmitted int,
packet_received int,
foreign key (map_monitor_id) references monitor(id) on delete cascade
);

CREATE TABLE ssh_polling(
map_monitor_id int,
time datetime, 
idle_cpu_percent float,						
total_memory_gb float,
used_memory_gb float,
total_disk_gb float,
used_disk_gb float,
uptime varchar(40),
foreign key (map_monitor_id) references monitor(id) on delete cascade
);
