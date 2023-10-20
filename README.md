# pes_bfloat_adder

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/6fbc1713-8722-410d-8f97-efb756fb33a6)

In computing, floating-point arithmetic (FP) is arithmetic that represents subsets of real numbers using an integer with a fixed precision, called the significand, scaled by an integer exponent of a fixed base. Numbers of this form are called floating-point numbers

Floating-point arithmetic operations, such as addition and division, approximate the corresponding real number arithmetic operations by rounding any result that is not a floating-point number itself to a nearby floating-point number.[1]: 22 [2]: 10  For example, in a floating-point arithmetic with five base-ten digits of precision, the sum 12.345 + 1.0001 = 13.3451 might be rounded to 13.345.

# Implementation

<details>
<summary>Synthesis</summary>
<br>

```
yosys
read_liberty -lib <path to your lib file>
read_verilog bfloat_adder.v
synth -top bfloat_adder
dfflibmap -liberty
abc -liberty
flatten
show
write_verilog bfloat_adder_mapped.v
```

#### Statistics

![Screenshot from 2023-10-20 20-59-38](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/386c00aa-2480-41a6-8ed6-67b334574ce2)

#### Logic Synthesis

![Screenshot from 2023-10-20 20-33-32](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/24bd86a8-9ba4-44bb-97c7-80efaaf6dfd4)

</details>

<details>
<summary>Gate Level Simulation</summary>
<br>

### Pre Synthesis Simulation

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/c5a2d4e6-120d-4ee0-b131-e6b9db6b05c8)

![Screenshot from 2023-10-20 19-55-35](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/8ce6c566-5edb-40b7-9b19-a65c3236de17)

### Post Synthesis Simulation

![image](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/6a1d4459-845c-4703-831b-189e5adc8a58)


![Screenshot from 2023-10-20 21-11-14](https://github.com/Lo-kesh4/PES_bfloat_adder/assets/131575546/f0cb624d-1340-41c4-9c0b-cf1b921a4879)

</details>
