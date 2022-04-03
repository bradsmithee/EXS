# EXS
  Extended XS Functionality (for AOE2 DE).
  
  Adds shorthands for :
  - Scope
  - Prints
  - Arrays
 
  Adds pseudo-support for the following : 
  - Classes
    - Inheritence
    - Named "Fields"
      - Float fields
      - String fields (via Box)
      - Reference fields (via Ref)
    - Type/Instance Checking
  - Lists
  - Dictionary

Small usage example :
```c
include "EXS.xs";
void main(){
    //================================
    // DEFINE CLASS
    //================================
    NewClass("Unit");
        Field("Name",Box("Champion"));
        Field("Health",500);
        Field("Attack",12);
    //================================
    // INSTANCES
    //================================
    int unitA = New("Unit");Value("Health",9);    // instances new unit; sets health value to 9
    int unitB = New("Unit");Text("Name","Rick");  // instances new unit; sets name field value to Rick
    Display(unitA);                               // Prints debug tree of fields and values.
}
```
  See `EXS-Example.xs` for additional usage/features.
  
  Visit [HERE](https://docs.google.com/document/d/1wJ5KqV6TUTh4YZcPssENHS7kWUfdQGROIn7bsE1lL9Y/edit#) for API documentation.
