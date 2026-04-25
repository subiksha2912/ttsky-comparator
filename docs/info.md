# 2-Bit Comparator

## Description

This project implements a 2-bit digital comparator. It compares two 2-bit inputs and determines whether one input is greater than, equal to, or less than the other.

## How it works

The comparator takes two 2-bit inputs:

* **A = ui[1:0]**
* **B = ui[3:2]**

It produces three outputs:

* **uo[0] → A > B**
* **uo[1] → A == B**
* **uo[2] → A < B**

Only one of these outputs will be high (1) at a time based on the comparison result.

## Inputs

| Pin   | Name | Description    |
| ----- | ---- | -------------- |
| ui[0] | A0   | LSB of input A |
| ui[1] | A1   | MSB of input A |
| ui[2] | B0   | LSB of input B |
| ui[3] | B1   | MSB of input B |

## Outputs

| Pin   | Name   | Description      |
| ----- | ------ | ---------------- |
| uo[0] | A_gt_B | High when A > B  |
| uo[1] | A_eq_B | High when A == B |
| uo[2] | A_lt_B | High when A < B  |

## Unused Pins

All unused inputs and outputs are tied to 0.

## Test Strategy

The design is verified using cocotb. All 16 possible combinations of A and B (from 00 to 11) are tested to ensure correct comparator behavior.

## Applications

* Digital systems and ALUs
* Decision-making circuits
* Arithmetic logic design

## Author

Subiksha
