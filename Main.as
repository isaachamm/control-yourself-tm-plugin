#if TMNEXT




void Main() {
    print("Hello TM!");
}

void RenderEarly() {
    Respawn::Update();
    Timer::Update();
    

}

void RenderMenu() {
    
}

#else

void Main()  {
	print("This plugin only works with TM 2020");
}

#endif