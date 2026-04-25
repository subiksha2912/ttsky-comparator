# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start Comparator Test")

    # Clock setup
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1

    dut._log.info("Running test cases")

    # Test all combinations of 2-bit inputs
    for A in range(4):      # 00 to 11
        for B in range(4):  # 00 to 11

            # Pack inputs: A = [1:0], B = [3:2]
            dut.ui_in.value = (B << 2) | A
            dut.uio_in.value = 0

            await ClockCycles(dut.clk, 1)

            gt = int(dut.uo_out.value[0])
            eq = int(dut.uo_out.value[1])
            lt = int(dut.uo_out.value[2])

            dut._log.info(f"A={A:02b} B={B:02b} | GT={gt} EQ={eq} LT={lt}")

            # Expected results
            assert gt == (A > B), f"GT failed for A={A}, B={B}"
            assert eq == (A == B), f"EQ failed for A={A}, B={B}"
            assert lt == (A < B), f"LT failed for A={A}, B={B}"

    dut._log.info("All test cases passed ✅")
