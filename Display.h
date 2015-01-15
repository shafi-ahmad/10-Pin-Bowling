#ifndef DISPLAY_H 
#define DISPLAY_H

#include <iostream>
#include <string>
using namespace std;

class Bowling;
class Display {
public:
	Display();
	~Display();
	void scoreTable(const Bowling &game);
	void finalScore(const Bowling &game);
};

#endif
