
#include "ptr_vector.hpp"

int main(int argc, char** av) {
	ptr_vector <int> pv;
	int val=12;
	pv.push_back(&val);


	return 0;

}
