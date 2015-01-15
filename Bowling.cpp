#include "Bowling.h"
#include "Display.h"

Bowling::Bowling() { } 
Bowling::~Bowling() { }

int Bowling::runGame() {
    int frame = 0;
	int turnEnded = 0;
    for(; ;){
        frame++;
        // End of game, played 10 frames 
	    if (frame > 10)	{
		    display.finalScore(*this);
		    return 0;
	    }
        // Wrong number of pins entered 
        if(turnEnded > 10 || turnEnded < 0) {
		    display.scoreTable(*this);
		    display.finalScore(*this);
            printf("Wrong number of pins [1st shot + 2nd shot = %d] entered\n",turnEnded);
            return turnEnded;
        }
        turnEnded = 0;
        // Process bowlings
	    while (turnEnded == 0) {
		    display.scoreTable(*this);
		    turnEnded = m_player.bowlBall(frame);
	    }
    }
	return 0;
}

int main(int argc, char *argv[]) {
    Bowling game;
    int status = game.runGame();
    return status;
}
