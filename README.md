# LEGv8 Processor

This is a very simple implementation of a LEGv8 Processor, which is a subset of ARMv8. The goal of this project is to implement most (preferably all) of the information contained in the [LEGv8 Reference Guide](resources/LEGv8_Reference.pdf). 

## Motivation

This project was originally created as part of ELC 3338 at Baylor University. I heavily enjoyed the project, and chose to continue the development of the processor on my own.

_Sidenote to any possible ELC 3338 students who have stumbled across this repository: I've made certain choices to intentionally make this repository hard to copy from if you are in any lab except the last one. I'd recommend not copying anything from this repo :)_

## Projects

There are three projects in this repository:

- nonpipelined/: This is the single-stage, nonpipelined version of the processor.
- pipelined/: (TODO) This is the pipelined version of the processor, with no data forwarding or hazard protection.
- pipelined-forward-hazard/: (TODO) This is the pipelined version of the processor, with both data forwarding and hazard protection.

## Hardware Hierarchy

- datapath.v
    - Fetch.v
        - register.v
        - mux.v
        - instruction_memory.v
    - Decode.v
        - instr_parse.v
        - control.v
        - mux.v
        - register_memory.v
        - sign_extender.v
    - Execute.v
        - left_shift.v
        - adder.v
        - alu_control.v
        - mux.v
        - alu.v
    - Memory.v
        - data_memory.v
    - Writeback.v
        - mux.v

## Instructions

Initially, this project supported eight instructions: `ADD`, `SUB`, `AND`, `ORR`, `LDUR`, `STUR`, `B`, `CBZ`. The goal is to eventually support all of the instructions referenced in the [LEGv8 Reference Guide](resources/LEGv8_Reference.pdf). These are as follows:

- [x] ADD
- [ ] ADDI
- [ ] ADDIS
- [ ] ADDS
- [x] AND
- [ ] ANDI
- [ ] ANDIS
- [ ] ANDS
- [x] B
- [ ] B.cond
- [ ] BL
- [ ] BR
- [x] CBNZ
- [x] CBZ
- [x] EOR
- [ ] EORI
- [x] LDUR
- [x] LDURB
- [ ] LDURH
- [ ] LDURSW
- [ ] LDXR
- [ ] LSL
- [ ] LSR
- [ ] MOVK
- [ ] MOVZ
- [x] ORR
- [ ] ORRI
- [x] STUR
- [ ] STURB
- [ ] STURH
- [ ] STURW
- [ ] STXR
- [x] SUB
- [ ] SUBI
- [ ] SUBIS
- [ ] SUBS
- [ ] FADDS
- [ ] FADDD
- [ ] FCMPS
- [ ] FCMPD
- [ ] FDIVS
- [ ] FDIVD
- [ ] FMULS
- [ ] FMULD
- [ ] FSUBS
- [ ] FSUBD
- [ ] LDURS
- [ ] LDURD
- [ ] MUL
- [ ] SDIV
- [ ] SMULH
- [ ] STURS
- [ ] STURD
- [ ] UDIV
- [ ] UMULH

## Other features

Other things that I would like to implement are:

- [ ] Floating point registers
- [ ] Status flag register