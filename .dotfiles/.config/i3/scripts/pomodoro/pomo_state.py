#!/usr/bin/env python3
from constants import STATE_FILE
from util import timedelta_str, read_stage_and_time, Stage

if __name__ == '__main__':
    stage, time_remaining = read_stage_and_time(STATE_FILE)
    if stage == Stage.ACTIVE:
        print("Working: %s" % timedelta_str(time_remaining))
        print("Working: %s" % timedelta_str(time_remaining))
        print("#FF0000")
    elif stage == Stage.REST:
        print("Resting: %s" % timedelta_str(time_remaining))
        print("Resting: %s" % timedelta_str(time_remaining))
        print("#00FF00")
    else:
        print() # If we're between pomodoro segments, nothing will be shown
