Data Dictionary for the variables of NBA data

team_name,game_date,season,period,minutes_remaining,seconds_remaining,shot_made_flag,action_type,shot_type,shot_distance,opponent,x,y

team_name: name of the NBA team
game_date: date of the game played
season: what season (year) the game was played
period: which period of the game? 
- one game is divided into 4 periods of 12 minutes each
- period: 1 would mean it is in the first 12 minutes of the game
minutes_remaining: amount of time in minutes that remained to be played in a given period
seconds_remaining: amount of time in seconds that remained to be played in a given period
shot_made_flag: tells us whether a shot was made 
- y: yes
- n: no (show was missed)
action_type: basketball move made by the player, either to pass by defenders to gain access to the basket, or to get a clean pass to a teammate to score a 2-pointer or 3-pointer
- example: Cutting Finger Roll Layup Shot
- example: Driving Floating Jump Shot
shot_type: indicates what type of shot was made
- 2PT (point) Field Goal or 3PT (point) Field Goal
shot_distance: distance to the basket, measured in feet
opponent: opposing team the game was played against
x: x coordinate of where a shot occurred on the court, measured in inches
- negative or positive
y: y coordinate of where a shot occurred on the court, measured in inches
- negative or positive