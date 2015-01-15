CC=g++
CFLAGS=-c -Wall
LDFLAGS=
SRCS=Bowling.cpp  Display.cpp  Player.cpp
HEADERS=Bowling.h  Display.h  Player.h 
OBJECTS=$(SRCS:.cpp=.o)
EXECUTABLE=bowling

all: $(SRCS) $(EXECUTABLE) $(HEADERS)
	
$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@

Bowling.o: Bowling.cpp Bowling.h Player.h Display.h
Display.o: Display.cpp Display.h
Player.o: Player.cpp Player.h

clean:
	rm -rf *.o bowling 
