# Asynchronous FIFO – Complete Physical Design Implementation (Sky130 + OpenLane)

## 📌 Project Overview
This project implements a **fully synthesizable Asynchronous FIFO** and completes the entire **RTL-to-GDSII** physical design flow using:

* **OpenLane**
* **OpenROAD**
* **Sky130 PDK**
* **Multi-corner Static Timing Analysis**
* **Full Signoff (DRC, LVS, Antenna, ERC)**

The design uses two independent clock domains and implements **Gray-coded pointer synchronization** for safe clock domain crossing (**CDC**).

---

## 🎯 Objectives
* Design asynchronous FIFO RTL which include parametric declaration.
* Handle dual clock domain constraints.
* Perform full RTL-to-GDS flow.
* Analyze and fix STA issues.
* Verify multi-corner timing.
* Complete signoff including DRC/LVS.
* Generate final GDS.

---

## 🏗 Design Specifications

| Parameter | Value |
| :--- | :--- |
| **Data Width** | 8 bits |
| **Depth** | 16 entries |
| **Write Clock** | 100 MHz (10 ns) |
| **Read Clock** | 100 MHz (10 ns) |
| **Technology** | Sky130 HD |
| **Tool Flow** | OpenLane |

---

## 🧠 Architecture Overview
The FIFO consists of:
* Dual-port memory
* Binary-to-Gray pointer conversion
* Two-stage synchronizers
* Full/Empty detection logic
* Separate write and read domains

> **Note:** Clock domains are physically separated during floorplanning to improve CDC robustness.

---

## 🛠 Complete Physical Design Flow

### 1️⃣ RTL Design
* Parameterized depth and width
* Gray-coded pointer synchronization
* Safe CDC implementation

### 2️⃣ Synthesis (Yosys)
* Hierarchical synthesis enabled (`SYNTH_NO_FLAT=1`)
* Area optimized netlist generated
* Clean setup timing

### 3️⃣ Floorplanning
* Core utilization set to **55%**
* Final utilization **≈ 56–58%**
* IO placement manually controlled
* Write domain placed left
* Read domain placed right
* Synchronizers placed between domains

### 4️⃣ Placement
* Domain clustering automatically achieved
* No congestion issues
* Proper cell spreading

### 5️⃣ Clock Tree Synthesis (CTS)
* Separate clock trees for `wr_clk` and `rd_clk`
* Skew **≈ ±0.01–0.06 ns**
* Balanced clock insertion delays

### 6️⃣ Routing
* Global + detailed routing completed
* No DRC violations
* No antenna violations

---

## 📊 Multi-Corner Timing Results (Post-Route, SPEF Extracted)

| Check | Result |
| :--- | :--- |
| **Setup Slack (Worst)** | 3.54 ns |
| **Hold Slack (Worst)** | 0.28 ns |
| **TNS** | 0.00 |
| **WNS** | 0.00 |

* ✔ **Timing clean across slow/fast/typical corners**
* ✔ **No violations**

---

## 🧪 Signoff Results

| Check | Status |
| :--- | :--- |
| **DRC** | Clean (i,e 0 error)|
| **LVS** | Matched |
| **Antenna** | Clean |
| **ERC** | Clean |
| **Multi-Corner STA** | Clean |

**Final GDS successfully generated.**

---

## 📁 Final Outputs
* `async_fifo.gds`
* `async_fifo.sdf`
* `async_fifo.lib`
* SPEF files
* LVS reports
* DRC reports

---

## 🧠 Key Learnings
* Handling asynchronous clock domains in STA
* Using `set_clock_groups -asynchronous`
* Proper CDC constraint modeling
* Debugging unconstrained endpoints
* Multi-corner parasitic timing effects
* Flow debugging in OpenLane
* Managing environment variables (`CURRENT_GDS`, `EXT_NETLIST`)
* Clock tree visualization and skew analysis

---

## 🚀 Future Enhancements
* Increase FIFO depth to 64+
* Add realistic switching activity for power estimation


---

## 📷 Screenshots

 ### `Floorplan View`
  <img width="991" height="635" alt="image" src="https://github.com/user-attachments/assets/02947ae6-f872-4349-bb8a-ed36438b487e" />
---

### `Placement Clustering`
<img width="1018" height="650" alt="image" src="https://github.com/user-attachments/assets/f9535601-bef2-4a6b-bcbf-f030fbe4331b" />


### `Clock Tree`
<img width="1020" height="651" alt="image" src="https://github.com/user-attachments/assets/b0ff26a4-e627-42c4-a2fd-f1ba315ec448" />


### `Routing View` 
<img width="1050" height="646" alt="image" src="https://github.com/user-attachments/assets/d3ecc4af-fd0a-4118-b947-c2af27986ce3" />


### `Final Timing Report Snippet`
<img width="892" height="612" alt="image" src="https://github.com/user-attachments/assets/373df6b6-6088-4c0e-8505-2db07813adf9" />

---

## 👨‍💻 Author
**Omkar Gurav**  
*Physical Design Enthusiast*

**Sky130 | OpenLane | STA | CTS | Routing | Signoff**
