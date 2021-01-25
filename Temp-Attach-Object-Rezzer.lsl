string carryAnim = "";
string rezObject = "Object";
key id;
string MoveAnim = "Cuff-Back";
string StandAnim = "Cuff-Front";
integer WasStanding = TRUE;



// Rez an object on touch, with relative position, rotation, and velocity all described in the rezzing prim's coordinate system.
string object = "Food Serving Tray"; // Name of object in inventory
vector relativePosOffset = <2.0, 0.0, 1.0>; // "Forward" and a little "above" this prim
vector relativeVel = <0.0, 0.0, 0.0>; // Traveling in this prim's "forward" direction at 1m/s
rotation relativeRot = <0.707107, 0.0, 0.0, 0.707107>; // Rotated 90 degrees on the x-axis compared to this prim
integer startParam;


default
{
    state_entry()
    {
        //llSay(0, "Hello, Avatar!");
    }

    touch_start(integer total_number)
    {
        //llSay(0, "Touched.");
        id = llDetectedKey(0);
        //integer startParam = id; 
        string name = llDetectedName(0);
        
        vector myPos = llGetPos();
        rotation myRot = llGetRot();
 
        vector rezPos = myPos+relativePosOffset*myRot;
        vector rezVel = relativeVel*myRot;
        rotation rezRot = relativeRot*myRot;
 
        llRezObject(object, myPos, rezVel, myRot, startParam);
        llSleep(1);
        llWhisper(-99, id);
    }
    run_time_permissions(integer perm)
    {
        string name = llDetectedName(0);
        
        
    }
    on_rez(integer rez)
    {
        if(!llGetAttached())
        {
            llResetScript();
        }
    }
    
    
}
