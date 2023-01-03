trigger CreateInquiry on Lightning_Step__Inquiry__c (after insert) 
{
    if(trigger.isAfter)
    {
        if(trigger.isInsert)
        {
            database.executebatch(new batchforCreateInquiry(Trigger.new),10);
        }
    }
}