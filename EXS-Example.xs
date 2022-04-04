include "EXS.xs";
void Simple(){
    //================================
    // CLASSES
    //================================
    NewClass("Unit");
        Field("Name",Box("Champion"));
        Field("Health",500);
        Field("Attack",12);
    //================================
    // INSTANCES
    //================================
    int unitA = New("Unit");Value("Health",9);
    int unitB = New("Unit");Text("Name","Rick");
    Display(unitA);
    DisplayText("-----------");
    Display(unitB);
    //================================
    // DICTIONARY
    //================================
    int colors1 = NewDict("red",0,"blue",1,"green",2);
    int colors2 = NewDict();
    Item("purple",33);
    Item("pink",9);
    Item("gray",11);
    Remove("pink");
    Merge(colors1);
    DisplayFields(colors2);
    DisplayText("-----------");
    //================================
    // LIST
    //================================
    int listA = NewList(10,500,67,1);
    Append(100,listA);
    Pop(-2,listA);
    DisplayList(listA,"ListA");
    int listB = NewListString("a","b","c");
    for(index=0;<Size(listB)){
        string value = GetString(index,listB);
        PrintOrange("" + index + " = " + value);
    }
}
void Advanced(){
    //================================
    // CLASSES
    //================================
    NewClass("Resources");
        Field("lots",11);
    NewClass("Simple");
        Field("Name",Box("Champion"));
        Field("Bacon",42);
        Field("Supplies",Ref(Type("Resources")));
        Field("Health",1);
        Field("Stuff",Ref(List(22)));
    NewClass("Unit");Inherit("Simple");
        Field("Health",500);
        Field("Attack",12);
    //================================
    // INSTANCES
    //================================
    int unitA = New("Unit");
    This("Stuff");Append(88);
    This("Supplies",unitA);
    Value("lots",Ref(List(1,2,3)));
    int unitB = New("Unit");
    Text("Name","Billy");
    This("Stuff");Append(90);
    int unitC = New("Unit");
    This("Stuff");Append(100);
    int unitD = New("Unit");
    This("Supplies");Value("lots",9);
    DisplayText("-----------");
    Display(unitA);
    DisplayText("-----------");
    Display(unitB);
    DisplayText("-----------");
    Display(unitC);
    DisplayText("-----------");
    Display(unitD);
    DisplayText("-----------");
    //================================
    // LIST
    //================================
    int listA = NewList(unitA,unitB,unitC);Pop(1);
    int listB = NewList(unitC,unitA,unitD);Concat(listA);
    int listC = NewList(Ref(listA),Ref(unitD),Box("Cool"));
    DisplayList(listB);
    DisplayText("-----------");
    DisplayList(listC);
    DisplayText("-----------");
    PrintAqua("Unit Instances : " + GetCount("Unit"));
}
void main(){
    EXSetup();
    Simple();
    //Advanced();
}
