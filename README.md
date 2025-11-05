# Generic-Synchronous-Asynchronous-FIFO-Memories
This repository contains the design and simulation files for both Synchronous and Asynchronous FIFO modules. These FIFOs are commonly used in digital systems for data buffering, clock domain crossing, and metastability mitigation, ensuring reliable data transfer between components operating at different clock frequencies.


The simulation waveform of the Synchronous FIFO module, it is possible to see how the controllers writes and reads data each time that the respective flag is asserted, we can see how the simulation asserts this two flags at different rates, resulting in the data transfer from a quicker source to a slower source. It is possible to see how the memory is written only when the possition has been readed before, ensuring that all data is readed before a next write. 

<img width="1423" height="544" alt="image" src="https://github.com/user-attachments/assets/ddd1a123-e7ea-4e6b-8423-2fd24b27f958" />



Next is shown the simulation waveform for the Asynchronous FIFO module, it is possible to see the two different clock domains of the design with the colors blue and yellow, at the midlle with purple color is found the Memory with all the content of each position. We can see how the ASYNC FIFO effectively transmitts the data from one domain tot he other, asserting the signals FIFOEmpty and FIFOReady, writing one data in one clock domain and reading the exact data in the same order in the other domain. It also can be appreciated in each domain the impact of the two-step synchronizer, affecting when the system starts reading after the writes start. 

<img width="1407" height="568" alt="image" src="https://github.com/user-attachments/assets/f5b17708-06b1-4f30-aab1-b34f966fe72b" />

