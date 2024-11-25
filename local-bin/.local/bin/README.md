# Pomodoro Countdown

![screenshot](https://i.imgur.com/jIpfflm.png)

A very very simple pomodoro timer implementation that works on the terminal.

It sends a notification whenever a timer finishes.

## Usage
```
usage: pomodoro-timer [-h] [-w WORK] [-r REST] [-f FONT] [-t] [-n]

Fancy pomodoro timer script

optional arguments:
  -h, --help            show this help message and exit
  -w WORK, --work WORK  Number of minutes of work
  -r REST, --rest REST  Number of minutes of rest
  -f FONT, --font FONT  Custom font file
  -t, --total           Show the total timer
  -n, --nocenter        Do not center timer (more efficient)
```

The work timer starts instantly, you can skip a timer by pressing CTRL+C.

To close the program, press CTRL+C twice.

## Installation

Clone this repo, then run:
`python pomodoro-timer`