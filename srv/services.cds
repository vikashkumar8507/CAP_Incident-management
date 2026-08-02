using {sap.capire.incidents as my} from '../db/schema';

//service definition for the incident management application
service ProcessorService {
    entity Incidents as projection on my.Incidents;

    @readonly
    entity Customers as projection on my.Customers;
}
annotate ProcessorService.Incidents with @odata.draft.enabled; 
annotate ProcessorService with @(requires: 'support');

//Service used by administrators to manage incidents and customers
service AdminService {  
    entity Incidents as projection on my.Incidents;
    entity Customers as projection on my.Customers;
}
annotate AdminService with @(requires: 'admin');
