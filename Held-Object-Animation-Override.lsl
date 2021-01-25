string MoveAnim = "Cuff-Back";
string StandAnim = "Cuff-Front";
integer WasStanding = TRUE;
default
{
    attach(key id)
    {
        if(id != NULL_KEY)
        {
            llRequestPermissions(llGetOwner(), PERMISSION_TRIGGER_ANIMATION | PERMISSION_TAKE_CONTROLS);
        }
        else
        {
            llSetTimerEvent(0.0);
        }
    }
    state_entry()
    {
        llSay(0, "Hello, Avatar!");
        //llSetTimerEvent(0.1);
        
        llRequestPermissions(llGetOwner(), PERMISSION_TRIGGER_ANIMATION | PERMISSION_TAKE_CONTROLS);
        
    }
    run_time_permissions(integer perm)
    {
        if(perm & PERMISSION_TRIGGER_ANIMATION)
        {
            llSetTimerEvent(0.1);//Half second should do.
        }
        if(perm & PERMISSION_TAKE_CONTROLS)
        {
            llTakeControls(1, 0, 1);//This takes no controls.
                                    //It only exists to operate the script in no script zones.
        }
    }
    touch_start(integer total_number)
    {
        llSay(0, "Touched.");
    }
    timer()
    {
        if(llGetAttached() != 0)//If we're actually attached
        {
            if (llGetAgentInfo( llGetOwner() ) & AGENT_WALKING)
            {    if(WasStanding) { llSleep(0.15); WasStanding = FALSE;}
            llStopAnimation(MoveAnim);llStartAnimation(StandAnim);}
            else
            //if (llGetAgentInfo( llGetOwner() ) & AGENT_WALKING)
            {  WasStanding = TRUE;  llStopAnimation(StandAnim);llStartAnimation(MoveAnim);}
        }
    }
}
