# Makefile

CXX = g++
CXXFLAGS = -std=c++17 -O2 -Wall -Wextra -g -fsanitize=undefined,address

SRC_DIR = $(dir $(SRC))
SRC_FILE = $(notdir $(SRC))

$(SRC_DIR)$(basename $(SRC_FILE)).out: $(SRC)
	$(CXX) $(CXXFLAGS) -o $@ $^

.PHONY: clean
clean:
	rm -f $(SRC_DIR)*.out
