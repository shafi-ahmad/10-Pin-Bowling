#include "Display.h"
#include "Bowling.h"
#include "Player.h"
#include <stdio.h>

Display::Display() { }
Display::~Display() { }

// Display score table
void Display::scoreTable(const Bowling &game) {
	Player player = game.getPlayer();
	vector<Score> scores = player.getScores();
	printf("\n");
	printf("Frame Number:     0    1    2    3    4    5    6    7    8    9  \n");
    printf("Score Per Ball: ");
    // Displya pins at every shot
	for (int j = 0; j < 10; j++) {
		if (j < (int)scores.size()) {
			printf(" %s+%s ", scores[j].getScore(0).c_str(), scores[j].getScore(1).c_str());
			if (j == 9) {
				printf("%s", scores[j].getScore(2).c_str());
            }
		}
	}
    printf("\n");

    // Display total score in every frame
    printf("Total Score:    ");
	int totalScore = 0;
	for (int j = 0; j < 10; j++) {
		if (j < (int)scores.size() && (!scores[j].isOpen() || j == 9)) {
			totalScore += scores[j].getTotal();
            printf(" %3d ", totalScore);
		}
	}
    printf("\n\n");
}

// Display final score
void Display::finalScore(const Bowling &game) {
	scoreTable(game);
	Player player = game.getPlayer();
	int score = player.calcScore();
	cout << "The total score is " << score << " points.\n\n";
}
