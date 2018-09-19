import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc

#                         NOutput: 1, 2,  3,  4,  5,   6,   7,   8,   9,   10
ParallelFindMaxLatency = np.array([3, 7, 11, 15, 19,  23,  27,  31,  35,  39])
ParallelFindMaxII      = np.array([1, 1,  1,  1,  1,   1,   1,   1,   1,   1])
ParallelFindMaxLUT     = np.array([0, 8, 23, 45, 75, 111, 156, 207, 265, 331])
ParallelFindMaxFF      = np.array([0, 0,  1,  1,  1,   1,   1,   2,   2,   2])
SortAndSelectLatency   = np.array([5, 5,  6,  7,  8,   9,  10,  11,  12,  13])
SortAndSelectII        = np.array([1, 1,  1,  1,  1,   1,   1,   1,   1,   1])
SortAndSelectLUT       = np.array([1, 1,  2,  2,  2,   2,   2,   2,   2,   2])
SortAndSelectFF        = np.array([0, 0,  0,  0,  0,   0,   0,   0,   0,   0])
nvtx = np.arange(1.,11.,1)

# activate latex text rendering
rc('text', usetex=True)

fig, ax = plt.subplots()
ax.plot(nvtx, ParallelFindMaxLatency, 'ro', label=r"Parallel Find Max \textbf{Latency}")
ax.plot(nvtx, SortAndSelectLatency, 'bs', label=r"Sort And Select \textbf{Latency}")
ax.plot(nvtx, ParallelFindMaxII, 'r^', label=r"Parallel Find Max \textbf{II}")
ax.plot(nvtx, SortAndSelectII, 'bv', label=r"Sort And Select \textbf{II}")
plt.xlabel(r'N\textsubscript{vtx}')
plt.ylabel(r'Latency/II (clock cycles)')
ax.grid()
ax.axis([0, 11, 0, 40])
legend = ax.legend(loc='upper left', shadow=True)
ax.text(0.01, 1.0, r'Xilinx Vivado HLS 2018.2',
        verticalalignment='bottom', horizontalalignment='left',
        transform=ax.transAxes)
ax.text(0.99, 1.0, r'FPGA: VU9P',
        verticalalignment='bottom', horizontalalignment='right',
        transform=ax.transAxes)
fig.savefig('simple_algo_find_top_n_latencyII.pdf', bbox_inches='tight')

fig2, ax2 = plt.subplots()
ax2.plot(nvtx, ParallelFindMaxLUT, 'ro', label=r"Parallel Find Max \textbf{LUT}")
ax2.plot(nvtx, SortAndSelectLUT, 'bs', label=r"Sort And Select \textbf{LUT}")
ax2.plot(nvtx, ParallelFindMaxFF, 'r^', label=r"Parallel Find Max \textbf{FF}")
ax2.plot(nvtx, SortAndSelectFF, 'bv', label=r"Sort And Select \textbf{FF}")
plt.xlabel(r'N\textsubscript{vtx}')
plt.ylabel(r'Resource Usage (\%)')
plt.grid()
ax2.set_yscale("log", nonposy='clip')
ax2.axis([0, 11, 0.7, 400])
legend2 = ax2.legend(loc='upper left', shadow=True)
ax2.text(0.01, 1.0, r'Xilinx Vivado HLS 2018.2',
        verticalalignment='bottom', horizontalalignment='left',
        transform=ax2.transAxes)
ax2.text(0.99, 1.0, r'FPGA: VU9P',
        verticalalignment='bottom', horizontalalignment='right',
        transform=ax2.transAxes)
fig2.savefig('simple_algo_find_top_n_resources.pdf', bbox_inches='tight')

plt.show()