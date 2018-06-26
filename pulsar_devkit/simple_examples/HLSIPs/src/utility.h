#include <iostream>
#include <iomanip>
#include <algorithm>
#include <string>
#include <cmath>
#include <vector>

template<class data_type, int TABLE_SIZE>
void show(data_type data[], int width=80, int minimum=0, int maximum=-1, std::ostream &stream=std::cout, std::string title="") {
	if (minimum < 0) {
		minimum *= 1.05;
	}
	else {
		minimum = 0;
	}

	if (maximum == -1) {
		maximum = *std::max_element(data,data+TABLE_SIZE) * 1.05;
	}

	if (maximum <= minimum) {
		float average = (minimum + maximum) / 2.0;
		minimum = average - 0.5;
		maximum = average + 0.5;
	}

	std::string intervals[TABLE_SIZE];
	std::string values[TABLE_SIZE];
	char buffer [128];
	int intervalswidth = 0, valueswidth = 0, tmpwidth = 0;
	for (int i = 0; i<TABLE_SIZE; i++) {
		//Format the bin labels
		tmpwidth = sprintf(buffer,"[%-.5g, %-.5g)",float(i),float(i+1));
		intervals[i] = buffer;
		if (i == TABLE_SIZE-1) {
			intervals[i][intervals[i].size()-1] = ']';
		}
		if (tmpwidth > intervalswidth) intervalswidth = tmpwidth;

		//Format the values
		tmpwidth = sprintf(buffer,"%-.5g",float(data[i]));
		values[i] = buffer;
		if (tmpwidth > valueswidth) valueswidth = tmpwidth;
	}

	sprintf(buffer,"%-.5g",float(minimum));
	std::string minimumtext = buffer;
	sprintf(buffer,"%-.5g",float(maximum));
	std::string maximumtext = buffer;


	int plotwidth = std::max(int(minimumtext.size() + maximumtext.size()), width - (intervalswidth + 1 + valueswidth + 1 + 2));
	std::string scale = minimumtext + std::string(plotwidth + 2 - minimumtext.size() - maximumtext.size(), ' ') + maximumtext;

	float norm = float(plotwidth) / float(maximum - minimum);
    int zero = std::round((0.0 - minimum)*norm);
    std::vector<char> line(plotwidth,'-'); 

    if ( (minimum != 0) && (0 <= zero) && (zero < plotwidth) ) {
    	line[zero] = '+';
    }
    std::string capstone = std::string(intervalswidth + 1 + valueswidth + 1, ' ') + "+" + std::string(line.begin(),line.end()) + "+";

    std::vector<std::string> out;
    if(!title.empty()) {
    	out.push_back(title);
    	out.push_back(std::string(title.size(),'='));
    }
    out.push_back(std::string(intervalswidth + valueswidth + 2, ' ') + scale);
    out.push_back(capstone);
    for (int i = 0; i < TABLE_SIZE; i++) {
    	std::string interval = intervals[i];
    	std::string value = values[i];
    	data_type x = data[i];
    	std::fill_n(line.begin(), plotwidth, ' ');

    	int pos = std::round((x - minimum)*norm);
    	if (x < 0) {
    		std::fill_n(line.begin()+pos, zero-pos, '*');
    	}
    	else {
    		std::fill_n(line.begin()+zero, pos-zero, '*');
    	}

    	if ( (minimum != 0) && (0 <= zero) && (zero < plotwidth) ) {
    		line[zero] = '|';
    	}

    	sprintf(buffer,"%-*s %-*s |%s|",intervalswidth,interval.c_str(),valueswidth,value.c_str(),std::string(line.begin(),line.end()).c_str());
    	out.push_back(buffer);
    }
    out.push_back(capstone);
    for (auto o : out) {
    	stream << o << "\n";
    }
    stream << "\n";
}