@isTest
public class rcCountCache_Test {

    @isTest static void test_upsertContact() {

        Test.startTest();
        
        Date today = Date.today();
        
        // insert account
        Account account = new Account(Name = 'Test');
        insert account;
        
        Opportunity oppty = new Opportunity(Name = 'Test',
                                           CloseDate = today,
                                           StageName  = 'Closed Won');
        insert oppty;
        
        // insert contact
        Contact contact = new Contact(LastName = 'Blake');
        insert contact;
        
        // update contact
        contact.FirstName = 'William';
        update contact;
        
        // delete contact
        delete contact;
        
        // undelete
        undelete contact;
        
        List<Date> cacheDateList = new List<Date>();
        cacheDateList.add(today);
        rcCountCache_StoreCDCForDate.storeCDCCount(cacheDateList);
        
        Test.stopTest();
    }
}