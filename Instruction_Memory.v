module Instruction_Memory #(parameter Width = 32 ,Address_Width = 6)
(input [31:0] PC,
 output  [31:0] Instruction

);
     reg [Width-1:0] instr [(1<<Address_Width)-1:0];
     assign Instruction = instr[PC[31:2]]; 

     initial 
		  begin
        $readmemh("program.mem", instr);  
        $display("Program loaded into instruction memory");
         end

endmodule     