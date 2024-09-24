/***********************************************************************
 * @Author          : Pietro Zuntini Bonfim
 * @Description     : Test class for the Collection class
 ************************************************************************/
@isTest
private class CollectionTest {
    private static final Integer NUM_ACCOUNTS = 20;
    private static final Integer NUM_EMPLOYEES = 20;

    /**
     * @description Creates test data
     * @author Pietro Zuntini Bonfim
     **/
    @TestSetup
    static void makeData() {
        List<Account> accounts = new List<Account>();

        for (Integer i = 1; i <= NUM_ACCOUNTS; i++) {
            accounts.add(new Account(Name = 'Test ' + i, NumberOfEmployees = NUM_EMPLOYEES));
        }

        Database.insert(accounts);
    }

    /**
     * @description Tests collect() and all() functionality
     * @author Pietro Zuntini Bonfim
     **/
    @IsTest
    static void test_collect_and_all() {
        List<Account> accounts;

        Test.startTest();
        accounts = new Collection().collect([SELECT Name FROM Account]).all();
        Test.stopTest();

        System.assertEquals(NUM_ACCOUNTS, accounts.size(), 'Expected ' + NUM_ACCOUNTS + ', found ' + accounts.size());
    }

    /**
     * @description Tests whereField() functionality
     * @author Pietro Zuntini Bonfim
     **/
    @IsTest
    static void test_whereField() {
        List<Account> accounts;

        Test.startTest();
        accounts = new Collection()
            .collect([SELECT NumberOfEmployees FROM Account])
            .whereField('NumberOfEmployees', NUM_EMPLOYEES)
            .all();
        Test.stopTest();

        System.assertEquals(NUM_ACCOUNTS, accounts.size(), 'Expected ' + NUM_ACCOUNTS + ', found ' + accounts.size());
    }

    /**
     * @description Tests pluckString() functionality
     * @author Pietro Zuntini Bonfim
     **/
    @IsTest
    static void test_pluckString() {
        List<String> accountNames;

        Test.startTest();
        accountNames = new Collection().collect([SELECT Name FROM Account]).pluckString('Name');
        Test.stopTest();

        System.assertEquals(NUM_ACCOUNTS, accountNames.size(), 'Expected ' + NUM_ACCOUNTS + ', found ' + accountNames.size());
    }

    /**
     * @description Tests first() functionality
     * @author Pietro Zuntini Bonfim
     **/
    @IsTest
    static void test_first() {
        Account first;

        Test.startTest();
        first = (Account) new Collection().collect([SELECT Name FROM Account]).first();
        Test.stopTest();

        System.assertEquals('Test 1', first.Name, 'Expected the first account name to be "Test 1"');
    }

    /**
     * @description Tests mapByField() functionality
     * @author Pietro Zuntini Bonfim
     **/
    @IsTest
    static void test_mapByField() {
        List<Account> accounts = [SELECT Name FROM Account];

        Test.startTest();
        Map<String, Account> mapAccounts = (Map<String, Account>) new Collection()
            .collect(accounts)
            .mapByField('Name', Map<String, Account>.class);
        Test.stopTest();

        System.assertEquals(NUM_ACCOUNTS, mapAccounts.size(), 'Expected ' + NUM_ACCOUNTS + ', found ' + mapAccounts.size());
    }
}
