# Pattern-Recognizer-using-Verilog
A Verilog FSM to recognize pattern such as email id, mobile number, date and postal code from the given text input.


There are three modules and a tesbench:
(i)InputModule  (ii)FSMModule     (iii)ControllerModule      (iv)TopTestbench

->InputModule cosists of logic to take text input bit by bit and give ascii output.

->FSMModule takes ascii code of text as input and recognizes pattern. Here there is a code of FSM where there are states present for each pattern and error handling is also present.

->ControllerModule joins InputModule and FSMModule.

->TopTestbench is a testbench for this project where you can give texxt input and have output n terms of Flags set or reset.

To run this code in ModelSIM, you just need to save all three modules and testbench in .v format.

Put the code given here for respective module.

Compile all the modules.

Now, simulate the Testbench which is TopTestbench and observe it's output and waveform. 
