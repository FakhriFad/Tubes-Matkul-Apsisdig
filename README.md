# Matrix Keypad Scanner 4x4 (Verilog HDL)

## Overview

This project presents the design and implementation of a **4×4 Matrix Keypad Scanner** using **Verilog HDL**. The system is designed to provide reliable and accurate user input handling in digital systems by addressing mechanical noise (debouncing), ensuring data integrity, and supporting real-time operation.

The design is simulated on Quartus and Modelsim platform and further explored through an ASIC design flow using **Qflow** to generate a GDSII layout.

---

## Objectives

* Design a modular keypad scanning system using Verilog HDL
* Eliminate mechanical noise through debouncing techniques
* Encode keypad input into ASCII format
* Prevent data loss using FIFO buffering
* Validate functionality through simulation and FPGA implementation
* Explore ASIC-level physical design flow

---

## System Architecture

The system is composed of the following main modules:

* **Row Driver**
  Activates keypad rows sequentially using active-low logic.

* **Column Reader**
  Captures column inputs and detects key presses.

* **Debounce Filter**
  Removes transient noise caused by mechanical contact bounce.

* **Key Encoder**
  Converts row-column coordinates into 8-bit ASCII codes.

* **FIFO Queue**
  Buffers input data to ensure ordered and lossless processing.

---

## Functional Description

The system operates based on a Finite State Machine (FSM) with the following stages:

1. **Initialization**
   System reset initializes registers and prepares the FSM.

2. **Row Scanning**
   Rows are activated sequentially while monitoring column inputs.

3. **Key Detection**
   A low signal on a column line indicates a key press.

4. **Debouncing**
   The system validates the signal stability over a fixed time interval.

5. **Encoding**
   The detected key is mapped into its corresponding ASCII value.

6. **FIFO Write**
   Valid data is stored in the FIFO buffer.

7. **Release Detection**
   The system waits until the key is released before resuming scanning.

---

## Key Design Components

### Clock Divider

Reduces the 50 MHz system clock to 100 Hz to support stable scanning and debouncing intervals.

### Row Driver

Implements a 2-bit counter and decoder to generate active-low row signals.

### Column Reader

Synchronizes asynchronous inputs and detects valid key presses.

### Debounce and Edge Detection

Ensures signal stability and generates a single-cycle pulse for each valid key press.

### Key Encoder

Implements a combinational lookup table (LUT) for mapping keypad positions to ASCII codes.

### FIFO Queue

Provides temporary storage (depth: 16) to handle high-speed or sequential inputs without data loss.

---

## Simulation and Verification

A dedicated testbench was developed to validate system functionality. The simulation includes:

* Clock generation (50 MHz)
* Reset initialization
* Multiple key press scenarios
* FIFO read/write verification

### Results

* Stable row scanning behavior
* Accurate key detection and encoding
* Effective debouncing with no false triggers
* Correct FIFO operation with ordered data output

---

## FPGA Implementation

### Resource Utilization

* 93 ALUTs (Adaptive Look-Up Tables)
* 82 Logic Registers
* 112 bits of memory (FIFO)

The design demonstrates high efficiency with minimal resource usage.

### Timing Performance

* Maximum frequency (Fmax): ~206 MHz
* Operating frequency: 50 MHz
* Positive timing slack indicates safe operation margins

---

## ASIC Design Flow (Qflow)

The design was synthesized through an open-source ASIC flow using Qflow:

* Technology: osu35
* Successful GDSII layout generation
* High area utilization efficiency

### Performance

* Pre-layout: ~315 MHz
* Post-layout: ~312 MHz
* Minimal degradation (~0.85%), indicating robust physical design

--

## Technologies

* Verilog HDL
* Intel Quartus Prime
* ModelSim
* FPGA (Cyclone V)
* Qflow (ASIC design flow)

---

## Conclusion

The project successfully demonstrates a robust and modular keypad interface system. It effectively handles mechanical noise, ensures accurate data encoding, and maintains data integrity through buffering. The design has been validated at both simulation and hardware levels, with additional exploration into ASIC implementation.

---

## License

This project is developed for academic purposes.
