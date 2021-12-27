`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2021 01:33:59 PM
// Design Name: 
// Module Name: ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ram(
 //TODO
    );
    
  //  Xilinx Single Port Write First RAM
  //  This code implements a parameterizable single-port write-first memory where when data
  //  is written to the memory, the output reflects the same data being written to the memory.
  //  If the output data is not needed during writes or the last read value is desired to be
  //  it is suggested to use a No Change as it is more power efficient.
  //  If a reset or enable is not necessary, it may be tied off or removed from the code.
  //  Modify the parameters for the desired RAM characteristics.

  parameter RAM_WIDTH = <width>;                  // Specify RAM data width
  parameter RAM_DEPTH = <depth>;                  // Specify RAM depth (number of entries)
  parameter RAM_PERFORMANCE = "HIGH_PERFORMANCE"; // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
  parameter INIT_FILE = "";                       // Specify name/location of RAM initialization file if using one (leave blank if not)

  <wire_or_reg> [clogb2(RAM_DEPTH-1)-1:0] <addra>;  // Address bus, width determined from RAM_DEPTH
  <wire_or_reg> [RAM_WIDTH-1:0] <dina>;           // RAM input data
  <wire_or_reg> <clka>;                           // Clock
  <wire_or_reg> <wea>;                            // Write enable
  <wire_or_reg> <ena>;                            // RAM Enable, for additional power savings, disable port when not in use
  <wire_or_reg> <rsta>; 			  // Output reset (does not affect memory contents)
  <wire_or_reg> <regcea>;                         // Output register enable
  wire [RAM_WIDTH-1:0] <douta>;                   // RAM output data

  reg [RAM_WIDTH-1:0] <ram_name> [RAM_DEPTH-1:0];
  reg [RAM_WIDTH-1:0] <ram_data> = {RAM_WIDTH{1'b0}};

  // The following code either initializes the memory values to a specified file or to all zeros to match hardware
  generate
    if (INIT_FILE != "") begin: use_init_file
      initial
        $readmemh(INIT_FILE, <ram_name>, 0, RAM_DEPTH-1);
    end else begin: init_bram_to_zero
      integer ram_index;
      initial
        for (ram_index = 0; ram_index < RAM_DEPTH; ram_index = ram_index + 1)
          <ram_name>[ram_index] = {RAM_WIDTH{1'b0}};
    end
  endgenerate

  always @(posedge <clka>)
    if (<ena>)
      if (<wea>) begin
        <ram_name>[<addra>] <= <dina>;
        <ram_data> <= <dina>;
      end else
        <ram_data> <= <ram_name>[<addra>];

  //  The following code generates HIGH_PERFORMANCE (use output register) or LOW_LATENCY (no output register)
  generate
    if (RAM_PERFORMANCE == "LOW_LATENCY") begin: no_output_register

      // The following is a 1 clock cycle read latency at the cost of a longer clock-to-out timing
       assign <douta> = <ram_data>;

    end else begin: output_register

      // The following is a 2 clock cycle read latency with improve clock-to-out timing

      reg [RAM_WIDTH-1:0] douta_reg = {RAM_WIDTH{1'b0}};

      always @(posedge <clka>)
        if (<rsta>)
          douta_reg <= {RAM_WIDTH{1'b0}};
        else if (<regcea?)
          douta_reg <= <ram_data>;

      assign <douta> = douta_reg;

    end
  endgenerate

  //  The following function calculates the address width based on specified RAM depth
  function integer clogb2;
    input integer depth;
      for (clogb2=0; depth>0; clogb2=clogb2+1)
        depth = depth >> 1;
  endfunction
						
					
endmodule
