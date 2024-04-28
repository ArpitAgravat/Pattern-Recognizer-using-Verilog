module ControllerModule(
    input wire clk,
    input wire rst,
    input wire [7:0] user_input,
    output wire email_detected,
    output wire date_detected,
    output wire mobile_detected,
    output wire postal_code_detected
);

    // Internal signals for inter-module communication
    wire [7:0] ascii_output;
    wire input_ready;
    wire fsm_ready;

    // Instantiate InputModule
    InputModule input_module (
        .clk(clk),
        .rst(rst),
        .user_input(user_input),
        .ascii_output(ascii_output),
        .input_ready(input_ready),
        .fsm_ready(fsm_ready)
    );

    // Instantiate FSMModule
    FSMModule fsm_module (
        .clk(clk),
        .rst(rst),
        .ascii_input(ascii_output),
        .input_valid(input_ready),
        .email_detected(email_detected),
        .date_detected(date_detected),
        .mobile_detected(mobile_detected),
        .postal_code_detected(postal_code_detected),
        .fsm_ready(fsm_ready)
    );

endmodule
