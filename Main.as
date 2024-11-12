#if TMNEXT

void RenderEarly() {
    if (!Setting_Show_Session_Stats) {
        return;
    }
    Respawn::Update();
    Timer::Update();
}

#else

void Main()  {
	print("This plugin only works with TM 2020");
}

#endif