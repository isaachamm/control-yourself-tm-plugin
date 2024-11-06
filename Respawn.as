[Setting name="Max Respawns" category="Settings" description="This is the number of respawns allowed before a limit warning is given."]
int Max_Respawns = 100;

[Setting hidden name="Number Respawns" category="Settings" description="This is the total number of respawns that occur."]
int Total_Respawns = 0;

[Setting hidden name="Number Resets" category="Settings" description="This is the total number of resets that occur."]
int Total_Resets = 0;

[Setting hidden name="Number Finishes" category="Settings" description="This is the total number of finishes that occur."]
int Total_Finishes = 0;



const vec4 cDefaultText = vec4(0.14f, 0.74f, 0.3f, 1.f);
vec4 S_GreenTimerColor = cDefaultText;
vec4 NotificationColor = vec4(0.2, 0.2, 0.2, 1);

namespace Respawn {

    string prevMapId = "";
    int prevNumRespawns = 0;
    int currMapResets = 0;
    int currMapFinishes = 0;
    bool resetHandled = true;
    bool finishHandled = false;
    bool messageShown = false;

    void Update() {

        auto app = GetApp();
        RenderDataTable();
        auto map = app.RootMap;
        if (map is null) {
            prevNumRespawns = 0;
            currMapResets = 0;
            currMapFinishes = 0;
            return;
        }
        if (prevMapId != map.IdName) {
            prevMapId = map.IdName;
            prevNumRespawns = 0;
        }
        auto playground = app.CurrentPlayground;
        if (playground is null || playground.GameTerminals.Length <= 0) return;
        auto terminal = playground.GameTerminals[0];
        auto gui_player = cast<CSmPlayer>(terminal.GUIPlayer);
        if (gui_player is null) return;

        // Finishes section
        auto ui_sequence = terminal.UISequence_Current;
        if (!finishHandled && ui_sequence == CGamePlaygroundUIConfig::EUISequence::Finish) {
            finishHandled = true;
            currMapFinishes += 1;
            Total_Finishes += 1;
        }
        if (finishHandled && ui_sequence != CGamePlaygroundUIConfig::EUISequence::Finish)
            finishHandled = false;

        // Resets section
        // Note: This currently includes finishes as a reset, as that's the only way to start a new map. Also, new maps start with 1 reset, which is the first attempt.
        auto post = (cast<CSmScriptPlayer>(gui_player.ScriptAPI)).Post;
        if (post == CSmScriptPlayer::EPost::CarDriver) {
            resetHandled = false;
        }

        if (!resetHandled && post == CSmScriptPlayer::EPost::Char) {
            resetHandled = true;
            currMapResets += 1;
            Total_Resets += 1;
        }

        // Respawns section
	    int currNumRespawns = gui_player.Score.NbRespawnsRequested;
        if (currNumRespawns > prevNumRespawns) {
            if (currNumRespawns > prevNumRespawns) {
                Total_Respawns = Total_Respawns + 1;
            }
            prevNumRespawns = currNumRespawns;
        }

        if (Total_Respawns + Total_Resets >= Max_Respawns && !messageShown) {
            UI::ShowNotification("Respawn Count Reached", "\n\t\tTake a break!\n\n", vec4(0.7, 0, 0, 1.f), 5000);
            messageShown = true;
        }
    }

    void RenderDataTable() {
        UI::SetNextWindowPos(200, 200, false ? UI::Cond::Always : UI::Cond::FirstUseEver);
        int window_flags = 
        UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking;
        UI::Begin("Respawn Counter", window_flags);
        UI::BeginGroup();

        string gameTimeRemaining = Time::Format(Timer_Start_Time_MS, false, true, true);

        Time::Info currTimeInfo = Time::Parse(Time::Stamp);
        string currTime = (currTimeInfo.Hour <= 9 ? "0" + tostring(currTimeInfo.Hour) : tostring(currTimeInfo.Hour)) + ":" + (currTimeInfo.Minute <= 9 ? "0" + tostring(currTimeInfo.Minute) : tostring(currTimeInfo.Minute)) + ":" + (currTimeInfo.Second <= 9 ? "0" + tostring(currTimeInfo.Second) : tostring(currTimeInfo.Second));

        UI::Text("Session Start Time: " + Timer::sessionStartTime + " / " + "Current Time: " + currTime);
        UI::Text("Time Played This Session: " + Time::Format(Timer::timePlayed, false, true, true));
        UI::Text("Time Left: " + gameTimeRemaining + " / Max Time: " + Time::Format(Max_Time, false, true,  true));
        UI::Text("Current Respawns: " + (Total_Resets + Total_Respawns) + " / Max Respawns: " + Max_Respawns);
        UI::EndGroup();
        UI::BeginGroup();

        UI::BeginTable("table", 3, UI::TableFlags::SizingFixedFit | UI::TableFlags::Borders);

        UI::TableNextRow();
		UI::TableNextColumn();
		UI::Text("Category");
		UI::TableNextColumn();
		UI::Text("Total");
        UI::TableNextColumn();
		UI::Text("Current");

        UI::TableSetBgColor(UI::TableBgTarget::RowBg0, vec4(0,0,0,1));

		UI::TableNextRow();
		UI::TableNextColumn();
		UI::Text("Respawns + Resets: ");
		UI::TableNextColumn();
		UI::Text(tostring(Total_Resets + Total_Respawns));
        UI::TableNextColumn();
		UI::Text(tostring(currMapResets + prevNumRespawns));

        UI::TableNextRow();
		UI::TableNextColumn();
		UI::Text("Respawns: ");
		UI::TableNextColumn();
		UI::Text(tostring(Total_Respawns));
        UI::TableNextColumn();
        UI::Text(tostring(prevNumRespawns));

        UI::TableNextRow();
		UI::TableNextColumn();
		UI::Text("Resets: ");
		UI::TableNextColumn();
		UI::Text(tostring(Total_Resets));
        UI::TableNextColumn();
        UI::Text(tostring(currMapResets));

        UI::TableNextRow();
		UI::TableNextColumn();
		UI::Text("Finishes: ");
		UI::TableNextColumn();
		UI::Text(tostring(Total_Finishes));
        UI::TableNextColumn();
        UI::Text(tostring(currMapFinishes));

        UI::EndTable();
        UI::EndGroup();
        UI::End();
    }

    void RespawnSettings() {
        if (UI::Button("Reset Respawns to 0" + "##ResetRespawns")) {
            Total_Respawns = 0;
            prevNumRespawns = 0;
        }

        if (UI::Button("Reset Resets to 0" + "##ResetRestarts")) {
            Total_Resets = 0;
            currMapResets = 0;
        }

         if (UI::Button("Reset Finishes to 0" + "##ResetFinishes")) {
            Total_Finishes = 0;
            currMapFinishes = 0;
        }

        if (UI::Button("Set Max Respawns to 100" + "##ResetMaxRespawn100")) {
            Max_Respawns = 100;
        }
        
        if (UI::Button("Set Max Respawns to 10" + "##ResetMaxRespawn10")) {
            Max_Respawns = 10;
        }
        
        if (UI::Button("Set Max Respawns to 1" + "##ResetMaxRespawn1")) {
            Max_Respawns = 1;
        }

        if (Total_Resets + Total_Respawns < Max_Respawns) {
            messageShown = false;
        }

    }

}