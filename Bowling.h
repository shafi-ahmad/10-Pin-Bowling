#ifndef BOWLING_H
#define BOWLING_H

#include <string>
#include <vector>
#include "Player.h"

using namespace std;
class Bowling {
  public:
	Bowling();
	~Bowling();
	int runGame();
	const Player getPlayer() const { return m_player; }
  private:
	Player m_player; // Single player game
    Display display; // Display the output 
};

#endif
