/***********************************************************************
 * @Author          : Pietro Zuntini Bonfim
 * @Description     : Utility class to transform list of sObjects
 ************************************************************************/
public with sharing class Collection {
    private List<SObject> items; // List of items in the collection

    /**
     * @description Responsible for "collecting" the records to be processed
     * @author Pietro Zuntini Bonfim
     * @param items
     * @return Collection
     **/
    public Collection collect(List<SObject> items) {
        this.items = items;
        return this;
    }

    /**
     * @description Filters the collection by field equal to a specific value
     * @author Pietro Zuntini Bonfim
     * @param field
     * @param value
     * @return Collection
     **/
    public Collection whereField(String field, Object value) {
        List<SObject> newItems = new List<SObject>();

        for (SObject obj : this.items) {
            if (obj.get(field) == value) {
                newItems.add(obj);
            }
        }

        this.items = newItems;
        return this;
    }

    /**
     * @description Returns the list of values from a specific field
     * @author Pietro Zuntini Bonfim
     * @param fieldName
     * @return List<String>
     **/
    public List<String> pluckString(String fieldName) {
        List<String> values = new List<String>();

        for (SObject obj : this.items) {
            values.add((String) obj.get(fieldName));
        }

        return values;
    }

    /**
     * @description Returns the first item of the collection
     * @author Pietro Zuntini Bonfim
     * @return Sobject
     **/
    public Sobject first() {
        return !this.items.isEmpty() ? this.items[0] : null;
    }

    /**
     * @description Returns the list of items in the collection
     * @author Pietro Zuntini Bonfim
     * @return List<SObject>
     **/
    public List<SObject> all() {
        return this.items;
    }

    /**
     * @description Creates a map from the specified field
     * @author Pietro Zuntini Bonfim
     * @param fieldApiName
     * @return Map<String, SObject>
     **/
    public Map<String, SObject> mapByField(String fieldApiName, Type mapType) {
        Map<String, SObject> objMap = (Map<String, SObject>) mapType.newInstance();

        for (SObject obj : this.items) {
            objMap.put((String) obj.get(fieldApiName), obj);
        }

        return objMap;
    }
}
