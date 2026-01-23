# Multicycle-CPU
# Multicycle RISC-V CPU (SystemVerilog)

## Overview
This project implements a multicycle RISC-V–style CPU in SystemVerilog.
The design separates control and datapath logic and executes instructions
over multiple cycles using a centralized FSM.

The project was developed as part of a lab framework; all control sequencing,
datapath connections, and instruction execution behavior were implemented and
debugged by me.

## Supported Instructions
- R-type (ADD, SUB, AND, OR, SLT)
- I-type (ADDI, LOAD)
- S-type (STORE)
- B-type (BEQ)
- J-type (JAL)

## Control FSM
The CPU uses a multicycle FSM with states for:
- Instruction fetch
- Decode / register fetch
- Memory address calculation
- Execute
- Memory access
- Write-back

State transitions depend on the opcode and instruction class.

## Datapath Highlights
- OldPC register for branch/jump calculation
- ALUOut register for multicycle execution
- Shared instruction/data memory
- Branch decision using Zero flag

## Verification
- End-to-end simulation with waveform inspection
- Verified correct behavior for arithmetic, memory, and control-flow instructions

## What I Learned
- Designing multicycle control FSMs
- Separating datapath and control logic
- Debugging RTL using waveforms
- Understanding instruction-level timing

## Future Improvements
- Pipeline implementation
- Hazard detection
- Instruction/data cache separation
