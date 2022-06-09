/***********************************************************************
 * @Author          : Pietro Zuntini Bonfim
 * @Description     : Utility class to transform list of sobjects
 ************************************************************************/
public with sharing class Collection {
    private List<SObject> items; // List of items in the collection

    /**
     * @description Responsável por "coletar" os registros a serem tratados
     * @author Pietro Zuntini Bonfim | 05-26-2021
     * @param items
     * @return Collection
     **/
    public Collection collect(List<SObject> items) {
        this.items = items;
        return this;
    }

    /**
     * @description Filtra a coleção por campo igual a um determinado valor
     * @author Pietro Zuntini Bonfim | 05-26-2021
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
     * @description Retorna a lista de valores de um determinado campo
     * @author Pietro Zuntini Bonfim | 05-26-2021
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
     * @description Retorna o primeiro item da coleção
     * @author Pietro Zuntini Bonfim | 05-27-2021
     * @return Sobject
     **/
    public Sobject first() {
        return !this.items.isEmpty() ? this.items[0] : null;
    }

    /**
     * @description Retorna a lista de items da coleção
     * @author Pietro Zuntini Bonfim | 05-26-2021
     * @return List<SObject>
     **/
    public List<SObject> all() {
        return this.items;
    }
}
