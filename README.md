# 🧠 Fully-Associative Cache Memory System (Verilog)

## 📘 Overview
This project implements a **Fully-Associative Cache Memory System** using Verilog HDL.  
It simulates how cache memory works when any memory block can be stored in any cache line,  
supporting **read/write operations**, **hit/miss detection**, and **LRU/round-robin replacement**.

---

## 🎯 Objectives
- Understand the architecture and working of fully-associative caches.
- Implement parallel tag comparison and replacement logic.
- Demonstrate cache hits, misses, evictions, and write policies through simulation.
- Integrate a simple main memory model for realistic data transfers.

---

## ⚙️ System Specifications
| Signal | Direction | Description |
|--------|------------|-------------|
| `clk`, `reset` | Input | System clock and reset |
| `addr[15:0]` | Input | 16-bit memory address |
| `data_in[7:0]` | Input | Data for write operations |
| `data_out[7:0]` | Output | Data from cache on read |
| `read`, `write` | Input | Control signals for operation |
| `hit`, `miss` | Output | Status indicators for cache access |

---

## 🧩 Cache Structure
| Component | Description |
|------------|-------------|
| **Fully-Associative Mapping** | Any memory block can go into any line |
| **Tag Field** | Stores tag bits for each line |
| **Valid Bit** | Indicates valid cache data |
| **Dirty Bit** | Used for write-back policy |
| **Data Array** | Stores cache line data |
| **Replacement Policy** | LRU or round-robin |

---

## 🧱 Module Structure
fully_associative_cache/
├── rtl/
│ ├── fully_associative_cache.v # Main cache module
│ ├── main_memory.v # Simple memory model
│ └── utils.v # Helper functions
├── tb/
│ └── tb_fully_associative_cache.v # Testbench
├── docs/
│ ├── block_diagram.md
│ └── fsm_diagram.md
├── README.md
└── references.md




---

## 🧠 Key Features
✅ **Fully associative mapping** (no index restrictions)  
✅ **Parallel tag comparison** across all cache lines  
✅ **LRU-based replacement policy**  
✅ **Write-through / Write-back** support (parameter selectable)  
✅ **Parameterizable size** — number of lines, block size, address width  
✅ **Clean simulation waveforms** for hits/misses/evictions  

---

## 🚀 Simulation Setup

### Requirements
- [Icarus Verilog (iverilog)](https://steveicarus.github.io/iverilog/)
- [GTKWave](http://gtkwave.sourceforge.net/) (optional, for waveforms)

### Commands

# Compile all files
    iverilog -g2012 -o simv rtl/*.v tb/tb_fully_associative_cache.v

# Run simulation
    vvp simv

# View waveforms (optional)
    gtkwave cache_wave.vcd


---


## 🧪 Testbench Highlights

The testbench (`tb_fully_associative_cache.v`) demonstrates:

1. **Consecutive Reads to Same Address**  
   - First access = **MISS**, later accesses = **HIT**

2. **Write Followed by Read**  
   - Verifies correct cache update and data consistency

3. **Eviction Test**  
   - Accessing more addresses than cache lines triggers **LRU replacement**

4. **Write Policy Check**  
   - For **write-through:** memory updates immediately  
   - For **write-back:** updates on eviction only


## 🧮 Parameters in the Cache Module

| Parameter    | Description                       | Default |
|--------------|-----------------------------------|---------|
| `ADDR_WIDTH` | Address width (bits)              | 16      |
| `DATA_WIDTH` | Data width (bits)                 | 8       |
| `LINES`      | Number of cache lines             | 4       |
| `BLK_BYTES`  | Bytes per block                   | 1       |
| `WRITE_BACK` | 0 = Write-through, 1 = Write-back | 0       |

**Example instantiation:**
fully_associative_cache #(
  .ADDR_WIDTH(16),
  .DATA_WIDTH(8),
  .LINES(4),
  .WRITE_BACK(0)
) cache_inst (...);

---

## 🖼️ Expected Waveform Outputs

- `hit` goes high when the requested block is already cached  
- `miss` goes high when data must be fetched from memory  
- `mem_wr_en` pulses on write-through or eviction (write-back)  
- Cache line updates visible during evictions


## 🧾 Learning Outcomes

By completing this project, you’ll learn:

- How **fully-associative caches** differ from **direct-mapped** and **set-associative** designs  
- Designing **parallel tag comparators** and **replacement logic**  
- Implementing **LRU** and **dirty-bit** mechanisms  
- Trade-offs between cache **flexibility** and **hardware complexity**


## 📚 References

- Hennessy, J. L., Patterson, D. A. *Computer Architecture: A Quantitative Approach*  
- University Lecture Notes on Cache Organization  
- IEEE Std 1364-2001 Verilog Specification  
- Open-source Verilog examples and simulation tutorials


## ✨ Author

**Aman Raj - 2024CSB11**
**Keshav Verma - 2024CSB11**
**Manan Kumar - 2024CSB1130**
**Md. Ammar - 2024CSB1131**
**Mohammad Ali - 2024CSB1132**
Developed as part of CS203 Project.
