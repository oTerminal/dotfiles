//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{" ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},

	{"📅 " , "date '+%b %d (%a) %I:%M%p'",					5,		0},

	{"",	"dwm_battery",	5,	3},
	{"",	"dwm_weather",	18000,	5},
	{" 🔊 ", "dwm_volume",			2,		            10},
	{"☀ ", 	"dwm_backlight",	2,	10}
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
