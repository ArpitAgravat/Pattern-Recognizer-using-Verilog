module InputModule(
    input wire clk,
    input wire rst,
    input wire [7:0] user_input, // ASCII value of the character
    output reg [7:0] ascii_output,
    output reg input_ready,
    input wire fsm_ready
);

    reg new_data_available;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all outputs and flags
            ascii_output <= 8'b0;
            input_ready <= 0;
            new_data_available <= 0;
        end else if (fsm_ready && new_data_available) begin
            // When FSM is ready and new data is available, output the data
            input_ready <= 1;
            new_data_available <= 0; // Clear the new data flag
        end else if (!new_data_available) begin
            // Buffer the new input
            ascii_output <= user_input;
            new_data_available <= 1; // Set the new data flag
        end else begin
            // Keep the output ready until FSM accepts the data
            input_ready <= fsm_ready ? 0 : input_ready;
        end
    end

endmodule
