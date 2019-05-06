`timescale 1ns / 1ps
`include "constants.vh"

module control(
    input [10:0] opcode,
    output reg readreg2_control,
               mem_read,
               mem_write,
               reg_write,
               alu_src,
               update_sreg,
               write_reg_src,
    output reg [1:0] alu_op,
                     mem_to_reg,
    output reg [2:0] branch_op // 000 => no branch, 001 => branch, 010 => branch_conditionally, 011 => branch_if_zero, 100 => branch_if_not_zero
);
    
    always @* begin
        // Set every signal to zero
        readreg2_control <= 0;
        mem_read <= 0;
        mem_write <= 0;
        mem_to_reg <= 'b00;
        reg_write <= 0;
        alu_src <= 0;
        alu_op <= 'b00;
        update_sreg <= 0;
        branch_op <= 'b000;
        write_reg_src <= 0;
        
        // Set bits to 1
        casex(opcode)
            `ADD, `SUB, `AND, `ORR: begin
                reg_write <= 1;
                alu_op <= 'b10;
            end
            `LSL, `LSR: begin
                reg_write <= 1;
                alu_src <= 1;
                alu_op <= 2'b10;
            end
            `ADDS, `ANDS, `SUBS: begin
                reg_write <= 1;
                alu_op <= 'b10;
                update_sreg <= 1;
            end
            `ADDI, `ANDI, `EORI, `ORRI, `SUBI: begin
                reg_write <= 1;
                alu_src <= 1;
                alu_op <= 'b10;
            end
            `ADDIS, `ANDIS, `SUBS: begin
                reg_write <= 1;
                alu_src <= 1;
                alu_op <= 'b10;
                update_sreg <= 1;
            end
            `CMP: begin
                alu_op <= 'b10;
                update_sreg <= 1;
            end
            `CMPI: begin
                alu_src <= 1;
                alu_op <= 'b10;
                update_sreg <= 1;
            end
            `LDUR, `LDURB, `LDURH, `LDURSW: begin
                mem_read <= 1;
                mem_to_reg <= 'b01;
                reg_write <= 1;
                alu_src <= 1;
            end
            `STUR, `STURB, `STURH, `STURW: begin
                readreg2_control <= 1;
                mem_write <= 1;
                alu_src <= 1;
            end
            `CBZ: begin
                readreg2_control <= 1;
                alu_op <= 'b01;
                update_sreg <= 1;
                branch_op <= 'b011;
            end
            `CBNZ: begin
                readreg2_control <= 1;
                alu_op <= 'b01;
                update_sreg <= 1;
                branch_op <= 'b100;
            end
            `B: begin
                alu_op <= 'b01;
                branch_op <= 'b001;
            end
            `BCOND: begin
                alu_op <= 'b01;
                branch_op <= 'b010;
            end
            `BL: begin
                alu_op <= 'b01;
                branch_op <= 'b001;
                mem_to_reg <= 'b10;
                write_reg_src <= 1;
                reg_write <= 1;
            end
            `BR: begin
                readreg2_control <= 1;
                alu_op <= 'b01;
                branch_op <= `BCOND_OP_ALU;
            end
        endcase
    end  
    
endmodule