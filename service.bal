import ballerinax/health.fhir.r4.aubase410;
import ballerinax/health.fhir.r4;
import ballerina/http;

service /au on new http:Listener(9090) {
    isolated resource function get fhir/r4/Patient/[string id]() returns aubase410:AUBasePatient|r4:FHIRError? {
        return getPatient(id);
    }
}
