`timescale 1ns / 1ps
`include "constants.vh"
`include "files.vh"


module Decode #(parameter INT_PATH=`REGISTER_FILE, FP_PATH=`FP_REGISTER_FILE) (
    input                   read_clk,
    input                   write_clk,
    input                   reset,
    input                   stall, 
    input                   multiplier_done,
    input                   divider_done,
    input                   fp, // floating point
    input                   double,
    input  [`INSTR_LEN-1:0] instruction,
    input  [`WORD-1:0]      write_data,
    
    output [`WORD-1:0]      extended_instruction,
    output [10:0]           opcode,
    output [`WORD-1:0]      read_data1,
    output [`WORD-1:0]      read_data2,
    output                  mem_read,
    output                  mem_write,
    output                  alu_src,
    output                  reg_write,
    output                  update_sreg,
    output [1:0]            execute_result_loc,
    output                  mult_start,
    output                  div_start,
    output [2:0]            branch_op,
    output [1:0]            mem_to_reg,
    output [1:0]            mult_mode,
    output                  div_mode,
    output [3:0]            alu_op,
    output [2:0]            fpu_op
);

    wire [4:0] rm;
    wire [4:0] rn;
    wire [4:0] rd;
    wire [8:0] address;
    wire [5:0] shamt;
    
    instr_parse instr_parse(
        .instruction(instruction),
        .rm(rm),
        .rn(rn),
        .rd(rd),
        .address(address),
        .opcode(opcode),
        .shamt(shamt)
    );
    
    wire readreg2_loc;
    wire write_reg_src;
    wire [4:0] read_reg2;
    wire [4:0] write_reg;
    
    control control(
        .opcode(opcode),
        .shamt(shamt),
        .stall(stall),
        .multiplier_done(multiplier_done),
        .readreg2_loc(readreg2_loc),
        .branch_op(branch_op),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .alu_op(alu_op),
        .mult_mode(mult_mode),
        .update_sreg(update_sreg),
        .write_reg_src(write_reg_src),
        .execute_result_loc(execute_result_loc),
        .mult_start(mult_start),
        .div_start(div_start),
        .div_mode(div_mode),
        .divider_done(divider_done),
        .fpu_op(fpu_op),
        .fp(fp),
        .double(double)
    );
    
    mux2 #(.SIZE(5)) mux2_read_reg2(
        .a(rm),
        .b(rd),
        .control(readreg2_loc),
        .out(read_reg2)
    );
    
    mux2 #(.SIZE(5)) mux2_write_reg(
        .a(rd),
        .b(5'd30),
        .control(write_reg_src),
        .out(write_reg)
    );
    
    wire [`WORD-1:0] read_data1_int,
                     read_data2_int,
                     read_data1_fp,
                     read_data2_fp;
    
    register_memory #(.PATH(INT_PATH)) register_memory(
        .read_clk(read_clk),
        .write_clk(write_clk),
        .reset(reset),
        .reg_write(reg_write && !fp),
        .read_reg1(rn),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(read_data1_int),
        .read_data2(read_data2_int)
    );
    
    register_memory #(.PATH(FP_PATH)) fp_register_memory(
        .read_clk(read_clk),
        .write_clk(write_clk),
        .reset(reset),
        .read_reg1(rn),
        .read_reg2(read_reg2),
        .reg_write(reg_write && fp),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(read_data1_fp),
        .read_data2(read_data2_fp)
    );
    
    mux2 #(.SIZE(`WORD)) read_data1_mux(
        .a(read_data1_int),
        .b(read_data1_fp),
        .control(fp),
        .out(read_data1)
    );

    mux2 #(.SIZE(`WORD)) read_data2_mux(
        .a(read_data2_int),
        .b(read_data2_fp),
        .control(fp),
        .out(read_data2)
    );
    
    sign_extender sign_extender(
        .instruction(instruction),
        .out(extended_instruction)
    );

endmodule





