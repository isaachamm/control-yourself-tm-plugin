#if TMNEXT

void Main() {
}

void RenderEarly() {
    Respawn::Update();
    Timer::Update();
}

#else

void Main()  {
	print("This plugin only works with TM 2020");
}

#endif