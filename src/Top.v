`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 09:06:58
// Design Name: 
// Module Name: Top
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


module Top(
    input reset,
    input clk
    );

    wire [31:0] IF_PC_In;
    //------------------IF-start-----------------//
    //-------------------------------------------//
    
    wire [31:0] IF_PC_Out;
    

    wire [31:0] IF_INST_Out;
    instMemory inst_mem(
        .readAddr(IF_PC_Out),
        .inst(IF_INST_Out)
    );
    //-------------------------------------------//
    //------------------IF-end-------------------//
    wire [31:0] ID_INST;
    wire [31:0] ID_PC_plus_4;

    
    //------------------ID-start-----------------//
    //-------------------------------------------//
    wire [31:0] ID_IMM;
    wire [31:0] ID_SA;
    wire [31:0] ID_RS_DATA;
    wire [31:0] ID_RT_DATA;


    //----------some WB wires are defined here-----------//
    wire WB_WRITE_REG;
    wire [4:0] WB_WRITE_REG_ADDR;
    wire [31:0] WB_WRITE_REG_DATA;
    //-----------------WB wires end----------------------//

    zeroext zext(
        .shamt(ID_INST),
        .data(ID_SA)
    );

    wire ID_SIGN;
    
    signext sext(
        .sign(ID_SIGN),
        .inst(ID_INST),
        .data(ID_IMM)
    );


    wire ID_MEM_TO_REG;
    wire ID_REG_WRITE;
    wire ID_MEM_WRITE;
    wire ID_MEM_READ;
    wire [3:0] ID_ALU_OP;
    wire ID_ALU_SRC_A;// shamt
    wire ID_ALU_SRC_B; 
    wire ID_BRANCH; // in zero test
    wire ID_BRANCH_NOT;
    wire ID_JUMP;
    wire ID_JR; // in ALUctr
    wire ID_JAL;// put it with JR and J ??
    wire ID_REG_DST;

    Registers registers(
        .clk(clk),
        .reset(reset), //may have to be modified
        .readReg1(ID_INST[25:21]),
        .readReg2(ID_INST[20:16]),
        .readData1(ID_RS_DATA),
        .readData2(ID_RT_DATA),
        .regWrite(WB_WRITE_REG ),
        .writeReg(WB_WRITE_REG_ADDR),
        .writeData(WB_WRITE_REG_DATA),
        .jr(ID_JR),
        .jal(ID_JAL),
        .pcPlus4(ID_PC_plus_4)
    );

    Ctr ctr(
        .opCode(ID_INST[31:26]),
        .regDst(ID_REG_DST),
        .aluSrc(ID_ALU_SRC_B),
        .memToReg(ID_MEM_TO_REG),
        .regWrite(ID_REG_WRITE),
        .memRead(ID_MEM_READ),
        .memWrite(ID_MEM_WRITE),
        .Branch(ID_BRANCH),
        .BranchNot(ID_BRANCH_NOT),
        .ALUOp(ID_ALU_OP),
        .Jump(ID_JUMP),
        .Sign(ID_SIGN),
        .Jal(ID_JAL)
    );

    wire [3:0] ID_ALU_CTR;

    ALUCtr alu_ctr(
        .aluOp(ID_ALU_OP),
        .func(ID_INST[5:0]),
        .aluCtr(ID_ALU_CTR),
        .shamt(ID_ALU_SRC_A),
        .jr(ID_JR)
    );
    //-----------------------------------------//
    //------------------ID-end-----------------//

    wire [1:0] EX_WB;
    wire [1:0] EX_M;
    wire [6:0] EX_EX;
    wire [31:0] EX_PC_plus_4;
    wire [31:0] EX_IMM;
    wire [31:0] EX_SA;
    wire [4:0] EX_RD;
    wire [4:0] EX_RS;
    wire [4:0] EX_RT;
    wire [31:0] EX_RS_DATA;
    wire [31:0] EX_RT_DATA;

   

    //------------------EX-start-----------------//
    //-------------------------------------------//
    wire [31:0] EX_ALU_A;
    wire [31:0] EX_ALU_B;

    

    wire [31:0] EX_ALU_OUT;
    wire EX_OVERFLOW;

    ALU alu(
        .input1(EX_ALU_A),
        .input2(EX_ALU_B),
        .aluCtr(EX_EX[3:0]),
        .aluRes(EX_ALU_OUT),
        .overflow(EX_OVERFLOW)
    );

    wire [4:0] EX_RD_OR_RT;

    MUX5 mux_reg_dst(
        .input0(EX_RT),
        .input1(EX_RD),
        .sel(EX_EX[6]),
        .out(EX_RD_OR_RT)
    );

    //-------------------------------------------//
    //------------------EX-end-----------------//
    wire [1:0] MEM_WB;
    wire [1:0] MEM_M;
    wire [31:0] MEM_ALU_OUT;
    wire [31:0] MEM_MEM_WRITE_DATA;
    wire [31:0] MEM_RD_OR_RT;



    //------------------MEM-start-----------------//
    //-------------------------------------------//
    wire [31:0] MEM_MEM_OUT;

    dataMemory data_mem(
        .clk(clk),
        .address(MEM_ALU_OUT),
        .writeData(MEM_MEM_WRITE_DATA),
        .memWrite(MEM_M[0]),
        .memRead(MEM_M[1]),
        .readData(MEM_MEM_OUT)
    );

    //-------------------------------------------//
    //------------------MEM-end-----------------//
    wire WB_MEM_TO_REG;
    wire [31:0] WB_ALU_OUT;
    wire [31:0] WB_MEM_OUT;

    MEMWB memwb(
        .clk(clk),
        .reset(reset),//to be modified
        .MEM_WB(MEM_WB),
        .MEM_ALUout(MEM_ALU_OUT),
        .MEM_MEMout(MEM_MEM_OUT),
        .MEM_rd_or_rt(MEM_RD_OR_RT),

        .WB_WB({WB_MEM_TO_REG,WB_WRITE_REG}),
        .WB_ALUout(WB_ALU_OUT),
        .WB_MEMout(WB_MEM_OUT),
        .WB_rd_or_rt(WB_WRITE_REG_ADDR)
    );


    //------------------WB-start-----------------//
    //-------------------------------------------//

    MUX mux_write_data(
        .input0(WB_ALU_OUT),
        .input1(WB_MEM_OUT),
        .sel(WB_MEM_TO_REG),
        .out(WB_WRITE_REG_DATA)
    );

    //-------------------------------------------//
    //------------------WB-end-------------------//

    //--------------ZEROTEST--&&--PCMUX-----------------//
    wire ID_ZERO;
    zerotest ztest(
        .Branch(ID_BRANCH),
        .BranchNot(ID_BRANCH_NOT),
        .readData1(ID_RS_DATA),
        .readData2(ID_RT_DATA),
        .aluOut(EX_ALU_OUT),
        .rsAddr(ID_INST[25:21]),
        .rtAddr(ID_INST[20:16]),
        .forAddr(EX_RD_OR_RT),
        .zero(ID_ZERO)
    );
    PCMUX pcmux(
        .input1(((ID_PC_plus_4)&(32'hf0000000))+(ID_INST[25:0]<<2)),        
        .input2((ID_PC_plus_4)+(ID_IMM<<2)),
        .input3(ID_RS_DATA),
        .sel({ID_JR,ID_ZERO,ID_JUMP}),
        .input0(IF_PC_Out+4),
        .out(IF_PC_In)
    );

    //--------------------stall---------------------//
    wire STALL;

    PC pc(
        .clk(clk),
        .reset(reset),//to be replaced
        .stall(STALL),
        .addrIn(IF_PC_In),
        .addrOut(IF_PC_Out)
    );

    IFID ifid(
        .clk(clk),
        .reset(reset),
        .stall(STALL),
        .flush(ID_JR||ID_JUMP||ID_ZERO), // predict-not-taken
        .IF_inst(IF_INST_Out),
        .IF_PC_plus_4(IF_PC_Out+4),
        .ID_inst(ID_INST),
        .ID_PC_plus_4(ID_PC_plus_4)
    );

    IDEX idex(
        .clk(clk),
        .reset(reset),// to be modified
        .stall(STALL),
        .ID_WB({ID_MEM_TO_REG,ID_REG_WRITE}),
        .ID_M({ID_MEM_READ,ID_MEM_WRITE}),
        .ID_EX({ID_REG_DST,ID_ALU_SRC_B,ID_ALU_SRC_A,ID_ALU_CTR[3:0]}),
        .ID_PC_plus_4(ID_PC_plus_4),
        .ID_signext(ID_IMM),
        .ID_zeroext(ID_SA),
        .ID_rd(ID_INST[15:11]),
        .ID_rs(ID_INST[25:21]),
        .ID_rt(ID_INST[20:16]),
        .ID_rs_data(ID_RS_DATA),
        .ID_rt_data(ID_RT_DATA),
        
        .EX_WB(EX_WB),
        .EX_M(EX_M),
        .EX_EX(EX_EX),
        .EX_PC_plus_4(EX_PC_plus_4),
        .EX_signext(EX_IMM),
        .EX_zeroext(EX_SA),
        .EX_rd(EX_RD),
        .EX_rs(EX_RS),
        .EX_rt(EX_RT),
        .EX_rs_data(EX_RS_DATA),
        .EX_rt_data(EX_RT_DATA)
    );

    hazardDetect hDetect(
        .memRead(EX_M[1]),
        .regWriteAddr(EX_RD_OR_RT),
        .rsAddr(ID_INST[25:21]),
        .rtAddr(ID_INST[20:16]),
        .stall(STALL)
    );

    //-----------------forwarding-----------------------//

    wire [31:0] FORMUX_A_OUT;
    wire [31:0] FORMUX_B_OUT;
    wire [1:0] FORMUXA;
    wire [1:0] FORMUXB;

    Forwarding forwarding(
        .regWriteMEM(MEM_WB[0]),
        .regWriteWB(WB_WRITE_REG),
        .regWriteAddrMEM(MEM_RD_OR_RT),
        .regWriteAddrWB(WB_WRITE_REG_ADDR),
        .rsAddr(EX_RS),
        .rtAddr(EX_RT),
        .FORMUXA(FORMUXA),
        .FORMUXB(FORMUXB)
    );

    FORMUX mux_for_a(
        .input0(EX_RS_DATA),
        .input1(WB_WRITE_REG_DATA),
        .input2(MEM_ALU_OUT),
        .sel(FORMUXA),
        .out(FORMUX_A_OUT)
    );

    FORMUX mux_for_b(
        .input0(EX_RT_DATA),
        .input1(WB_WRITE_REG_DATA),
        .input2(MEM_ALU_OUT),
        .sel(FORMUXB),
        .out(FORMUX_B_OUT)
    );
    
    MUX mux_alu_a(
        .input0(FORMUX_A_OUT),
        .input1(EX_SA),
        .sel(EX_EX[4]), //ALUSrcA
        .out(EX_ALU_A)
    );

    MUX mux_alu_b(
        .input0(FORMUX_B_OUT),
        .input1(EX_IMM),
        .sel(EX_EX[5]),
        .out(EX_ALU_B)
    );

    EXMEM exmem(
        .clk(clk),
        .reset(reset),//to be modified
        //.EX_WB({EX_WB[1],(EX_WB[0]&(~EX_OVERFLOW))}),
        .EX_WB({EX_WB[1],(EX_WB[0])}),
        .EX_M(EX_M),
        .EX_ALUout(EX_ALU_OUT),
        .EX_MemWriteData(FORMUX_B_OUT),//to be modified
        .EX_rd_or_rt(EX_RD_OR_RT),

        .MEM_WB(MEM_WB),
        .MEM_M(MEM_M),
        .MEM_ALUout(MEM_ALU_OUT),
        .MEM_MemWriteData(MEM_MEM_WRITE_DATA),
        .MEM_rd_or_rt(MEM_RD_OR_RT)
    );

endmodule
