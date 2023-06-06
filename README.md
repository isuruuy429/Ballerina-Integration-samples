This is a sample code to implement the getById operation for the AUBase Patient. 

## Configurations

Do the following configurations to run the sample. 

### Creating the Database
Execute the following quesries to create the database. 

1. Creating the Database
```
create database <DATABASE_NAME>;
use <DATABASE_NAME>;
```

2. Create database schemas
```
create table patient_details (
id varchar(200) NOT NULL,
firstName varchar (200),
lastname varchar (200),
birthdate varchar (50),
gender varchar (20),
date_of_arrival varchar (50),
address_use varchar (20),
address_type varchar (20),
address_line varchar (200),
address_city varchar (200),
address_state varchar (200),
address_postalcode varchar (200),
contact_relationship_code varchar (200),
contact_relationship_display varchar (200),
contact_relationship_system varchar (200),
contact_relationship_phone varchar (200),
PRIMARY KEY (id)
);
```

3. Insert Data to the table. 
```
insert into patient_details values ("111-11-8888","John","Doe","1971-09-27","male","2020-02-23","home", "postal","EW2 Andrews Str", "Geelong", "VIC","10290","394619001","Guardian","http://snomed.info/sct","0775530752");

insert into patient_details values ("112-11-8888","Andrew","Simpsons","1972-09-28","male","2021-02-23","home", "postal","EW44 St. Andos Str", "Geelong", "VIC","10291","1155871000168103","Kinship carer","http://snomed.info/sct","0775830752");

```

### Create Config.toml

Create Config.toml in the home directory of the Ballerina Project and the details. 
```
USER="user"
PASSWORD="user_password"
HOST="localhost"
PORT=3306
DATABASE="DATABASE_NAME"
```

### Update the Ballerina.toml file
Download the driver JAR manually and update the path in the Ballerina.toml file. 
```
[[platform.java11.dependency]]
groupId = "mysql"
artifactId = "mysql-connector-java"
version = "8.0.26"

[[platform.java11.dependency]]
path = "/Users/isuruuy/Desktop/RND/OH/testing/feature-testing/choreo/customers/medinet/mysql-connector-java-8.0.26.jar"
```

## Testing
1. Run the service using `bal run` command. 
2. Invoke the API as below. 
```
curl --location 'http://localhost:9090/au/fhir/r4/Patient/111-11-8888'
```