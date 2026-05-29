using {
    cuid,
    managed,
    sap.common.CodeList,
} from '@sap/cds/common';


namespace sap.capire.incidents;


// incidents created by customers
entity Incidents : cuid, managed {
    customer : Association to Customers;
    title : String @string: 'title';
    urgency : Association to Urgency default 'M';
    status : Association to Status default 'N';
    conversation : Composition of many {
        key id : UUID;
        timestamp : type of managed : createdAt;
        author : type of managed : createdBy;
        message : String;
    };
}

// customers who create incidents
entity Customers : managed {
    key ID : String;
    firstName : String;
    lastName : String;
    name : String = trim (firstName || ' ' || lastName);
    email : EMailAddress;
    phone : PhoneNumber;
    incidents: Association to many Incidents on incidents.customer = $self;
    creditCardNo: String(16) @assert.format : '^[1-9]\d{15}$';
    addresses : Composition of many Addresses on addresses.customer = $self;
}

// addresses of customers
entity Addresses : cuid, managed {
    customer : Association to Customers;
    city : String;
    postCode : String;
    streetAddress : String;
}

// status of incidents

entity Status : CodeList {
    key code: String enum {
        new = 'N';
        assigned = 'A';
        in_process = 'I';
        on_hold = 'H';
        resolved = 'R';
        closed = 'C';
    };
    criticality : Integer;
}

// urgency of incidents

entity Urgency : CodeList {
    key code: String enum {
        low = 'L';
        medium = 'M';
        high = 'H';
    };
    criticality : Integer;
}

type EMailAddress : String;
type PhoneNumber  : String;
type Email : String;

// End of file