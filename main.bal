import ballerinax/health.fhir.r4.aubase410;
import ballerinax/health.fhir.r4;
import ballerina/http;
import ballerinax/mysql;

//The Patient record to interact with the database.
public type Patient record {|

    string id;
    string firstName;
    string lastname;
    string birthdate;
    string gender?;
    string address_use;
    string address_type;
    string address_line;
    string address_city;
    string address_state;
    string address_country;
    string address_postalcode;
|};

//Database connection configurations
configurable string USER = ?;
configurable string PASSWORD = ?;
configurable string HOST = ?;
configurable int PORT = ?;
configurable string DATABASE = ?;

final mysql:Client dbClient = check new (user = USER, password = PASSWORD, host = HOST, port = PORT, database = DATABASE);

//This method returns AUBasePatient record and the patient can be read by the id.
isolated function getPatient(string id) returns aubase410:AUBasePatient|r4:FHIRError? {
    do {
        Patient patient = check dbClient->queryRow(`SELECT * FROM patient_details WHERE id = ${id}`);

        r4:PatientGender? patientGender = checkGender(<string>patient.gender);
        r4:AddressUse? addressUse = checkAddressUse(<string>patient.address_use);

        aubase410:AUBasePatient|r4:FHIRError? fhirPatient = implementAuPatient(patient.id, [patient.firstName], 
        patient.lastname, <r4:PatientGender>patientGender, patient.birthdate, [patient.address_line], 
        patient.address_state, patient.address_city, patient.address_postalcode, <r4:AddressUse>addressUse, 
        patient.address_country);

        return fhirPatient;

    } on fail var e {
        r4:FHIRError fhirError = r4:createFHIRError(e.toString(), r4:CODE_SEVERITY_FATAL, r4:CODE_TYPE_INFORMATIONAL,
        httpStatusCode = http:STATUS_NOT_FOUND);
        return fhirError;
    }
}
