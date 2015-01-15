diff --git a/Bowling.cpp b/Bowling.cpp
index 72fff38..7b266c2 100755
--- a/Bowling.cpp
+++ b/Bowling.cpp
@@ -5,34 +5,34 @@ Bowling::Bowling() { }
 Bowling::~Bowling() { }
 
 int Bowling::runGame() {
-    int frame = 0;
+   int frame = 0;
 	int turnEnded = 0;
-    for(; ;){
-        frame++;
-        // End of game, played 10 frames 
-	    if (frame > 10)	{
-		    display.finalScore(*this);
-		    return 0;
-	    }
-        // Wrong number of pins entered 
-        if(turnEnded > 10 || turnEnded < 0) {
-		    display.scoreTable(*this);
-		    display.finalScore(*this);
-            printf("Wrong number of pins [1st shot + 2nd shot = %d] entered\n",turnEnded);
-            return turnEnded;
-        }
-        turnEnded = 0;
-        // Process bowlings
-	    while (turnEnded == 0) {
-		    display.scoreTable(*this);
-		    turnEnded = m_player.bowlBall(frame);
-	    }
-    }
+   for(; ;) {
+      frame++;
+      // End of game, played 10 frames 
+	   if (frame > 10)	{
+	      display.finalScore(*this);
+		   return 0;
+	   }
+      // Wrong number of pins entered 
+      if(turnEnded > 10 || turnEnded < 0) {
+		   display.scoreTable(*this);
+		   display.finalScore(*this);
+         printf("Wrong number of pins [1st shot + 2nd shot = %d] entered\n",turnEnded);
+         return turnEnded;
+      }
+      turnEnded = 0;
+      // Process bowlings
+	   while (turnEnded == 0) {
+		   display.scoreTable(*this);
+		   turnEnded = m_player.bowlBall(frame);
+	   }
+   }
 	return 0;
 }
 
 int main(int argc, char *argv[]) {
-    Bowling game;
-    int status = game.runGame();
-    return status;
+   Bowling game;
+   int status = game.runGame();
+   return status;
 }
diff --git a/Bowling.h b/Bowling.h
index f136518..61b1b8b 100755
--- a/Bowling.h
+++ b/Bowling.h
@@ -7,14 +7,13 @@
 
 using namespace std;
 class Bowling {
-  public:
-	Bowling();
+ public:
+   Bowling();
 	~Bowling();
 	int runGame();
 	const Player getPlayer() const { return m_player; }
-  private:
+ private:
 	Player m_player; // Single player game
-    Display display; // Display the output 
+   Display display; // Display the output 
 };
-
 #endif
diff --git a/Display.cpp b/Display.cpp
index 56e8a19..360e0a2 100755
--- a/Display.cpp
+++ b/Display.cpp
@@ -12,28 +12,28 @@ void Display::scoreTable(const Bowling &game) {
 	vector<Score> scores = player.getScores();
 	printf("\n");
 	printf("Frame Number:     0    1    2    3    4    5    6    7    8    9  \n");
-    printf("Score Per Ball: ");
-    // Displya pins at every shot
+   printf("Score Per Ball: ");
+   // Displya pins at every shot
 	for (int j = 0; j < 10; j++) {
 		if (j < (int)scores.size()) {
 			printf(" %s+%s ", scores[j].getScore(0).c_str(), scores[j].getScore(1).c_str());
 			if (j == 9) {
 				printf("%s", scores[j].getScore(2).c_str());
-            }
+         }
 		}
 	}
-    printf("\n");
+   printf("\n");
 
-    // Display total score in every frame
-    printf("Total Score:    ");
+   // Display total score in every frame
+   printf("Total Score:    ");
 	int totalScore = 0;
 	for (int j = 0; j < 10; j++) {
 		if (j < (int)scores.size() && (!scores[j].isOpen() || j == 9)) {
 			totalScore += scores[j].getTotal();
-            printf(" %3d ", totalScore);
+         printf(" %3d ", totalScore);
 		}
 	}
-    printf("\n\n");
+   printf("\n\n");
 }
 
 // Display final score
diff --git a/Display.h b/Display.h
index 32bccad..7f15ec7 100755
--- a/Display.h
+++ b/Display.h
@@ -7,11 +7,10 @@ using namespace std;
 
 class Bowling;
 class Display {
-public:
+  public:
 	Display();
 	~Display();
 	void scoreTable(const Bowling &game);
 	void finalScore(const Bowling &game);
 };
-
 #endif
diff --git a/Player.cpp b/Player.cpp
index a293da8..7ef10af 100755
--- a/Player.cpp
+++ b/Player.cpp
@@ -9,42 +9,42 @@ Player::~Player() { }
 
 int Player::bowlBall(int currentFrame) {
 	int scoreThisBowl = -1;
-    printf("How many pins were hit on this bowl? :");
-    scanf("%d", &scoreThisBowl);
-    // Validate the input score
+   printf("Number of pins were hit for this bowl: ");
+   scanf("%d", &scoreThisBowl);
+   // Validate the input score
 	if(!isValidScore(scoreThisBowl, currentFrame)){
-        // Failure case
-        return scoreThisBowl + m_currentScore.m_ball[0];
-    }
-    // Update the score table	
+      // Failure case
+      return scoreThisBowl + m_currentScore.m_ball[0];
+   }
+   // Update the score table	
 	for (int i = 0; i < (int)m_scores.size(); i++) {
 		m_scores[i].update(scoreThisBowl);
-    }
-    // Update the score for each shot in a particular frame
+   }
+   // Update the score for each shot in a particular frame
 	m_currentScore.setScore(m_ballNum, scoreThisBowl);
 	m_ballNum++;
 	if (m_ballNum == 1 && !m_currentScore.isStrike()) {
 		return 0;
-    }
-    // Special case for final frame
+   }
+   // Special case for final frame
 	if (currentFrame == 10)	{
-		if (m_ballNum == 1) {
+		 if (m_ballNum == 1) {
 			return 0;
-        }
+       }
 	    else if (m_ballNum == 2) {
 		    if (m_currentScore.isStrike() || m_currentScore.isSpare()) {
 			    return 0;
-            }
+          }
 		    else if (!m_currentScore.isSpare()) {
 			    m_currentScore.setScore(2, 0);
-            }
+          }
 	    }
 	}
 	m_scores.push_back(m_currentScore);
 	m_currentScore = Score();
-    // Reset the ballNum for next frame.
+   // Reset the ballNum for next frame.
 	m_ballNum = 0;
-    // End of all shots in each frame  
+   // End of all shots in each frame  
 	return 1;
 }
 
@@ -52,11 +52,11 @@ int Player::bowlBall(int currentFrame) {
 int Player::calcScore() {
 	int totalScore = 0;
 	if (m_scores.empty()) {
-        return 0;
-    }
+      return 0;
+   }
 	for (int i = 0; i < (int)m_scores.size(); i++) {
 		totalScore += m_scores[i].getTotal();
-    }
+   }
 	return totalScore;
 }
 
@@ -64,14 +64,14 @@ int Player::calcScore() {
 bool Player::isValidScore(int score, int frame) {
 	if (score < 0 || score > 10) {
 		return false;
-    }
+   }
 	if (frame != 10) {
 		if (m_ballNum == 1 && m_currentScore.m_ball[0] + score > 10) {
 			return false;
-        }
+      }
 		if (m_ballNum == 2) {
 			return false;
-        }
+      }
 	}
 	return true;
 }
