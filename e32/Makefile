CXX			:= g++
CXXFLAGS	:= -Wall -std=c++11

TARGET		:= e32
PROJ_ROOT	:= $(realpath .)
INCLUDES	:= `pkg-config opencv --cflags`
SRCS		:= e32.cpp
LIBS		:= `pkg-config opencv --libs`
OBJS		:= $(SRCS:.cpp=.o)

### Rules ######################################################################

.PHONY: all
all: $(TARGET)

.PHONY: make
make: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) -o $@ $(OBJS) $(LIBS)

.PHONY: clean
clean:
	$(RM) $(TARGET) *.o

.cpp.o:
	$(CXX) -c $(CXXFLAGS) $(INCLUDES) $<