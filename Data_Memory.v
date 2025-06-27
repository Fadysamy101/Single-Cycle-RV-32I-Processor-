module Data_Memory #(parameter Width = 32, Address_Width = 6)
(
    input clk,
    input reset,
    input [31:0] A,
    input [31:0] WD,
    input WE,
    output [31:0] RD
);

reg [Width-1:0] Memory [(1 << Address_Width)-1:0];
integer i;

always @(posedge clk)
begin
    if (reset == 0) begin
        // Initialize all memory locations to zero when reset is asserted
        for (i = 0; i < (1 << Address_Width); i = i + 1) begin
            Memory[i] <= {Width{1'b0}};
        end
    end
    else if (WE == 1) begin
        Memory[A[31:2]] <= WD;
    end
end

assign RD = (reset == 0) ? {Width{1'b0}} : Memory[A[31:2]];

endmodule