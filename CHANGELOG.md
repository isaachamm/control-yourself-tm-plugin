# 0.0.5
- Configured Settings and made display conditional upon those settings.
- Refactored Timer_Start_Time_MS to be Time_Left_MS
- Fixed spacing of timer warning message.

# 0.0.4
- Added new stats: Avg. time per reset, avg. time per respawn, avg. time per finish.
- Added current map time in addition to total time.
- In code, fixed bug distinguishing between previous number of respawns and current map respawns
    - The bug made it so that if you respawned across multiple attempts, it would only count respawns if you respawned a greater number of times than a previous attempt -- i.e., TM code resets the respawn count to 0 after each finish/reset, and I hadn't been accounting for that.

# 0.0.3
- Improved notification system for approaching/passing allotted time/attempts
- Added color to time/respawns remaining.
- Included New stats: Respawns per reset, Respawns per finish, Resets (attempts) per finish.
- Improved function of timer

# 0.0.2
- MVP working version. First version that I sent to LumenTM for Alpha Testing.
- This is a very simple table format of stats that functions across maps for a single session. Included the following:
    - Session Start time and Current time (Player's local time)
    - Time played in session and Maximum time for the session
    - Time remaining according to max time allotted
    - Current number of respawns + resets and maximum allotted number of respawns + resets.
    - Kept track of total and current map stats for: Respawns, resets, and finishes
    - Had settings for resetting resets, respawns, and finishes to 0, and for resetting timer to 1 hour.

# 0.0.1
first commit -- this is a test plugin from the getting started tutorial. It just prints the number of respawns.