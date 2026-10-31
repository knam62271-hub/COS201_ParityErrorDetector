`timescale 1ns/1ps

module tb_top;

    reg  [7:0] data_in;
    reg        error_enable;
    wire       parity_bit;
    wire [7:0] data_rx;
    wire       error_flag;

    reg        expected;

    top dut (
        .data_in      (data_in),
        .error_enable (error_enable),
        .parity_bit   (parity_bit),
        .data_rx      (data_rx),
        .error_flag   (error_flag)
    );

    task check;
        input [7:0] d;
        input       e;
        begin
            data_in      = d;
            error_enable = e;
            #10;

            expected = e;

            if (error_flag === expected)
                $display("PASS: data_in=%b err_en=%b parity=%b data_rx=%b error_flag=%b", d, e, parity_bit, data_rx, error_flag);
            else
                $display("FAIL: data_in=%b err_en=%b parity=%b data_rx=%b error_flag=%b expected=%b", d, e, parity_bit, data_rx, error_flag, expected);
        end
    endtask

    initial begin
        check(8'd178, 1'b0);
        check(8'd178, 1'b1);
        check(8'd255, 1'b0);
        check(8'd255, 1'b1);
        check(8'd0,   1'b0);
        $stop;
    end

endmodule
