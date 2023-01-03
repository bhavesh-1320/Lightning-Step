global with sharing class ClientAdmissionStatusScheduler implements Schedulable
{
    global void execute(SchedulableContext ctx) 
    {
        //Batch class for fetching bulkified Admitted Client status
        ClientAdmissionStatus admissionStatusBatch = new ClientAdmissionStatus();
        ID batchprocessid = Database.executeBatch(admissionStatusBatch,50); 
    }
}