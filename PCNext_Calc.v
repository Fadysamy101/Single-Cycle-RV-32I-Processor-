module PCNext_Calc
(input [31:0] PC,
 input [31:0] ImmExt,
 input PCSrc,
 output [31:0]PCNext
);
    wire [31:0] PCPlus4;
    wire [31:0] PCBranch;

    assign PCPlus4 = PC + 4;
    assign PCBranch = PC + ImmExt;
    assign PCNext = (PCSrc) ? PCBranch : PCPlus4;
endmodule