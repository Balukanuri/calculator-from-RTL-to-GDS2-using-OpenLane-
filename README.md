# 4-Bit Calculator – RTL to GDSII (OpenLane, Sky130)

Overview

This project implements a simple 4-bit calculator using Verilog and takes the design through a complete RTL-to-GDSII flow using the OpenLane toolchain with the Sky130 PDK. The goal was to understand not just digital design, but how a logical idea becomes a physical chip layout.

The calculator supports basic arithmetic operations: addition, subtraction, multiplication, and division. The design is modular, verified through simulation, and then synthesized and implemented physically.

Features

* 4-bit inputs (`a`, `b`)
* 2-bit operation selector (`op`)
* Supports:

  * Addition
  * Subtraction
  * Multiplication
  * Division (with divide-by-zero handling)
* Outputs:

  * `result` (8-bit)
  * `quotient`, `remainder` (for division)
  * `error` flag

Design Details

Modules

* **adder4** – performs 4-bit addition with overflow detection
* **subtractor4** – performs subtraction
* **multiplier4** – performs multiplication with overflow
* **divider4** – performs division with error handling
* **calculator_top** – integrates all modules and selects operation based on `op`

Verification

The design was verified using a custom testbench in Verilog. Multiple test cases were applied to validate all operations, including edge cases like division by zero.

Waveforms were analyzed using GTKWave to confirm correct functionality.

RTL to GDSII Flow

The design was taken through the complete OpenLane flow:

1. **Linting & Synthesis** – using Yosys
2. **Floorplanning** – defining chip area and IO placement
3. **Placement** – arranging standard cells
4. **Routing** – connecting all nets automatically
5. **DRC & LVS Checks** – ensuring design rule and connectivity correctness
6. **GDSII Generation** – final layout output

The final layout was visualized using KLayout.

Observations

* Automated place-and-route results in a dense, grid-like layout typical of standard-cell designs
* Most debugging effort was spent fixing RTL issues and pin mismatches before synthesis
* Understanding tool errors (especially during synthesis and linting) was critical to completing the flow

Tools Used

* Verilog (RTL design)
* Icarus Verilog & GTKWave (simulation)
* OpenLane (RTL-to-GDS flow)
* Sky130 PDK
* KLayout (layout visualization)

What I Learned

* How digital logic is translated into physical hardware
* Basics of ASIC design flow (RTL → synthesis → layout)
* Debugging synthesis and toolchain issues
* Interpreting layout and routing structures

Future Improvements

* Extend to 8-bit or higher precision
* Optimize area and timing
* Add pipelining for performance
* Implement more operations

Conclusion

This project bridges the gap between digital design and physical implementation. It demonstrates not only functional correctness at the RTL level but also the ability to carry a design through to fabrication-ready layout.

## Project Artifacts

### RTL Design

* `design.v` contains the full Verilog implementation of the 4-bit calculator.
* Modular structure includes adder, subtractor, multiplier, and divider.

### Testbench

* `tb.v` verifies functionality across all operations.
* Includes test cases for normal and edge conditions (e.g., division by zero).

### Simulation Results

* Waveforms generated using GTKWave confirm correct behavior of all operations.
* Outputs match expected values for each opcode.

### Schematic

* Synthesized schematic shows gate-level structure of the design.
* Helps visualize how RTL is mapped to logic gates.

### Layout (GDSII)

* Final layout generated using OpenLane (Sky130 PDK).
* Viewed in KLayout.
* Dense routing and standard-cell placement reflect automated ASIC design flow.

---

## How to Run

### Simulation

```bash
iverilog design.v tb.v -o out
vvp out
gtkwave dump.vcd
```

### OpenLane Flow

```bash
./flow.tcl -design /home/asus/calculator_design
```

---

## Notes

* Layout may appear dense due to standard-cell based design methodology.
* Functionality was verified before physical design to ensure correctness.



BALA SUBRAHMANYAM KANURI
VLSI ASPIRANT
