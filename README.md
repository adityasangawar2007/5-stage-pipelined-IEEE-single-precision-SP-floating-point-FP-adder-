# 5-stage-pipelined-IEEE-single-precision-SP-floating-point-FP-adder-
The design has two parts:
Part A 
Designed an un-pipelined SP FP adder, with results in the form of value and waveforms for certain test cases. 
Part B 
Modified the design to the 5-stage pipelined FP adder. This design takes 12 cycles to output all 8 cases. Stage 1: Compares the exponents and determine the amount of shifts required to align the mantissa to make the exponents equal (alignment-1). Stage 2: Right-shift the mantissa of the smaller exponent by the required amount (alignment-2). Stage 3: Compares the two aligned mantissas and determine which is the smaller of the two. This is followed by takeing 2’s complement of the smaller mantissa if the signs of the two numbers are different (addition). Stage 4: Add the two mantissas. Then, determine the amount of shifts required and the corresponding direction to normalize the result (normalization-1). Stage 5: Shift the mantissa to the required direction by the required amount. Adjust the exponent accordingly and check for any exceptional condition (normalization-2).
