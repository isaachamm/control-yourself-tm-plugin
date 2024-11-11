[Setting name="Show thousands" category="Respawn Counter"]
bool setting_show_thousands = false;
[Setting name="Show Hour if 0" category="Respawn Counter"]
bool setting_show_hour_if_0 = false;

[Setting name="Show Total time" category="Stats"]
bool setting_show_total_time = true;
[Setting name="Show Session time" category="Stats"]
bool setting_show_session_time = true;

[Setting name="Show Session finishes" category="Stats"]
bool setting_show_finishes_session = true;
[Setting name="Show Total finishes" category="Stats"]
bool setting_show_finishes_total = true;

[Setting name="Show Session resets" category="Stats"]
bool setting_show_resets_session = true;
[Setting name="Show Total resets" category="Stats"]
bool setting_show_resets_total = true;

[SettingsTab name="Respawn Counter" icon="BarChart"]
void Respawn_Settings() {
    Respawn::RespawnSettings();
}


[SettingsTab name="Countdown Timer" icon="ClockO"]
void Timer_Settings() {
    Timer::TimerSettings();
}
