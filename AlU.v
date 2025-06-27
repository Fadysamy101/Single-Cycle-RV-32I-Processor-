module ALU
(
    input [31:0] src1,
    input [31:0] src2,
    input [2:0] ALUControl,
    output reg [31:0] Result,
    output reg Zero,
    output reg Signflag
    
);
 always @(*) 
 begin
    case(ALUControl)
        3'b000: Result = src1+ src2; // ADD
        3'b001: Result = src1<< src2; 
        3'b010: Result = src1- src2; 
        3'b100: Result = src1^ src2; 
        3'b101: Result = src1>> src2; 
        3'b110: Result = src1| src2; 
        3'b111: Result = src1& src2; 
        default: Result = 32'h00000000; // Default case
    endcase
 
    Zero = (Result == 32'b00000000) ? 1 : 0; 
    Signflag = Result[31]; 
 end

endmodule