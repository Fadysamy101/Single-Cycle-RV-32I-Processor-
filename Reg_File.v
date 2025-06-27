module Reg_File #(parameter Width = 32 ,Address_Width = 5)
(input clk,
 input reset,
 input [Address_Width-1:0] A1,A2,A3,
 input [Width-1:0] WD3,
 input WE3,
 output  [Width-1:0] RD1,
 output  [Width-1:0] RD2
);

reg [Width-1:0] Register_File [(1 << Address_Width)-1:0];
integer i;

always @(posedge clk)
begin
    if (reset == 0) begin
        // Initialize all registers to zero when reset is asserted
        for (i = 0; i < (1 << Address_Width); i = i + 1) begin
            Register_File[i] <= {Width{1'b0}};
        end
    end
    else if (WE3 == 1) begin
        Register_File[A3] <= WD3;
    end
end

assign RD1 = (reset == 0) ? {Width{1'b0}} : Register_File[A1];
assign RD2 = (reset == 0) ? {Width{1'b0}} : Register_File[A2];

endmodule