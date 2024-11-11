[Setting hidden name="Timer Start Time" description="This is the default time to play before a limit warning is given."]
// 1 hour = 1000 ms * 60s * 60m
int Timer_Start_Time_MS = 3601000;

[Setting name="Max Time" category="Settings" description="This is the amount of time that you'll play for before a notification warning is given."]
int Max_Time = 3600000;

namespace Timer {

    Time::Info sessionStartTimeInfo = Time::Parse(Time::Stamp);
    string sessionStartTime = (sessionStartTimeInfo.Hour <= 9 ? "0" + tostring(sessionStartTimeInfo.Hour) : tostring(sessionStartTimeInfo.Hour)) + ":" + (sessionStartTimeInfo.Minute <= 9 ? "0" + tostring(sessionStartTimeInfo.Minute) : tostring(sessionStartTimeInfo.Minute)) + ":" + (sessionStartTimeInfo.Second <= 9 ? "0" + tostring(sessionStartTimeInfo.Second) : tostring(sessionStartTimeInfo.Second));
    uint lastRenderTime = 0;
    int totalTimePlayed = 0;
    int currMapTimePlayed = 0;
    string currTime = "";
    string prevTime = "";
    bool timerYellowNotificationShown = false;
    bool timerRedNotificationShown = false;

    void Update() {

        auto app = GetApp();
        auto map = app.RootMap;

        uint64 delta;
        delta = lastRenderTime == 0 ? 0 : Time::Now - lastRenderTime;
        lastRenderTime = Time::Now;
        totalTimePlayed += delta;
        if (map !is null) {
            currMapTimePlayed += delta;
        }
        Timer_Start_Time_MS -= delta;
        currTime = Time::Format(Timer_Start_Time_MS, false, true, true);
        

        if (currTime != prevTime) {
            prevTime = currTime;
        }

        if (Timer_Start_Time_MS < (Max_Time / 10) && Timer_Start_Time_MS >= 0 && !timerYellowNotificationShown) {
            string[] currTimeArray = currTime.Split(":");
            string currTimeHours = (Text::ParseInt(currTimeArray[0]) <= 0) ? "" : currTimeArray[0] + " Hours";
            string currTimeMinutes = ((Text::ParseInt(currTimeArray[1]) <= 0) ? "" : currTimeArray[1] + " Minutes");
            string currTimeSeconds = ((Text::ParseInt(currTimeArray[2]) <= 0) ? "" : currTimeArray[2] + " Seconds");

            string currTimeMessage = currTimeHours + currTimeMinutes + currTimeSeconds + " Left!";
            UI::ShowNotification("Timer Almost Done", currTimeMessage + "\nFinish Strong!", GlobalProps::Yellow_Warning_Color, 5000);
            timerYellowNotificationShown = true;
        } else if (Timer_Start_Time_MS < 0 && !timerRedNotificationShown) {
            UI::ShowNotification("Timer Done", "Time for a break!", GlobalProps::Red_Warning_Color, 5000);
            timerRedNotificationShown = true;
        }
    }

    void TimerSettings() {
        if (UI::Button("Reset Timer to 1 hour" + "##ResetTimer")) {
            timerYellowNotificationShown = false;
            timerRedNotificationShown = false;
            Timer_Start_Time_MS = 3601000;
        }

        if (UI::Button("Reset Timer to 1 second" + "##ResetTimerToTen")) {
            timerYellowNotificationShown = false;
            timerRedNotificationShown = false;
            Timer_Start_Time_MS = 5000;
        }

    }

}