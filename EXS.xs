//================================
// SETUP
//================================
const float NULL  = -14782.9421;
const int LIMIT   = 1000000;
int MAX           = 999999999;
int REFERENCE     = 10000;
int SCOPE         = 0;
int BOXED         = 0;
int FIELDS        = 0;
int TYPES         = 0;
int TYPENAMES     = 0;
int INSTANCES     = 0;
int INSTANCETYPE  = 0;
//================================
// CORE
//================================
int Scope(float id=NULL){
    if(id==NULL){return (SCOPE);}
    SCOPE = id;
    return (SCOPE);
}
int Fallback(float id=NULL){
    if(id==NULL){return (SCOPE);}
    return (id);
}
//================================
// ARRAY
//================================
int Array(int size=0,float value=NULL){return (xsArrayCreateFloat(size,value));}
int ArrayString(int size=0,string value=""){return (xsArrayCreateString(size,value));}
float Set(float value=NULL,float index=NULL,float id=NULL){xsArraySetFloat(Fallback(id),Fallback(index),value);return(value);}
float Get(float index=NULL,float id=NULL){return (xsArrayGetFloat(Fallback(id),Fallback(index)));}
string SetString(string value="",float index=NULL,float id=NULL){xsArraySetString(Fallback(id),Fallback(index),value);return(value);}
string GetString(float index=NULL,float id=NULL){return (xsArrayGetString(Fallback(id),Fallback(index)));}
int Size(float id=NULL){return (xsArrayGetSize(Fallback(id)));}
int LastIndex(float id=NULL){return (Size(id)-1);}
int Last(float id=NULL){return (Get(LastIndex(id),id));}
int First(float id=NULL){return (Get(0,id));}
void Resize(int size=0,float id=NULL){xsArrayResizeFloat(Fallback(id),size);}
void ResizeString(int size=0,float id=NULL){xsArrayResizeString(Fallback(id),size);}
void Extend(float id=NULL){Resize(Size(id)+1,id);}
void ExtendString(float id=NULL){ResizeString(Size(id)+1,id);}
//================================
// SHORTHAND
//================================
void Print(string text=""){xsChatData(text);}
void PrintWhite(string text=""){xsChatData(text);}
void PrintBlue(string text=""){xsChatData("<BLUE>"+text);}
void PrintRed(string text=""){xsChatData("<RED>"+text);}
void PrintGreen(string text=""){xsChatData("<GREEN>"+text);}
void PrintYellow(string text=""){xsChatData("<YELLOW>"+text);}
void PrintAqua(string text=""){xsChatData("<AQUA>"+text);}
void PrintPurple(string text=""){xsChatData("<PURPLE>"+text);}
void PrintGray(string text=""){xsChatData("<GRAY>"+text);}
void PrintOrange(string text=""){xsChatData("<ORANGE>"+text);}
//================================
// CONVERSION
//================================
int Ref(float id=NULL){return ((id*-1) - REFERENCE);}
int DeRef(float id=NULL){return ((id+REFERENCE) * -1);}
int Box(string value=""){
    int boxed = ArrayString(1,value);
    Set(1,boxed,BOXED);
    return (Ref(boxed));
}
string Unbox(float id=NULL){
    return (GetString(0,DeRef(id)));
}
bool IsRef(float id=NULL){
    if(id==NULL){return (false);}
    return (id < -10000);
}
bool IsBox(float id=NULL){
    return (IsRef(id) && Get(DeRef(id),BOXED) != NULL);
}
bool AsBool(float id=0){return (id!=0);}
float AsFloat(int id=0){
    float result = id;
    return (result);
}
int AsInt(float id=NULL){
    int result = id;
    return (result);
}
//================================
// LIST
//================================
float Append(float value=NULL,float id=NULL){
    Extend(id);
    Set(value,LastIndex(id),id);
    return (value);
}
string AppendString(string value="",float id=NULL){
    ExtendString(id);
    SetString(value,LastIndex(id),id);
    return (value);
}
int List(float a=NULL,float b=NULL,float c=NULL,float d=NULL,float e=NULL,float f=NULL,float g=NULL,float h=NULL){
    int list = Array();
    if(a!=NULL){Append(a,list);}
    if(b!=NULL){Append(b,list);}
    if(c!=NULL){Append(c,list);}
    if(d!=NULL){Append(d,list);}
    if(e!=NULL){Append(e,list);}
    if(f!=NULL){Append(f,list);}
    if(g!=NULL){Append(g,list);}
    if(h!=NULL){Append(h,list);}
    return (list);
}
int ListString(string a="",string b="",string c="",string d="",string e="",string f="",string g="",string h=""){
    int list = ArrayString();
    if(a!=""){AppendString(a,list);}
    if(b!=""){AppendString(b,list);}
    if(c!=""){AppendString(c,list);}
    if(d!=""){AppendString(d,list);}
    if(e!=""){AppendString(e,list);}
    if(f!=""){AppendString(f,list);}
    if(g!=""){AppendString(g,list);}
    if(h!=""){AppendString(h,list);}
    return (list);
}
int NewList(float a=NULL,float b=NULL,float c=NULL,float d=NULL,float e=NULL,float f=NULL,float g=NULL){
    return (Scope(List(a,b,c,d,e,f,g)));
}
int NewListString(string a="",string b="",string c="",string d="",string e="",string f="",string g=""){
    return (Scope(ListString(a,b,c,d,e,f,g)));
}
int Concat(float other=0,float id=NULL){
    int start = Size(id);
    Resize(start+Size(other),id);
    for(index=0;<Size(other)){
        float value = Get(index,other);
        Set(value,index+start,id);
    }
    return (id);
}
int ConcatString(float other=0,float id=NULL){
    int start = Size(id);
    Resize(start+Size(other),id);
    for(index=0;<Size(other)){
        string value = GetString(index,other);
        SetString(value,index+start,id);
    }
    return (id);
}
float Pop(float remove=NULL,float id=NULL){
    int offset = 0;
    float value = 0;
    int size = Size(id);
    if(remove < 0){remove = size+remove;}
    for(index=0;<size){
        if(remove == index){
            value = Get(index,id);
            offset = 1; 
        }
        Set(Get(index+offset,id),index,id);
    }
    Resize(size-1,id);
    return (value);
}
//================================
// TERM
//================================
int Term(string key="",float value=0){
    int keyID = ListString(key);
    int valueID = List(value);
    int term = List(keyID,valueID);
    return (term);
}
string GetTermKey(float id=NULL){return (GetString(0,First(id)));}
string SetTermKey(string value="",float id=NULL){return (SetString(value,0,First(id)));}
float GetTermValue(float id=NULL){return (First(Get(1,id)));}
float SetTermValue(float value=NULL,float id=NULL){return (Set(value,0,Get(1,id)));}
//================================
// CLASS
//================================
int GetType(float id=NULL){
    int type = Get(id,INSTANCETYPE);
    if(type != NULL){return (type);}
    return (NULL);
}
string GetTypeName(float id=0){
    return (GetString(GetType(id),TYPENAMES));
}
int FindType(string name=""){
    for(index=0;<Size(TYPES)){
        int type = Get(index,TYPES);
        if(GetTypeName(type)==name){
            return (type);
        }
    }
    return (NULL);
}
int NewClass(string name=""){
    int values = Append(List(),TYPES);
    if(name != ""){
        SetString(name,values,TYPENAMES);
    }
    Set(List(),values,FIELDS);
    Set(List(),values,INSTANCES);
    Set(values,values,INSTANCETYPE);
    return (Scope(values));
}
//================================
// FIELDS
//================================
int GetFields(float id=NULL){
    int fields = Get(id,FIELDS);
    if(fields == NULL){return (Get(GetType(id),FIELDS));}
    return (fields);
}
int GetFieldIndex(string name="",float id=NULL){ 
    int fields = GetFields(id);
    for(index=0;<Size(fields)){
        int field = Get(index,fields);
        if(GetTermKey(field) == name){return (index);}
    }
    return (NULL);
}
int GetField(string name="",float id=NULL){ 
    int index = GetFieldIndex(name,id);
    if(index == NULL){return (NULL);}
    return (Get(index,GetFields(id)));
}
bool HasFields(float id=NULL){return (GetFields(id)!=NULL);}
bool HasField(string name="",float id=NULL){return (GetField(name,id) != NULL);}
void Field(string name="",float value=0,float id=NULL){
    int field = GetField(name,id);
    if(field != NULL){
        int index = GetTermValue(field);
        Set(value,index,id);
        return;
    }
    int fields = GetFields(id);
    field = Term(name,Size(fields));
    Append(value,id);
    Append(field,fields);
}
void Remove(string name="",float id=NULL){
    int removeIndex = GetFieldIndex(name,id);
    if(removeIndex != NULL){
        int fields = GetFields(id);
        int targetField = Get(removeIndex,fields);
        int targetIndex = GetTermValue(targetField);
        for(index=0;<Size(fields)){
            int field = Get(index,fields);
            int value = GetTermValue(field);
            if(value > targetIndex){SetTermValue(value-1,field);}
        }
        Pop(targetIndex,id);
        Pop(removeIndex,fields);
    }
}
void Merge(float other=NULL,float id=NULL){
    int fields = GetFields(other);
    for(index=0;<Size(fields)){
        int field = Get(index,fields);
        int fieldIndex = GetTermValue(field);
        string fieldName = GetTermKey(field);
        float fieldValue = Get(fieldIndex,other);
        Field(fieldName,fieldValue,id);
    }
}
void Inherit(string name="",float id=NULL){
    int base = FindType(name);
    Merge(base,id);
}
//================================
// DICTIONARY
//================================
void Item(string name="",float value=0,float id=NULL){Field(name,value,id);}
int Dict(string a="",float a2=NULL,string b="",float b2=NULL,string c="",float c2=NULL,string d="",float d2=NULL){
    int dict = Array();
    Set(List(),dict,FIELDS);
    if(a2!=NULL){Item(a,a2,dict);}
    if(b2!=NULL){Item(b,b2,dict);}
    if(c2!=NULL){Item(c,c2,dict);}
    if(d2!=NULL){Item(d,d2,dict);}
    return (dict);
}
int NewDict(string a="",float a2=NULL,string b="",float b2=NULL,string c="",float c2=NULL,string d="",float d2=NULL){
    return (Scope(Dict(a,a2,b,b2,c,c2,d,d2)));
}
//================================
// INSTANCES
//================================
bool IsUserType(float instanceID=NULL){return (GetType(instanceID)!=NULL);}
bool IsType(int typeID=0,float instanceID=NULL){return (GetType(instanceID) == typeID);}
bool OfType(string name="",float instanceID=NULL){return (IsType(FindType(name),instanceID));}
int GetInstances(float typeID=NULL){return (Get(typeID,INSTANCES));}
int GetAmount(float typeID=NULL){return (Size(GetInstances(typeID)));}
int GetCount(string name=""){return (GetAmount(FindType(name)));}
float Value(string name="",float value=NULL,float id=NULL){
    int field = GetField(name,id);
    if(field != NULL){
        int fieldIndex = GetTermValue(field);
        if(value != NULL){return (Set(value,fieldIndex,id));}
        return (Get(fieldIndex,id));
    }
    return (NULL);
}
float SetValue(string name="",float value=NULL,float id=NULL){return (Value(name,value,id));}
float GetValue(string name="",float id=NULL){return (Value(name,NULL,id));}
string Text(string name="",string value="@!@",float id=NULL){
    if(value != "@!@"){
        int boxed = DeRef(Value(name,NULL,id));
        return (SetString(value,0,boxed));
    }
    return (Unbox(Value(name,NULL,id)));
}
string SetText(string name="",string value="@!@",float id=NULL){return (Text(name,value,id));}
string GetText(string name="",float id=NULL){return (Text(name,"@!@",id));}
int GetRef(string name="",float id=NULL){return (DeRef(GetValue(name,id)));}
int This(string name="",float id=NULL){return (Scope(GetRef(name,id)));}
mutable int Copy(float type=NULL){return (NULL);}
int CopyList(float id=NULL){
    int copy = Array(Size(id));
    for(index=0;<Size(id)){
        float value = Get(index,id);
        if(IsBox(value)){value = Box(Unbox(value));}
        else if(IsRef(value)){
            value = DeRef(value);
            if(IsUserType(value)){value = Ref(Copy(value));}
            else{value = Ref(CopyList(value));}
        }
        Set(value,index,copy);
    }
    return (copy);
}
mutable int Copy(float id=NULL){
    int type = GetType(id);
    int copy = CopyList(id);
    int all = GetInstances(type);
    Set(type,copy,INSTANCETYPE);
    Append(copy,all);
    return (copy);
}
int Type(string name=""){
    int type = FindType(name);
    return (Copy(type));
}
int NewCopy(float type=NULL){return (Scope(Copy(type)));}
int New(string name=""){return (Scope(Type(name)));}
//================================
// DEBUG
//================================
mutable void DisplayList(float id=NULL,string name="",string tab=""){}
mutable void DisplayFields(float id=NULL,string name="",string tab=""){}
void DisplayText(string text=""){Print("@#0" + text);}
void DisplayValue(float value=0,string scope="",string name="",string tab=""){
    string current = ""+AsInt(value);
    if(IsBox(value)){current = Unbox(value);}
    else if(IsRef(value)){
        value = DeRef(value);
        if(HasFields(value)){
            DisplayFields(value,name,tab);
            return;
        }
        DisplayList(value,name,tab);
        return;
    }
    Print("@#1" + tab + scope + name + " = " + current);
}
mutable void DisplayList(float id=NULL,string name="",string tab=""){
    if(name == ""){name = "List";}
    string scope = "[" + AsInt(id) + "] ";
    Print("@#8"+ tab + scope + name);
    tab = tab + "    ";
    for(index=0;<Size(id)){
        float current = Get(index,id);
        DisplayValue(current,scope,""+index,tab);
    }
}
mutable void DisplayFields(float id=NULL,string name="",string tab=""){
    if(name == ""){name = GetTypeName(id);}
    if(name == ""){name = "Dictionary";}
    string scope = "[" + AsInt(id) + "] ";
    Print("@#8" + tab + scope + name);
    tab = tab + "    ";
    int fields = GetFields(id);
    for(index=0;<Size(fields)){
        int field = Get(index,fields);
        string fieldName = GetTermKey(field);
        float current = Get(GetTermValue(field),id);
        DisplayValue(current,scope,fieldName,tab);
    }
}
void Display(float id=NULL,string name="",string tab=""){DisplayFields(id,name,tab);}
//================================
// MAIN
//================================
void EXSetup(){
    TYPES = List();
    TYPENAMES = ArrayString(32677);
    INSTANCES = Array(LIMIT);
    INSTANCETYPE = Array(LIMIT);
    FIELDS = Array(LIMIT);
    BOXED = Array(LIMIT);
}