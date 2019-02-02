/*
* File: thermo.v
* Author: Cody Hatfield - cxh124730
* Modules:
*	testbench
*	Thermostat
*/


/*
* Module: testbench - The test bench to demonstrate the functionality of the thermostat module
* Author: Cody Hatfield - cxh124730
* Ports: None
*/
module testbench();
	// 3 bit outputs to send the values of the preset and the current temperatures to the
	// Thermostat module
	output [2:0] presetTemp, currentTemp;

	// 1 bit input to receive the status of the fan - 0 = off, 1 = on
	input fanOn;

	// Declare the preset and current temperatures as registers, so that they can hold values
	reg presetTemp;
	reg currentTemp;

	// Instantiate the Thermostat module, passing the necessary ports
	Thermostat thermostat(presetTemp, currentTemp, fanOn);
	
	// Loop which executes only once during startup. Displays initial column info, assigns the
	// presetTemp to its default value, then cycles through all possible values of currentTemp
	initial begin
		// Display the column headers for the ouput
		$display(" Preset Current  Fan");

		// Set the presetTemp to its default value
		assign presetTemp = 3;

		// Cycle through all values of the currentTemp, with a 10ns delay between each iteration
		// to ensure enough time to output simulation status with each new iteration.
		assign currentTemp = 0;
		#10 assign currentTemp = 1;
		#10 assign currentTemp = 2;
		#10 assign currentTemp = 3;
		#10 assign currentTemp = 4;
		#10 assign currentTemp = 5;
		#10 assign currentTemp = 6;
		#10 assign currentTemp = 7;

		// Exit the simulation gracefully, with a 50ns delay before doing so as a precaution
		#50 $finish;
	end

	// Continuous loop which outputs simulation info with each new iteration of currentTemp
	always @(currentTemp)
		// Line to output the simulation info, demonstrating when the fan is turned on
		$display("# %b     %b  -> %b", presetTemp, currentTemp, fanOn);
endmodule

/*
* Module: Thermostat - a module which changes the status of the fan based on the current 
*						and preset temperatures
* Author: Cody Hatfield - cxh124730
* Ports:
*		presetTemp   :   input   :   A three bit input that holds the preset temperature at
*											which the fan on will turn on
*		currentTemp   :   input   : A three bit input that holds the current temperature
* 		
*		fanOn   :   wire   :		A one bit output wire that signals when the fan is turned on
*/
module Thermostat(presetTemp, currentTemp, fanOn);
	// 3 bit inputs, which receive the presetTemp and the currentTemp from the testbench module
	input [2:0] presetTemp, currentTemp;

	// 1 bit output, which sends the status of the fan back to the testbench based on the values
	// of the preset and current temperatures
	output fanOn;
	
	// Declare the fanOn output as a wire, and send the result of the comparison between current
	// and preset temperatures back to the testbench module
	wire fanOn = (currentTemp > presetTemp);
endmodule

