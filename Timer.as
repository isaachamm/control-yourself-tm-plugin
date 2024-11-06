[Setting hidden name="Timer Start Time" description="This is the default time to play before a limit warning is given."]
// 1 hour = 1000 ms * 60s * 60m
int Timer_Start_Time_MS = 3601000;

[Setting name="Max Time" category="Settings" description="This is the amount of time that you'll play for before a notification warning is given."]
int Max_Time = 3600000;

namespace Timer {

    Time::Info sessionStartTimeInfo = Time::Parse(Time::Stamp);
    string sessionStartTime = (sessionStartTimeInfo.Hour <= 9 ? "0" + tostring(sessionStartTimeInfo.Hour) : tostring(sessionStartTimeInfo.Hour)) + ":" + (sessionStartTimeInfo.Minute <= 9 ? "0" + tostring(sessionStartTimeInfo.Minute) : tostring(sessionStartTimeInfo.Minute)) + ":" + (sessionStartTimeInfo.Second <= 9 ? "0" + tostring(sessionStartTimeInfo.Second) : tostring(sessionStartTimeInfo.Second));
    uint lastRenderTime = 0;
    int timePlayed = 0;
    string currTime = "";
    string prevTime = "";
    void Update() {

        uint64 delta;
        delta = lastRenderTime == 0 ? 0 : Time::Now - lastRenderTime;
        lastRenderTime = Time::Now;
        int sign = Timer_Start_Time_MS < 0 ? -1 : 1;
        timePlayed += delta;
        Timer_Start_Time_MS -= delta;
        int signAfter = Timer_Start_Time_MS < 0 ? -1 : 1;

        if (sign != signAfter) {
            UI::ShowNotification("Timer Done", "\n\t\tTake a break!\n\n", vec4(0.7, 0, 0, 1.f), 5000);
        }
        // print(Time::FormatString("%H:%M:%S",Timer_Start_Time_MS));
        currTime = Time::Format(Timer_Start_Time_MS, false, true, true);
        // print(Time::Format(Timer_Start_Time_MS, false, true, true));
        
        if (currTime != prevTime) {
            prevTime = currTime;
        }
    }

    void TimerSettings() {
        if (UI::Button("Reset Timer to 1 hour" + "##ResetTimer")) {
            Timer_Start_Time_MS = 3601000;
        }

        if (UI::Button("Reset Timer to 1 second" + "##ResetTimerToTen")) {
            Timer_Start_Time_MS = 1000;
        }

    }

}