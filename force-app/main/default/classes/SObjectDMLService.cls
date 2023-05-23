/**********************************************************************
Description: Class to perform all the DML statements
It runs in user mode by default. It can be changed to system mode
Since it is without sharing, the system mode will also ignore the sharing setup
***********************************************************************/
public without sharing class SObjectDMLService {
    public System.AccessLevel accessLevel {private get; set;}
    public Boolean allOrNone {private get; set;}
    
    public SObjectDMLService() {
        this.accessLevel = System.AccessLevel.USER_MODE;
        this.allOrNone = false;
    }

    public List<Database.SaveResult> doInsert(List<SObject> lsObjects) {
        return Database.insert(lsObjects, this.allOrNone, this.accessLevel);
    }
    
    public List<Database.SaveResult> doUpdate(List<SObject> lsObjects) {
        return Database.update(lsObjects, this.allOrNone, this.accessLevel);
    }

    public List<Database.DeleteResult> doDelete(List<SObject> lsObjects) {
        return Database.delete(lsObjects, this.allOrNone, this.accessLevel);
    }
}