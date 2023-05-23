/**********************************************************************
Description: Wrapper class to hold the resulting records and the pagination info
***********************************************************************/
public with sharing class SObjectSelectorResult
{
    public List<SObject> data { get; set; }
    public SObjectSelectorPaging paging { get; set; }

    public SObjectSelectorResult(List<SObject> lsObjects)
    {
        this.data = lsObjects;        
        this.paging = new SObjectSelectorPaging();
    }

    public SObjectSelectorResult(List<SObject> lsObjects, SObjectSelectorPaging p)
    {
        this.data = lsObjects;
        this.paging = p;        
    }
}