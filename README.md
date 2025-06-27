# Single-Cycle RISC-V Processor (RV-32I)

A complete implementation of a 32-bit single-cycle RISC-V processor based on Harvard Architecture, designed for FPGA deployment on Cyclone® IV devices.

## 📋 Table of Contents
- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Supported Instructions](#supported-instructions)
- [FPGA Implementation](#fpga-implementation)
- [Simulation Results](#simulation-results)
- [Contributing](#contributing)


## 🎯 Overview

This project implements a complete single-cycle RISC-V processor that executes the RV-32I instruction set. The processor performs instruction fetch, decode, execute, write back, and program counter update all within a single clock cycle, making it ideal for educational purposes and FPGA implementation.

![RISC-V Processor Architecture](docs/images/processor_architecture.png)

![image](https://github.com/user-attachments/assets/aaf7e3b2-867f-4c0a-91c3-6ebf154122ec)


## 🏗️ Architecture

The processor follows the Harvard Architecture with separate instruction and data memories. Key architectural features include:

- **32-bit datapath** with single-cycle execution
- **Harvard Architecture** (separate instruction and data memories)
- **5-stage pipeline equivalent** executed in one cycle
- **FPGA-optimized design** for Cyclone® IV devices

### Key Specifications
- **Word Size**: 32 bits
- **Register File**: 32 × 32-bit registers
- **Instruction Memory**: 64 × 32-bit ROM
- **Data Memory**: 64 × 32-bit RAM
- **ALU Operations**: 7 supported operations

## ✨ Features

- ✅ Complete RV-32I instruction set support
- ✅ Asynchronous instruction memory reads
- ✅ Synchronous data memory writes
- ✅ Branch prediction and control flow
- ✅ Immediate value sign extension
- ✅ Zero and sign flag generation

## 📚 Supported Instructions

### Instruction Types
| Type | Instructions | Description |


------|-------------|-------------|
| **R-Type** | `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLL`, `SRL` | Register-register operations |
| **I-Type** | `ADDI`, `LW` | Immediate and load operations |
| **S-Type** | `SW` | Store operations |
| **B-Type** | `BEQ`, `BNE`, `BLT` | Branch operations |

### ALU Operations
| ALUControl | Operation | Description |
|------------|-----------|-------------|
| `000` | A + B | Addition |
| `001` | A << B | Shift Left Logical |
| `010` | A - B | Subtraction |
| `100` | A ⊕ B | XOR |
| `101` | A >> B | Shift Right Logical |
| `110` | A \| B | OR |
| `111` | A & B | AND |

### Test Program: Fibonacci Sequence

The included test program generates the first 10 Fibonacci numbers:

```assembly
# Fibonacci sequence generator
xor x0,x0,x0      # Initialize reference register
addi x1,x0,0      # First Fibonacci number (0)
addi x2,x0,1      # Second Fibonacci number (1)
addi x3,x0,1      # Selector register
# ... (see full program in docs/fibonacci.s)
```

**Expected Output**: `1, 1, 2, 3, 5, 8, 13, 21, 34, 55`

![Simulation Waveform](docs/images/simulation_waveform.png)
![image](https://github.com/user-attachments/assets/b5b89d32-b4fb-4ecc-bde8-94791b36c698)


## 🔌 FPGA Implementation

### Synthesis for Cyclone® IV

1. **Create Quartus Project**
   - Target device: Cyclone® IV (specific part number based on your board)
   - Add all `.v` files to project

2. **Pin Assignment**
   ```verilog
   // Example pin assignments (adjust for your board)
   set_location_assignment PIN_23 -to clk
   set_location_assignment PIN_24 -to reset
   // ... add other pin assignments
   ```

3. **Compile and Program**
   - Run Analysis & Synthesis
   - Run Fitter
   - Generate programming file
   - Program FPGA device

### Resource Utilization
| Resource | Usage | Percentage |
|----------|-------|------------|
| Logic Elements | ~500 | <5% |
| Memory Bits | 3,072 | <10% |
| Pins | ~10 | Variable |

## 📊 Simulation Results

### Performance Metrics
- **Clock Frequency**: Up to 50 MHz on Cyclone® IV
- **CPI (Cycles Per Instruction)**: 1 (single-cycle)
- **Instruction Throughput**: 50 MIPS @ 50 MHz

## 🔬 Advanced Features

### Future Enhancements
- [ ] **Pipeline Implementation** - Convert to 5-stage pipeline
- [ ] **Cache Memory** - Add instruction and data caches
- [ ] **Interrupt Handling** - Implement interrupt controller
- [ ] **Floating Point** - Add FPU for RV-32F support
- [ ] **Debug Interface** - JTAG debugging support

### Performance Optimizations
- [ ] **Branch Prediction** - Static branch prediction
- [ ] **Memory Optimization** - Block RAM inference
- [ ] **Clock Gating** - Power optimization techniques

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

### Development Guidelines
1. Follow Verilog coding standards
2. Update documentation for new features
3. Ensure FPGA synthesis compatibility


## 📞 Contact

**Fady Samy Nabil Daoud** - fadysamy541@gmail.com 

---

*Built with ❤️ for computer architecture education and FPGA development*
