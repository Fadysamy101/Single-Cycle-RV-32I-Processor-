module Program_Counter
(
    input clk,
    input reset,
    input load,
    input [31:0] PCNext,
    output reg [31:0] PC_out
);
    always @(posedge clk or negedge reset) 
    begin
        if (reset == 0) 
            PC_out <= 32'h00000000; 
        else if(load == 1)
            PC_out <= PCNext;
        else
            PC_out <= PC_out;
    end
 endmodule   