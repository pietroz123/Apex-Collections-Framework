/***********************************************************************
 * @Author          : Pietro Zuntini Bonfim
 * @Description     : Classe de teste da classe Collection
 ************************************************************************/
@isTest
private class CollectionTest {
    private static final Integer NUM_ACCOUNTS = 20;
    private static final Integer NUM_EMPLOYEES = 20;

    /**
     * @description Cria massa de teste
     * @author Pietro Zuntini Bonfim | 05-28-2021
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
     * @description Testa funcionalidade de collect() e all()
     * @author Pietro Zuntini Bonfim | 05-28-2021
     **/
    @IsTest
    static void test_collect_and_all() {
        List<Account> accounts;

        Test.startTest();
        accounts = new Collection().collect([SELECT Name FROM Account]).all();
        Test.stopTest();

        System.assertEquals(NUM_ACCOUNTS, accounts.size(), 'Esperavam-se ' + NUM_ACCOUNTS + ' encontradas');
    }

    /**
     * @description Testa funcionalidade de whereField()
     * @author Pietro Zuntini Bonfim | 05-28-2021
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

        System.assertEquals(NUM_ACCOUNTS, accounts.size(), 'Esperavam-se ' + NUM_ACCOUNTS + ' encontradas');
    }

    /**
     * @description Testa funcionalidade de pluckString()
     * @author Pietro Zuntini Bonfim | 05-28-2021
     **/
    @IsTest
    static void test_pluckString() {
        List<String> accountNames;

        Test.startTest();
        accountNames = new Collection().collect([SELECT Name FROM Account]).pluckString('Name');
        Test.stopTest();

        System.assertEquals(NUM_ACCOUNTS, accountNames.size(), 'Esperavam-se ' + NUM_ACCOUNTS + ' encontradas');
    }

    /**
     * @description Testa funcionalidade de first()
     * @author Pietro Zuntini Bonfim | 05-28-2021
     **/
    @IsTest
    static void test_first() {
        Account first;

        Test.startTest();
        first = (Account) new Collection().collect([SELECT Name FROM Account]).first();
        Test.stopTest();

        System.assertEquals('Test 1', first.Name, 'Esperava-se o nome da primeira conta "Test 1"');
    }
}
