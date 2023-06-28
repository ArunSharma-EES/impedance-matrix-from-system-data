# impedance-matrix-from-system-data
 
 In this code (MATLAB), We read system data from an excel sheet, and then calculate z-matrix and upload it in another excel sheet.

 Z-bus Building algorithm in MATLAB

input file: "System Data.xlsx" (a sample file is uploaded along with the code)

Bus Data: 1) "BUS" - indicating the bus number
	  2) "Bus_Susceptance" - indicating respective bus's shunt suscepatance without "j"

Line Data: 1) "From_bus" - indicating from bus
	   2) "To_Bus" - indicating to bus
	   3) "R" - indicating the real part of Z from pi model of line
	   4) "X" - indicating the imaginary part of Z from pi model of line
	   5) "B" - indicating the imaginary part of Y from pi model of line (not B/2)


Output file: "Arun Sharma 2078EES2078" (the output are two matrices,real and imaginary part of Z-bus Matrix)

 Arun Sharma
