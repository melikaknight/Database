create table airLineCompany(
ALid int primary key,
airLineName varchar(45),
registerDate datetime);

create table Branch(
address varchar(45),
firstName varchar(45),
LastName varchar(45),
ALid int,
branchid int primary key,
foreign key (ALid) references airLineCompany (ALid)
);
#shobe weak entity ast.
# manager Last name sefate momayeze ast

create table branch_tel(
branchid int,
tel int,
constraint branch_tel_PK primary key (branchid,tel),
constraint branch_tel_FK foreign key (branchid) references Branch(branchid));
 
create table airLineCompany_tel(
ALid int,
tel int,
constraint branch_tel_PK primary key (ALid,tel),
constraint branchid_tel_FK foreign key (ALid) references Branch(ALid));

create table mainOffice (officeid int primary key,
firstname varchar(45),
lastName varchar(45),
address varchar(45),
ALid int,
foreign key (ALid) references airLineCompany(ALid));

create table mainOffice_tel (officeid int,
mainOffice_tel int,
constraint mainOffice_tel_pk primary key (officeid,mainOffice_tel),
constraint mainOffice_tel_fk foreign key (officeid) references mainOffice(officeid));

create table specialist(
specialistssn int primary key,
firstname varchar(45),
lastname varchar(45));

create table specialist_tels(
tel int,
specialistssn int,
constraint specialist_tels_PK primary key (specialistssn,tel) ,
foreign key (specialistssn) REFERENCES specialist (specialistssn));

create table specialist_address(
specialistssn int,
address varchar(45),
constraint specialist_add_PK primary key (specialistssn,address),
foreign key (specialistssn) REFERENCES specialist(specialistssn));



create table airPlane(
airplanename varchar(45) primary key,
capacity int);

create table trip(
tripid int primary key,
origin varchar(45),
destination varchar(45),
class varchar(45) check( class='business' or class= 'economy'),
airplanename varchar(45),
pilotname varchar(45),
price decimal(10,2),
ALid int,
foreign key(ALid) references airlinecompany(ALid),
foreign key(airplanename) references airplane(airplanename));

create table charterTrip(
charterid int primary key,
tripid int ,
goingtime datetime,
backingtime datetime,
goinglenghttime time,
backinglenghttime time,
foreign key(tripid) references Trip(tripid));

create table onewaytrip(
onewaytrip int primary key,
tripid int ,
triptime datetime,
triplenghttime time,
foreign key(tripid) references Trip(tripid));

create table verificationTripBySpecialist(
verificationStatus varchar(45) check( verificationStatus='accepted'
or  verificationStatus= 'rejected' or verificationStatus='inprocess'),
specialistssn int,
tripid int,
foreign key(tripid) references trip(tripid),
foreign key(specialistssn) references specialist(specialistssn) ,
constraint verificationTripBySpecialist_pk   primary key (tripid,specialistssn));


create table company (
enrollmentnum int primary key,
comapanyname varchar(45),
address varchar(100));

create table crecompany_tel(
enrollmentnum int,
tel int ,
foreign key(enrollmentnum) references company(enrollmentnum),
constraint company_tel_pk   primary key (enrollmentnum,tel));


#employee is weak entity
create table employee (
firstname varchar(45),
lastname varchar(45),
enrollmentnum int,
personalnum int,
foreign key(enrollmentnum) references company(enrollmentnum),
constraint cemployee_pk   primary key (enrollmentnum,personalnum));




create table employee_tel(
enrollmentnum int,
personalnum int,
tel int,
constraint foreign key (enrollmentnum,personalnum) references employee(enrollmentnum,personalnum),
constraint employee_tel_pk primary key (enrollmentnum,personalnum,tel));

create table customer(
customerid int primary key,
ssn int ,
firstname varchar(45),
lastname varchar(45));


create table ticket(
customerid int,
ticketid int primary key,
buytime datetime ,
personalnum int,
enrollmentnum int,
tripid int,
constraint foreign key (enrollmentnum,personalnum) references employee(enrollmentnum,personalnum),
constraint foreign key (customerid) references customer(customerid),
foreign key (tripid) references trip(tripid)
);


create table supportTeam(
stid int primary key,
firstname varchar(45),
lastname varchar(45),
onOroff boolean, #if it is 1 ,he is online else he is offline
lastOnline datetime);# it is only for off status




create table complaint(
complaintid int primary key,
stid int,
subjectComplaint varchar(45),
customerid int, 
sendTime datetime,
answertime datetime, 
foreign key (stid) references supportTeam(stid),
foreign key (customerid) references customer(customerid));


create table onlineAnswer(
answerid int primary key,
customerid int,
sendTime datetime,    #tavasote customer porside mishe
answertime datetime, #tavasote suport team pasokh dade mishe
stid int,
subjectComplaint varchar(45),
foreign key (stid) references supportTeam(stid),
foreign key (customerid) references customer(customerid));

create table customer_tels(
customerid int ,
tel int,
foreign key (customerid) references customer(customerid),
constraint customer_tels_PK primary key (customerid,tel) );


create table customer_add(
customerid int ,
address int,
foreign key (customerid) references customer(customerid),
constraint customer_add_PK primary key (customerid,address) );

create table unregistered_customer(
unc_id int primary key,
customerid int,
foreign key (customerid) references customer (customerid)
);
create table registered_customer(
rc_id int primary key,
customerid int,
fathername varchar(45),
birthdate date,
birthplace varchar(45),
accountnumber int,
timeRegistered datetime,
paidway varchar(45) check( paidway='online' or paidway= 'account'),
foreign key (customerid) references customer (customerid)
);

