import ballerinax/health.fhir.r4;
import ballerinax/health.fhir.r4.aubase410;

//check gender and assign code
isolated function checkGender(string gender) returns r4:PatientGender? {
    r4:PatientGender? patientGender = r4:CODE_GENDER_UNKNOWN;
    if gender == "female" {
        patientGender = r4:CODE_GENDER_FEMALE;
    }
    else if gender == "male" {
        patientGender = r4:CODE_GENDER_MALE;
    }
    else if gender == "other" {
        patientGender = r4:CODE_GENDER_OTHER;
    }
    return patientGender;
}

isolated function implementAuPatient(string id, string[] firstName, string lastName, r4:PatientGender gender,
        string birthDate, string[] addressLine, string addressState, string addressCity, string addressPostalCode,
        r4:AddressUse addressUse, string country) returns aubase410:AUBasePatient|r4:FHIRError? {

    aubase410:AUBasePatient auPatient = {
        id: id,
        name: [
            {
                family: lastName,
                given: firstName
            }
        ],
        birthDate: birthDate,
        address: [
            {
                line: addressLine,
                state: addressState,
                city: addressCity,
                postalCode: addressPostalCode,
                use: addressUse,
                country: country
            }
        ],
        gender: gender,
        identifier: [
            {
                system: "http://ns.electronichealth.net.au/id/medicare-number",
                value: "32788511952",
                'type: {
                    coding: [
                        {
                            system: "http://terminology.hl7.org/CodeSystem/v2-0203",
                            code: "MC",
                            display: "Patient's Medicare Number"
                        }
                    ]
                }
            }
        ]

    };
    return auPatient;
}

//check address use and assign code
isolated function checkAddressUse(string addressUse) returns r4:AddressUse? {
    r4:AddressUse? addressUseType = "home";

    if addressUse == "work" {
        addressUseType = "work";
    }
    else if addressUse == "temp" {
        addressUseType = "temp";
    }
    else if addressUse == "old" {
        addressUseType = "old";
    }
    else if addressUse == "billing" {
        addressUseType = "billing";
    }
    return addressUseType;
}
