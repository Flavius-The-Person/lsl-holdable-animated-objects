string rezObject = "Object";
key id;
string MoveAnim = "tray hold";
string StandAnim = "tray hold";
integer WasStanding = TRUE;

string object = "Object"; // Name of object in inventory

vector relativeVel = <0.0, 0.0, 0.0>; 

integer startParam = 10;

integer permsGranted = FALSE;

string name;
key owner;
integer listenerChannel = -99;
rotation rot_xyzq;

vector xyz_angles = <0,90,348.75000>; // This is to define a 1 degree change

default
{
    state_entry()
    {
        //llSay(0, "Hello, Avatar!");
        llListen(listenerChannel,"","","");
        //vector xyz_angles = <0,1.0,0>; // This is to define a 1 degree change
        vector angles_in_radians = xyz_angles*DEG_TO_RAD; // Change to Radians
        rot_xyzq = llEuler2Rot(angles_in_radians); // Change to a Rotation
    }

    
    run_time_permissions(integer perm)
    {
        
        if(perm & PERMISSION_ATTACH)
        {
            //mame = llDetectedName();
            vector myPos = llGetPos();
            rotation myRot = llGetRot();
            vector rezVel = relativeVel*myRot;
            //llRezObject(rezObject, myPos, rezVel,myRot,startParam);
            //llWhisper(0, llDetectedName(0) + " did accept attachment request!");
            llAttachToAvatarTemp(ATTACH_RHAND);
            llListenRemove(listenerChannel);
            llSleep(1);
            llRequestPermissions(llGetOwner(),PERMISSION_TRIGGER_ANIMATION);
        }
        else
        {
            llDie();
            //llOwnerSay("you did not accept attachment request!");
        }
        if(perm & PERMISSION_TRIGGER_ANIMATION)
        {
            //llOwnerSay("you did accept animation request!");
            permsGranted = TRUE;
            llSleep(0.5);
                llSetTimerEvent(0.1);
            
        }
        
    }
    on_rez(integer rez)
    {
        if(!llGetAttached())
        {
            llListen(listenerChannel,"","","");
        }
    }
    listen(integer channel, string name, key id, string message)
    {
        if(permsGranted)
        {
            return;
        }
        if(message)
        {
            id = message;
            llRequestPermissions(id,PERMISSION_ATTACH);
        }
    }
    attach(key AvatarKey)
    {
        if(AvatarKey)
        {
            llSleep(1);
            integer attached = llGetAttached();
            if(attached)
            {
                llSetRot(rot_xyzq);
                //llOwnerSay("The object has been successfully attached!");
            }
            else
            {
                //llOwnerSay("The object has not been successfully attached!");
            }
        }
    }
    timer()
    {
        if(llGetAttached() != 0)//If we're actually attached
        {
            if(permsGranted)
            {
                if (llGetAgentInfo( llGetOwner() ) & AGENT_WALKING)
                {    
                    if(WasStanding) { llSleep(0.15); WasStanding = FALSE;
                }
                llStopAnimation(MoveAnim);llStartAnimation(StandAnim);
            }
            else
            //if (llGetAgentInfo( llGetOwner() ) & AGENT_WALKING)
            {  
                WasStanding = TRUE;  llStopAnimation(StandAnim);                         llStartAnimation(MoveAnim);}
            }
        }
    }
    changed(integer change)
    {
        if(change & CHANGED_OWNER)
        {
            owner = llGetOwner();
        }
    }
}
