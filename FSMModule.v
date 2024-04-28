module FSMModule(
    input wire clk,
    input wire rst,
    input wire [7:0] ascii_input,
    input wire input_valid,
    output reg email_detected,
    output reg date_detected,
    output reg mobile_detected,
    output reg postal_code_detected,
    output reg fsm_ready
);

    // State declaration
    reg [2:0] state;
    localparam IDLE = 3'b000,
               EMAIL = 3'b001,
               MOBILE = 3'b010,
               DATE = 3'b011,
               POSTAL = 3'b100,
               ERROR_STATE = 3'b101;

    // Initialize outputs
    initial begin
        email_detected = 0;
        date_detected = 0;
        mobile_detected = 0;
        postal_code_detected = 0;
        fsm_ready = 1;
    end

    // FSM state transition logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset logic
            state <= IDLE;
            email_detected <= 0;
            date_detected <= 0;
            mobile_detected <= 0;
            postal_code_detected <= 0;
            fsm_ready <= 1; // FSM is ready after reset
        end else if (input_valid && fsm_ready) begin
            // Process input only if valid and FSM is ready
            fsm_ready <= 0; // FSM is now busy processing the input
            case (state)
                IDLE: begin
                    // Check for start of different patterns
                    if (ascii_input == 8'd64) begin // '@' symbol for email
                        state <= EMAIL;
                    end else if (ascii_input >= 8'd48 && ascii_input <= 8'd57) begin // Digits for mobile
                        state <= MOBILE;
                    end else if (ascii_input == 8'd47 || ascii_input == 8'd45) begin // '/' or '-' for date
                        state <= DATE;
                    end else if ((ascii_input >= 8'd65 && ascii_input <= 8'd90) || 
                                 (ascii_input >= 8'd97 && ascii_input <= 8'd122)) begin // Letters for postal code
                        state <= POSTAL;
                    end else begin
                        state <= ERROR_STATE;
                    end
                end
                EMAIL: begin
                    // Email detection logic
                    if (ascii_input == 8'd46) begin // '.' character
                        email_detected <= 1;
                        state <= IDLE;
                    end else if (ascii_input != 8'd64 && ascii_input != 8'd46) begin
                        state <= EMAIL;
                    end else begin
                        state <= ERROR_STATE;
                    end
                end
                MOBILE: begin
                    // Mobile number detection logic
                    if (ascii_input >= 8'd48 && ascii_input <= 8'd57) begin // Digits
                        mobile_detected <= 1;
                        state <= IDLE;
                    end else begin
                        state <= ERROR_STATE;
                    end
                end
                DATE: begin
                    // Date detection logic
                    if (ascii_input == 8'd47 || ascii_input == 8'd45) begin // '/' or '-'
                        date_detected <= 1;
                        state <= IDLE;
                    end else begin
                        state <= ERROR_STATE;
                    end
                end
                POSTAL: begin
                    // Postal code detection logic
                    if ((ascii_input >= 8'd48 && ascii_input <= 8'd57) || ascii_input == 8'd45) begin // Digits or '-'
                        postal_code_detected <= 1;
                        state <= IDLE;
                    end else begin
                        state <= ERROR_STATE;
                    end
                end
                ERROR_STATE: begin
                    // Error state logic
                    state <= IDLE;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end else begin
            fsm_ready <= 1; // FSM is ready for the next input
        end
    end
endmodule
