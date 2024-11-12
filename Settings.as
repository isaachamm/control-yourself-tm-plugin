[Setting hidden]
bool Setting_Show_Session_Stats = true;

[Setting hidden]
bool Setting_Show_Session_Start_Time = false;
[Setting hidden]
bool Setting_Show_Session_Time_Played = true;
[Setting hidden]
bool Setting_Show_CurrMap_Time_Played = false;
[Setting hidden]
bool Setting_Show_Time_Left = true;
[Setting hidden]
bool Setting_Show_Respawns_Left = true;

[Setting hidden]
bool Setting_Show_Respawns_And_Resets = false;
[Setting hidden]
bool Setting_Show_Respawns = true;
[Setting hidden]
bool Setting_Show_Resets = true;
[Setting hidden]
bool Setting_Show_Finishes = true;
[Setting hidden]
bool Setting_Show_Average_Respawns_Per_Attempt = false;
[Setting hidden]
bool Setting_Show_Average_Respawns_Per_Finish = false;
[Setting hidden]
bool Setting_Show_Average_Attempts_Per_Finish = true;
[Setting hidden]
bool Setting_Show_Average_Respawns_And_Attempts_Per_Finish = false;
[Setting hidden]
bool Setting_Show_Average_Time_Per_Respawn = false;
[Setting hidden]
bool Setting_Show_Average_Time_Per_Reset = true;
[Setting hidden]
bool Setting_Show_Average_Time_Per_Finish = true;

[SettingsTab name="General" icon="Cogs"]
void Draw_Settings() {
    General_Settings();
    Respawn_Settings();
    Timer_Settings();
    Display_Settings();
}

void General_Settings() {
    UI::SeparatorText("General Settings");
    Setting_Show_Session_Stats = UI::Checkbox("Show Session Stats", Setting_Show_Session_Stats);

}

void Display_Settings() {

    UI::SeparatorText("Display Settings");

    if (UI::Button("Default Display")) {
        Setting_Show_Session_Start_Time = false;
        Setting_Show_Session_Time_Played = true;
        Setting_Show_CurrMap_Time_Played = false;
        Setting_Show_Time_Left = true;
        Setting_Show_Respawns_Left = true;

        Setting_Show_Respawns_And_Resets = false;
        Setting_Show_Respawns = true;
        Setting_Show_Resets = true;
        Setting_Show_Finishes = true;
        Setting_Show_Average_Respawns_Per_Attempt = false;
        Setting_Show_Average_Respawns_Per_Finish = false;
        Setting_Show_Average_Attempts_Per_Finish = true;
        Setting_Show_Average_Respawns_And_Attempts_Per_Finish = false;
        Setting_Show_Average_Time_Per_Respawn = false;
        Setting_Show_Average_Time_Per_Reset = true;
        Setting_Show_Average_Time_Per_Finish = true;
    }

    UI::SameLine();
    
    if (UI::Button("Minimal Display")) {
        Setting_Show_Session_Start_Time = false;
        Setting_Show_Session_Time_Played = true;
        Setting_Show_CurrMap_Time_Played = false;
        Setting_Show_Time_Left = true;
        Setting_Show_Respawns_Left = true;

        Setting_Show_Respawns_And_Resets = false;
        Setting_Show_Respawns = false;
        Setting_Show_Resets = false;
        Setting_Show_Finishes = false;
        Setting_Show_Average_Respawns_Per_Attempt = false;
        Setting_Show_Average_Respawns_Per_Finish = false;
        Setting_Show_Average_Attempts_Per_Finish = false;
        Setting_Show_Average_Respawns_And_Attempts_Per_Finish = false;
        Setting_Show_Average_Time_Per_Respawn = false;
        Setting_Show_Average_Time_Per_Reset = false;
        Setting_Show_Average_Time_Per_Finish = false;
    }

    UI::SameLine();

    if (UI::Button("Detailed Display")) {
        Setting_Show_Session_Start_Time = true;
        Setting_Show_Session_Time_Played = true;
        Setting_Show_CurrMap_Time_Played = true;
        Setting_Show_Time_Left = true;
        Setting_Show_Respawns_Left = true;

        Setting_Show_Respawns_And_Resets = true;
        Setting_Show_Respawns = true;
        Setting_Show_Resets = true;
        Setting_Show_Finishes = true;
        Setting_Show_Average_Respawns_Per_Attempt = true;
        Setting_Show_Average_Respawns_Per_Finish = true;
        Setting_Show_Average_Attempts_Per_Finish = true;
        Setting_Show_Average_Respawns_And_Attempts_Per_Finish = true;
        Setting_Show_Average_Time_Per_Respawn = true;
        Setting_Show_Average_Time_Per_Reset = true;
        Setting_Show_Average_Time_Per_Finish = true;
    }
    
    Setting_Show_Session_Start_Time = UI::Checkbox("Show Session Start Time/Current Time", Setting_Show_Session_Start_Time);
    Setting_Show_CurrMap_Time_Played = UI::Checkbox("Show Time Played Current Map", Setting_Show_CurrMap_Time_Played);
    Setting_Show_Time_Left = UI::Checkbox("Show Time Left/Max Time", Setting_Show_Time_Left);
    Setting_Show_Respawns_Left = UI::Checkbox("Show Respawns Left/Max Respawns", Setting_Show_Respawns_Left);
    
    Setting_Show_Respawns_And_Resets = UI::Checkbox("Show Respawns + Resets", Setting_Show_Respawns_And_Resets);
    Setting_Show_Respawns = UI::Checkbox("Show Respawns", Setting_Show_Respawns);
    Setting_Show_Resets = UI::Checkbox("Show Resets", Setting_Show_Resets);
    Setting_Show_Finishes = UI::Checkbox("Show Finishes", Setting_Show_Finishes);
    Setting_Show_Average_Respawns_Per_Attempt = UI::Checkbox("Show Average Respawns per Attempt", Setting_Show_Average_Respawns_Per_Attempt);
    Setting_Show_Average_Respawns_Per_Finish = UI::Checkbox("Show Average Respawns per Finish", Setting_Show_Average_Respawns_Per_Finish);
    Setting_Show_Average_Attempts_Per_Finish = UI::Checkbox("Show Average Attempts per Finish", Setting_Show_Average_Attempts_Per_Finish);
    Setting_Show_Average_Respawns_And_Attempts_Per_Finish = UI::Checkbox("Show Average Respawns + Attempts per Finish", Setting_Show_Average_Respawns_And_Attempts_Per_Finish);
    Setting_Show_Average_Time_Per_Respawn = UI::Checkbox("Show Avereage Time per Respawn", Setting_Show_Average_Time_Per_Respawn);
    Setting_Show_Average_Time_Per_Reset = UI::Checkbox("Show Avereage Time per Attempt", Setting_Show_Average_Time_Per_Reset);
    Setting_Show_Average_Time_Per_Finish = UI::Checkbox("Show Avereage Time per Finish", Setting_Show_Average_Time_Per_Finish);

}

void Respawn_Settings() {

    UI::SeparatorText("Respawn Settings");

    Max_Respawns = UI::InputInt("Set Max Respawns" + "##SetMaxRespawns", Max_Respawns);

 
    if (UI::Button("Reset Respawns to 0" + "##ResetRespawns")) {
        Total_Respawns = 0;
        Respawn::currMapRespawns = 0;
    }

    UI::SameLine();

    if (UI::Button("Reset Resets to 0" + "##ResetRestarts")) {
        Total_Resets = 0;
        Respawn::currMapResets = 0;
    }

    UI::SameLine();

    if (UI::Button("Reset Finishes to 0" + "##ResetFinishes")) {
        Total_Finishes = 0;
        Respawn::currMapFinishes = 0;
    }

    UI::SameLine();

    if (UI::Button("Reset all to 0" + "##ResetAll")) {
        Total_Respawns = 0;
        Respawn::currMapRespawns = 0;
        Total_Resets = 0;
        Respawn::currMapResets = 0;
        Total_Finishes = 0;
        Respawn::currMapFinishes = 0;
    }

    if ((Total_Resets + Total_Respawns) < Max_Respawns) {
        Respawn::respawnRedNotificationShown = false;
    }

    if ((Total_Resets + Total_Respawns) < (Max_Respawns * 0.9)) {
        Respawn::respawnYellowNotificationShown = false;
    }
}

enum TimerType {
    TimerMax,
    TimerLeft
}

void Timer_Settings() {

    UI::SeparatorText("Timer Settings");

    Max_Time_Settings();
    Time_Left_Settings();

    if (UI::Button("Set Time Left to Max Time" + "##SetTimeLeftToMax")) {
        Timer::timerYellowNotificationShown = false;
        Timer::timerRedNotificationShown = false;
        Time_Left_MS = Max_Time_MS;
    }

    UI::SameLine();

    if (UI::Button("Set Time Left to 1 hour" + "##SetTimeLeftToOneHour")) {
        Timer::timerYellowNotificationShown = false;
        Timer::timerRedNotificationShown = false;
        Time_Left_MS = 3601000;
    }

    // DevTool for testing
    // if (UI::Button("Reset Timer to 1 second" + "##ResetTimerToTen")) {
    //     Timer::timerYellowNotificationShown = false;
    //     Timer::timerRedNotificationShown = false;
    //     Time_Left_MS = 5000;
    // }
}

void Max_Time_Settings() {
    string newMaxTime = "";
    string error = "";

    newMaxTime = Time::Format(Max_Time_MS, false, true, true);

    bool timeChanged = false;
    newMaxTime = UI::InputText("Set Max Time (HH:MM:SS)", newMaxTime, timeChanged);

    if (timeChanged) {
        tryUpdateTime(newMaxTime, error, TimerType::TimerMax);
    } 

    if (error != "") {
        UI::PushStyleColor(UI::Col::Text, GlobalProps::Red_Warning_Color);
        UI::TextWrapped(error);
        UI::PopStyleColor();
    }
}

void Time_Left_Settings() {
    string newTimeLeft = "";
    string error = "";

    newTimeLeft = Time::Format(Time_Left_MS, false, true, true);

    bool timeLeftChanged = false;
    newTimeLeft = UI::InputText("Set Time Left (HH:MM:SS)", newTimeLeft, timeLeftChanged);

    if (timeLeftChanged) {
        tryUpdateTime(newTimeLeft, error, TimerType::TimerLeft);
    } 

    if (error != "") {
        UI::PushStyleColor(UI::Col::Text, GlobalProps::Red_Warning_Color);
        UI::TextWrapped(error);
        UI::PopStyleColor();
    }
}

void tryUpdateTime(const string &in timeToParse, string &out error, TimerType timeToUpdate) {
    try {

        string[] newTime = timeToParse.Split(":");

        if (newTime.Length != 3) {
            error = "Format Error: Must be H:MM:SS";
            return;
        }
        int newTimeHours = (Text::ParseInt(newTime[0]) * 60 * 60 * 1000);
        int newTimeMins = (Text::ParseInt(newTime[1]) * 60 * 100);
        int newTimeSeconds = (Text::ParseInt(newTime[2]) * 1000); 

        int newTimeMS = newTimeHours + newTimeMins + newTimeSeconds;
        
        error = "";

        switch (timeToUpdate) {
            case TimerType::TimerMax:
                Max_Time_MS = newTimeMS;
                break;
            case TimerType::TimerLeft:
                Time_Left_MS = newTimeMS;
                break;
        }
        
    } catch {
        error = "exception: " + getExceptionInfo();
    }
}