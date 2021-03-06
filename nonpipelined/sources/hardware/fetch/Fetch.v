`timescale 1ns / 1ps
`include "constants.vh"
`include "files.vh"


module Fetch #(parameter PATH=`INSTRUCTION_FILE) (
    input                   clk,
    input                   read_clk,
    input                   reset,
    input  [1:0]            pc_src,
    input  [`WORD-1:0]      branch_target,
    input  [`WORD-1:0]      alu_result,
    output [`WORD-1:0]      pc,
    output [`WORD-1:0]      incremented_pc,
    output [`INSTR_LEN-1:0] instruction
);

    wire [`WORD-1:0] new_pc;
    assign incremented_pc = reset ? 0 : (pc + `WORD'd4);
    
    register register_pc(
        .clk(clk),
        .reset(reset),
        .D(new_pc),
        .Q(pc)
    );
    
    mux4 #(.SIZE(`WORD)) mux4_pc_source(
        .a(incremented_pc),
        .b(branch_target),
        .c(alu_result),
        .d(pc),
        .control(pc_src),
        .out(new_pc)
    );
    
    instruction_mem #(.PATH(PATH)) instruction_mem(
        .clk(read_clk),
        .reset(reset),
        .address(pc),
        .instruction(instruction)
    );

endmodule