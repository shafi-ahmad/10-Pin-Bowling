#ifndef PLAYER_H
#define PLAYER_H

#include <vector>
#include <stdio.h>
#include <string>
#include "Display.h"

using namespace std;
class Score {
  public:
    Score();
    string getScore(int id);
    void setScore(int id, int score);
    void update(int pinsDown);
    bool isStrike();
    bool isSpare();
    bool isOpen();
    int getTotal();
    int m_ball[3];
  private:
    int m_total;
};

class Player {
  public:
	Player();
	~Player();
	const vector<Score> getScores(){ return m_scores; }
	void addScore(int first, int second);
	int bowlBall(int currentFrame);
	int calcScore();

  private:
	bool    isValidScore(int score, int frame);
	Score   m_currentScore;
	int     m_ballNum;
	vector<Score> m_scores;
};
#endif
