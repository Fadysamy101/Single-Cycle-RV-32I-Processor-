module Top_Module #(parameter Width = 32, Address_Width = 5)
(
    input clk,
    input reset
    
);  //PC
    wire [31:0] PC_out;
    // PCNext
    wire [31:0] PCNext_from_PCNext_Calc;
    //instruction
    wire [31:0] instruction_out;
    // Control signals
    wire  ALUSrc;
    wire [1:0] ImmSrc; 
    wire RegWrite;
    wire MemWrite;
    wire [2:0] ALUControl;
    wire ResultSrc;
    wire PCSrc;
    //wire HLT;
    //Data Memory
    wire [31:0] DataMemory_out;
    //Register File
    wire [31:0] RD1, RD2;
    //ALU
    wire [31:0] ALUResult;
    //Muxes_Outputs
    wire [31:0] Result_to_RegFile;
    wire [31:0] Src2_from_Mux;
    //Sign Extend
    wire [31:0] Sign_Extend_out;
    wire ZeroFlag;
    wire SignFlag;
    //PC_Src
     
    Control_Unit Controller  (
        .op(instruction_out[6:0]),
        .funct3(instruction_out[14:12]),
        .funct7(instruction_out[30]),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ResultSrc(ResultSrc),
        .PCSrc(PCSrc),
        .ZeroFlag(ZeroFlag),
        .SignFlag(SignFlag)
       
    );
    Sign_Extend Sign_Extend (
        .ImmSrc(ImmSrc), 
        .instr(instruction_out), 
        .ImmExt(Sign_Extend_out) 
    );
    PCNext_Calc PCNext_Calc (
        .PC(PC_out),
        .ImmExt(Sign_Extend_out), 
        .PCSrc(PCSrc), 
        .PCNext(PCNext_from_PCNext_Calc) 
    );
    
    Program_Counter PC (
        .clk(clk),
        .reset(reset),
        .load(1'b1), 
        .PCNext(PCNext_from_PCNext_Calc), 
        .PC_out(PC_out)
    );
   Instruction_Memory #(Width, Address_Width) IM (
        .PC(PC_out),
        .Instruction(instruction_out) 
    );
	  
    assign Result_to_RegFile = ResultSrc ? DataMemory_out : ALUResult; 

    Reg_File #(Width, Address_Width) RF (
        .clk(clk),
        .reset(reset),
        .A1(instruction_out[19:15]), 
        .A2(instruction_out[24:20]), 
        .A3(instruction_out[11:7 ]), 
        .WD3(Result_to_RegFile), 
        .WE3(RegWrite), 
        .RD1(RD1),
        .RD2(RD2)  
    );
    
    Data_Memory #(Width, Address_Width) DM (
        .clk(clk),
        .reset(reset),
        .A(ALUResult), 
        .WD(RD2), 
        .WE(MemWrite), 
        .RD(DataMemory_out) 
    );
    assign Src2_from_Mux = ALUSrc ?Sign_Extend_out :RD2; // Example immediate value
    ALU ALU (
        .src1(RD1), 
        .src2(Src2_from_Mux), 
        .ALUControl(ALUControl),
        .Result(ALUResult),
        .Zero(ZeroFlag),
        .Signflag(SignFlag)
    );
	      

endmodule