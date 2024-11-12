[Setting hidden]
// 1 hour = 1000 ms * 60s * 60m
int Time_Left_MS = 3601000;

[Setting hidden]
int Max_Time_MS = 3600000;

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
        Time_Left_MS -= delta;
        currTime = Time::Format(Time_Left_MS, false, true, true);
        

        if (currTime != prevTime) {
            prevTime = currTime;
        }

        if (Time_Left_MS < (Max_Time_MS / 10) && Time_Left_MS >= 0 && !timerYellowNotificationShown) {
            string[] currTimeArray = currTime.Split(":");
            string currTimeHours = ((Text::ParseInt(currTimeArray[0]) <= 0) ? "" : currTimeArray[0] + " Hours ");
            string currTimeMinutes = ((Text::ParseInt(currTimeArray[1]) <= 0) ? "" : currTimeArray[1] + " Minutes ");
            string currTimeSeconds = ((Text::ParseInt(currTimeArray[2]) <= 0) ? "" : currTimeArray[2] + " Seconds ");

            string currTimeMessage = currTimeHours + currTimeMinutes + currTimeSeconds + " Left!";
            UI::ShowNotification("Timer Almost Done", currTimeMessage + "\nFinish Strong!", GlobalProps::Yellow_Warning_Color, 5000);
            timerYellowNotificationShown = true;
        } else if (Time_Left_MS < 0 && !timerRedNotificationShown) {
            UI::ShowNotification("Timer Done", "Time for a break!", GlobalProps::Red_Warning_Color, 5000);
            timerRedNotificationShown = true;
        }
    }

}