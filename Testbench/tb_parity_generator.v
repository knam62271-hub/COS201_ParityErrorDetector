`timescale 1ns/1ps

module tb_parity_generator;

    reg  [7:0] data_in;
    wire       parity_bit;

    reg        expected;

    parity_generator dut (
        .data_in    (data_in),
        .parity_bit (parity_bit)
    );

    task check;
        input [7:0] d;
        begin
            data_in = d;
            #10;

            expected = ^d;

            if (parity_bit === expected)
                $display("PASS: data_in=%b parity_bit=%b", d, parity_bit);
            else
                $display("FAIL: data_in=%b parity_bit=%b expected=%b", d, parity_bit, expected);
        end
    endtask

    initial begin
        check(8'd178);
        check(8'd178);
        check(8'd255);
        check(8'd255);
        check(8'd0);
        check(8'b00000001);
        check(8'b10000000);
        check(8'b01110000);
        $stop;
    end

endmodule
