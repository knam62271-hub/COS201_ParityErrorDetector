`timescale 1ns/1ps

module tb_parity_checker;

    reg  [7:0] data_rx;
    reg        parity_rx;
    wire       error_flag;

    reg        expected;

    parity_checker dut (
        .data_rx   (data_rx),
        .parity_rx (parity_rx),
        .error_flag(error_flag)
    );

    task check;
        input [7:0] d;
        input       p;
        begin
            data_rx   = d;
            parity_rx = p;
            #10;

            expected = ^{d, p};

            if (error_flag === expected)
                $display("PASS: data_rx=%b parity_rx=%b error_flag=%b", d, p, error_flag);
            else
                $display("FAIL: data_rx=%b parity_rx=%b error_flag=%b expected=%b", d, p, error_flag, expected);
        end
    endtask

    initial begin
        check(8'b10110010, 1'b0);
        check(8'b10110010, 1'b1);
        check(8'b11111111, 1'b0);
        check(8'b11111111, 1'b1);
        check(8'b00000000, 1'b0);
        check(8'b00000000, 1'b1);
        $stop;
    end

endmodule
