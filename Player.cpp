#include "Player.h"

Player::Player() {
	m_scores.reserve(10);
	m_ballNum = 0;
}

Player::~Player() { }

int Player::bowlBall(int currentFrame) {
	int scoreThisBowl = -1;
   printf("Number of pins were hit for this bowl: ");
   scanf("%d", &scoreThisBowl);
   // Validate the input score
	if(!isValidScore(scoreThisBowl, currentFrame)){
      // Failure case
      return scoreThisBowl + m_currentScore.m_ball[0];
   }
   // Update the score table	
	for (int i = 0; i < (int)m_scores.size(); i++) {
		m_scores[i].update(scoreThisBowl);
   }
   // Update the score for each shot in a particular frame
	m_currentScore.setScore(m_ballNum, scoreThisBowl);
	m_ballNum++;
	if (m_ballNum == 1 && !m_currentScore.isStrike()) {
		return 0;
   }
   // Special case for final frame
	if (currentFrame == 10)	{
		 if (m_ballNum == 1) {
			return 0;
       }
	    else if (m_ballNum == 2) {
		    if (m_currentScore.isStrike() || m_currentScore.isSpare()) {
			    return 0;
          }
		    else if (!m_currentScore.isSpare()) {
			    m_currentScore.setScore(2, 0);
          }
	    }
	}
	m_scores.push_back(m_currentScore);
	m_currentScore = Score();
   // Reset the ballNum for next frame.
	m_ballNum = 0;
   // End of all shots in each frame  
	return 1;
}

// Return totla score
int Player::calcScore() {
	int totalScore = 0;
	if (m_scores.empty()) {
      return 0;
   }
	for (int i = 0; i < (int)m_scores.size(); i++) {
		totalScore += m_scores[i].getTotal();
   }
	return totalScore;
}

// Check whether entered number of pins are valid
bool Player::isValidScore(int score, int frame) {
	if (score < 0 || score > 10) {
		return false;
   }
	if (frame != 10) {
		if (m_ballNum == 1 && m_currentScore.m_ball[0] + score > 10) {
			return false;
      }
		if (m_ballNum == 2) {
			return false;
      }
	}
	return true;
}


// Create object of Score class
Score::Score() {
    m_total = 0;
    m_ball[0] = 0;
    m_ball[1] = 0;
    m_ball[2] = 0;
}

// Return current score in string formate
string Score::getScore(int id){
    char buffer[4];
    if (id < 0 || id > 2) {
        return "";
    }
    if (m_ball[id] == 0) {
        return "-";
    }
    if (m_ball[id] == 10) {
        return "X";
    }
    if (id == 1 && m_ball[0] + m_ball[1] == 10) {
        return "/";
    }
    snprintf(buffer, 4, "%d", m_ball[id]);
    return buffer;
}

// Assign score to m_ball array
void Score::setScore(int id, int score) {
    // Error case
    if (id < 0 || id > 2) { 
        return;
    }
    // Set the score for particular ball in a frame
    m_ball[id] = score;
    if (id != 2) {
        // Calculate the total score for current frame
        m_total = m_ball[0] + m_ball[1];
        m_ball[2] = isStrike() ? 2 : isSpare() ? 1 : 0;
    }
    else {
        m_total = m_ball[0] + m_ball[1] + m_ball[2];
    }
}

// Update the total score for particula frame if there is Strike/Spare
void Score::update(int pinsDown) {
    if (m_ball[2] > 0) {
        m_total += pinsDown;
        m_ball[2]--;
    }
}

// Check if current shot is Strik - all pins are down
bool Score::isStrike() { 
    return (m_ball[0] == 10); 
}
// Check if current shot leads to Spare - 1st Shot + 2nd Shot = 10 pins
bool Score::isSpare() { 
    return (!isStrike() && m_ball[0] + m_ball[1] == 10); 
}
// Check whether we have to look for 2nd and 3rd ball 
bool Score::isOpen() { 
    return (m_ball[2] != 0); 
}
// Return tola score for current frame
int Score::getTotal() {
    return m_total;
}
