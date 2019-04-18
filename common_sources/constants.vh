`define NIBBLE 4
`define BYTE 8
`define WORD 64
`define HALFWORD 32
`define INSTR_LEN `HALFWORD

`define CYCLE 10

//////////////////////
// ALU Control Bits //
//////////////////////
`define ALU_AND      4'b0000
`define ALU_OR       4'b0001
`define ALU_ADD      4'b0010
`define ALU_SUBTRACT 4'b0110
`define ALU_PASS_B   4'b0111
`define ALU_NOR      4'b1100
`define ALU_XOR      4'b0100

/////////////
// OPCODES //
/////////////
`define ADD     11'b10001011000
`define ADDI    11'b1001000100X
`define ADDS    11'b10101011000
`define ADDIS   11'b1011000100X
`define AND     11'b10001010000
`define ANDI    11'b1001001000X
`define ANDS    11'b11101010000
`define ANDIS   11'b1111001000X
`define B       11'b000101XXXXX
`define CBZ     11'b10110100XXX
`define CBNZ    11'b10110101XXX
`define EOR     11'b11001010000
`define EORI    11'b1101001000X
`define LDUR    11'b11111000010
`define LDURB   11'b00111000010
`define LDURH   11'b01111000010
`define LDURSW  11'b10111000100
`define ORR     11'b10101010000
`define ORRI    11'b1011001000X
`define STUR    11'b11111000000
`define STURB   11'b00111000000
`define STURH   11'b01111000000
`define STURW   11'b10111000000
`define SUB     11'b11001011000
`define SUBI    11'b1101000100X
`define SUBS    11'b11101011000
`define SUBIS   11'b1111000100X




