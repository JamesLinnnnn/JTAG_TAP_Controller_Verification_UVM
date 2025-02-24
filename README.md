## Platform: Modelsim
I run UVM code on ModelSim

## Compiling Testbench Files
Only need to compile `testbench_top.sv` and `tap_controller.sv`.

## Setting Verbosity in ModelSim
You can set verbosity by running:

```sh
vsim -sv_seed random +UVM_VERBOSITY=UVM_LOW -l JTAG_Transcript.log top
```
## Running functional coverage:
```sh
vsim -coverage -c top -sv_seed random
```
## Type 
`run -all` on Modelsim Transcript
## If you want to get coverage report, go to 
`tool >> coverage report >> text >> choose details >> ok`

