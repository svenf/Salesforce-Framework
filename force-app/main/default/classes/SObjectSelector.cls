/**********************************************************************
Description: Abstract class for the selector layer to do queries
***********************************************************************/
public without sharing abstract class SObjectSelector
{
    //Implement this method to inform the base class of the SObject (custom or standard) to be queried
    //This needs to be implemented by the child classes
    abstract Schema.SObjectType getSObjectType();    

    //Method to return the name of the specified sobjec
    @TestVisible
    protected String getSObjectName()
    {
        return getSObjectType().getDescribe().getName();
    }    

    //Constructor
    public SObjectSelector()
    {
        //Init the paging property
        this.paging = new SObjectSelectorPaging();
        this.accessLevel = System.AccessLevel.USER_MODE;
    }    

    //Public property to define the fields to be returned (defined as strings)
    public List<String> lsSelectFields {private get; set;}

    //Method to create the select string of the query
    @TestVisible
    protected String getSelectString()
    {
        //A list of fields (strings) has been defined, so append the strings and return the string
        if(lsSelectFields != null && !lsSelectFields.isEmpty())
        {
            return String.join(lsSelectFields, ', ');
        } 
        else
        {
            //Otherwise only return the Id
            return 'Id';
        }
    }

    //Public property to hold the paging info
    public SObjectSelectorPaging paging {get; set;}

    //Method to return the paging string to add to the query
    @TestVisible
    protected String getPagingString()
    {
        //When the paging is defined and has been enabled
        if(this.paging != null && this.paging.enabled)
        {
            //Get the records per page
            Integer take = this.paging.recordsPerPage;

            //Get the number to use as offset in the query
            Integer skip = (this.paging.currentPage - 1) * take;

            return String.format('LIMIT {0} OFFSET {1}', new List<String> { String.valueOf(take),
                    String.valueOf(skip)
            });
        }
        else 
        {
            return 'LIMIT 50000';
        }
    }

    //Public property to define the fields to sort on (defined as strings)
    public List<String> lsOrderByFields {get; set;}

    //Method to return the order by string
    @TestVisible
    protected String getOrderByString()
    {
        //The order by string has been defined
        if(lsOrderByFields != null && !lsOrderByFields.isEmpty())
        {
            //Return the formatted string
            return String.format('ORDER BY {0}', new List<String> { String.join(lsOrderByFields, ', ') });
        }
        return '';
    }

    //Public property to define the fields to be returned (defined as strings)
    public List<String> lsGroupByFields {get; set;}

    //Method to return the group by string
    @TestVisible
    protected String getGroupByString()
    {
        //The order by string has been defined
        if(lsGroupByFields!= null && !lsGroupByFields.isEmpty())
        {
            //Return the formatted string
            return String.format('GROUP BY {0}', new List<String> { String.join(lsGroupByFields, ', ') });
        }
        return '';
    }

    //Property to hold the query that needs to be executed
    @TestVisible
    protected String soqlQuery {get; set;}       

    public System.AccessLevel accessLevel {private get; set;}

    public List<SObject> doQuery() {
        return Database.query(this.soqlQuery, this.accessLevel);
    }

    public List<SObject> doQueryWithBinds(Map<String, Object> binds) {
        return Database.queryWithBinds(this.soqlQuery, binds, this.accessLevel);
    }
    
    public List<AggregateResult> doAggregateQuery() {
        return Database.query(this.soqlQuery, this.accessLevel);
    }

    public List<AggregateResult> doAggregateQueryWithBinds(Map<String, Object> binds) {
        return Database.queryWithBinds(this.soqlQuery, binds, this.accessLevel);
    }

    public Integer doCountQuery() {
        return Database.countQuery(this.soqlQuery, this.accessLevel);
    }

    public Integer doCountQueryWithBinds(Map<String, Object> binds) {
        return Database.countQueryWithBinds(this.soqlQuery, binds, this.accessLevel);
    }

    //Method to return a SObjectSelectorResult object based on a list of sobjects and a soqlquery
    public SObjectSelectorResult returnQueryresult(List<SObject> lsObjects)
    {
        return new SObjectSelectorResult(lsObjects, paging);    
    }

    //Create specific exception for the selector layer
    @TestVisible
    private class SObjectSelectorException extends Exception {}
}