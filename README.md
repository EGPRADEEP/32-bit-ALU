# 🚀 **32-Bit Arithmetic Logic Unit (ALU) Design Using Verilog**

This project demonstrates the design, simulation, and synthesis of a **32-bit Arithmetic Logic Unit (ALU)** using **Verilog HDL**, with support for multiple arithmetic and logical operations. The ALU was thoroughly tested using **ModelSim** and synthesized using **Intel Quartus Prime**, making it suitable for FPGA implementation.

The system is designed to process 8-bit, 16-bit, and 32-bit binary numbers and supports the generation of **status flags** such as Zero, Carry, Overflow, and Sign, which are crucial for digital computation in CPUs and embedded systems.

---

## 📖 **Project Overview**

The goal of this project is to implement a **configurable 32-bit ALU** using structural and behavioral Verilog. This ALU simulates the basic operations found in modern processors and is verified using waveform simulation.

**Features:**

- Modular ALU design with parameterized data width
- Logical operations: AND, OR, NOT, Negation
- Arithmetic operations: Addition, Subtraction, Multiplication, Division
- Control through 3-bit operation selector (Opcode)
- Status flag outputs: Zero, Carry, Overflow, Sign
- Simulated in **ModelSim**, synthesized in **Quartus Prime**

---

## 🔧 Hardware & Tools Used

| Tool / Component       | Description                          |
|------------------------|--------------------------------------|
| 💻 Verilog HDL         | Hardware Description Language        |
| 🧪 ModelSim            | For functional simulation and waveform analysis |
| 🛠️ Intel Quartus Prime | FPGA synthesis and RTL analysis     |
| 💡 FPGA Board (Optional)| Can be implemented on Intel FPGA kits |

---

## ⚙️ How It Works

- **Inputs:** Two 32-bit binary numbers and a 3-bit selector (`Opcode`)  
- **Operation Control:** Based on the selector, one of 8 operations is executed:
  - `000`: NOT  
  - `001`: OR  
  - `010`: AND  
  - `011`: Negation  
  - `100`: Addition  
  - `101`: Subtraction  
  - `110`: Multiplication  
  - `111`: Division  

- **Outputs:** The result of the operation and status flags (Z, C, O, S)

---

