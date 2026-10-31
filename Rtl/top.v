
module top (
    input wire [7:0] data_in,
    input wire error_enable,

    output wire parity_bit,
    output wire [7:0] data_rx,

    output wire ok_flag,
    output wire error_flag
);

    // Module 1: Parity Generator - Transmitter
    parity_generator U1 (
        .data_in(data_in),
        .parity_bit(parity_bit)
    );

    // Module 2: Transmission Channel
    // Mo phong loi truyen du lieu
    error_injector U2 (
        .data_in(data_in),
        .error_enable(error_enable),
        .data_out(data_rx)
    );

    // Module 3: Parity Checker - Receiver
    parity_checker U3 (
        .data_rx(data_rx),
        .parity_rx(parity_bit),
        .error_flag(error_flag)
    );

    // Ket qua kiem tra
    assign ok_flag = ~error_flag;

endmodule
