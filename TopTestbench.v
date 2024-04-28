`timescale 1ns / 1ps

module TopTestbench;
    // Testbench signals
    reg clk;
    reg rst;
    reg [7:0] user_input;
    wire email_detected;
    wire date_detected;
    wire mobile_detected;
    wire postal_code_detected;

    // Instantiate the ControllerModule
    ControllerModule uut (
        .clk(clk),
        .rst(rst),
        .user_input(user_input),
        .email_detected(email_detected),
        .date_detected(date_detected),
        .mobile_detected(mobile_detected),
        .postal_code_detected(postal_code_detected)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Generate a clock with a period of 20ns
    end

    // Test sequence
    initial begin
        // Reset the design
        rst = 1;
        #40;
        rst = 0;

        // Your test sequence here
           #5 user_input = "A"; 
        #10 user_input = "1"; 
        #10 user_input = "@"; 
        #10 user_input = "Z";

        // Finish the simulation
        #1000;
        $finish;
    end
endmodule
