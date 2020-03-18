/**********************************************************************
 Name: SObjectSelectorPaging
======================================================
Description: Class to help with the pagination in queries
Limited to 2000 records via LIMIT and OFFSET
***********************************************************************/
public with sharing class SObjectSelectorPaging 
{
    //Indicates the records per page you want to have
    public Integer recordsPerPage {get;set;}

    //Indicates the current page
    public Integer currentPage 
    { 
        get; 
        set 
        { 
            //Pass the new value
            this.currentPage = value; 

            //Check if the currentpage is not negative or zero
            if (this.currentPage < 1 || this.currentPage == null) 
            { 
                this.currentPage = 1; 
            }
        }
    }

    //Indicates if the paging logic should be applied or not
    public Boolean enabled {get; set;}

    //Constructor, pagina is disabled by default
    public SObjectSelectorPaging() 
    {
        this.currentPage = 1;
        this.recordsPerPage = 10;
        enabled = false;
    }
}
