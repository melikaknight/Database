use mydb;
drop table company;
create table company(
enrollmentnum int primary key,
companyname varchar(45),
address varchar(100));
drop table data_tracking;
create table data_tracking (
tracking_id int auto_increment primary key,
enrollmentnum int,
field varchar(45),
old_address varchar(100),
new_address varchar(100),
modified datetime);

insert into company values (12,"taban","resalat");



DELIMITER $$


CREATE TRIGGER update_company AFTER UPDATE on company
FOR EACH ROW
BEGIN
    IF (NEW.address != OLD.address) THEN
        INSERT INTO data_tracking 
		( enrollmentnum, `field` , old_address , new_address , modified ) 
        VALUES 
		(NEW.enrollmentnum, "address", OLD.address, NEW.address, NOW());
    END IF;
END$$

DELIMITER ;
update company 
set address="shahed"
where enrollmentnum=12
