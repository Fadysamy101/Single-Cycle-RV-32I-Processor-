module Control_Unit
(input [6:0] op,
 input [2:0]funct3, 
 input      funct7,
 input  ZeroFlag,
 input  SignFlag,
 //Main Decoder outputs  
 output reg  ALUSrc, 
 output reg [1:0] ImmSrc, 
 output reg RegWrite,
 output reg MemWrite,
 output reg [2:0] ALUControl,
 output reg ResultSrc,
 //Branch output
 output reg PCSrc
 //HLT
 //output reg HLT

);
reg Branch;
reg [1:0]ALUOP;
wire [1:0]Choice;
assign Choice = {op[5],funct7};
// ALU_Decoder
always @(*)
begin 
    case(ALUOP)
        2'b00: // Load/Store
        begin 
        ALUControl =3'b000;    
        end
        
        2'b01:
        begin
        case(funct3)
            3'b000: ALUControl = 3'b010; // BEQ
            3'b001: ALUControl = 3'b010; // BNE
            3'b100: ALUControl = 3'b010; // BLT
            default: ALUControl = 3'b000; // BGE
        endcase    
        end
        
        2'b10: 
        begin
        case(funct3)
            3'b000:
            if (Choice == 2'b00 || Choice == 2'b01 || Choice == 2'b10)
            ALUControl = 3'b000; // ADD
            else
            ALUControl = 3'b010; // SUB

            3'b001: ALUControl = 3'b001; //SHL
            
            3'b100: ALUControl = 3'b100; // XOR
            3'b101: ALUControl = 3'b101; // SHR
            3'b110: ALUControl = 3'b110; // OR
            3'b111: ALUControl = 3'b111; // AND
            default: ALUControl = 3'b000;
        endcase    
        end
        default: 
        ALUControl = 3'b000; // Default case
    
    endcase
end
// Main Decoder
always @(*)
begin
      case(op)
    7'b0000011: // Load
    begin
        ALUSrc = 1'b1; 
        ImmSrc = 2'b00; 
        RegWrite = 1'b1; 
        MemWrite = 1'b0; 
        ResultSrc = 1'b1;
        Branch    = 0;
        ALUOP     =0;   
    end     
    7'b0100011: // Store
     begin
        ALUSrc = 1'b1; 
        ImmSrc = 2'b01; 
        RegWrite = 1'b0; 
        MemWrite = 1'b1; 
        ResultSrc = 1'b0;
        Branch    = 0;
        ALUOP     =0;   
    end  
    7'b0110011: // R-type
       begin
        ALUSrc = 1'b0; 
        ImmSrc = 2'b00; 
        RegWrite = 1'b1; 
        MemWrite = 1'b0; 
        ResultSrc = 1'b0;
        Branch    = 0;
        ALUOP     =2'b10;
       end 
    7'b0010011: // I-type
    begin
        ALUSrc = 1'b1; 
        ImmSrc = 2'b00; 
        RegWrite = 1'b1; 
        MemWrite = 1'b0; 
        ResultSrc = 1'b0;
        Branch    = 0;
        ALUOP     =2'b10;   
    end

    7'b1100011: //Branch
    begin
        ALUSrc = 1'b0; 
        ImmSrc = 2'b10; 
        RegWrite = 1'b0; 
        MemWrite = 1'b0; 
        ResultSrc = 1'b0;
        Branch    = 1;
        ALUOP     =2'b01;
           
    end
    default:
    begin
        ALUSrc = 1'b0; 
        ImmSrc = 2'b00; 
        RegWrite = 1'b0; 
        MemWrite = 1'b0; 
        ResultSrc = 1'b0;
        Branch    = 0;
        ALUOP     =2'b00; 
    end      
    endcase      
end  
// Branch Logic
always @(*)
begin
 case(funct3)
    3'b000: PCSrc = ZeroFlag&Branch; // BEQ
    3'b001: PCSrc = ~ZeroFlag&Branch; // BNE
    3'b100: PCSrc = SignFlag&Branch; // BLT
    //3'b101: PCSrc = ~SignFlag&Branch; 
    default: PCSrc = 0; // Default case
 endcase  
end         
endmodule