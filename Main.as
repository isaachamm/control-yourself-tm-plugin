#if TMNEXT

[Setting name="Max Respawns" category="Settings" description="This is the number of respawns allowed before a limit warning is given."]
int Max_Respawns = 100;

void Main() {
    print("Hello TM!");
}

void Render() {
    auto player = cast<CSmPlayer>(GetApp().CurrentPlayground.GameTerminals[0].GUIPlayer);
	print(player.ScriptAPI.Score.NbRespawnsRequested);

}

void RenderMenu() {
    if (UI::MenuItem("Respawn Counter")) {
        print("Nice test");
    }
}

#else

void Main()  {
	print("This plugin only works with TM 2020");
}

#endif