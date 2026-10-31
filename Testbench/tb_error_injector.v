`timescale 1ns/1ps

module tb_error_injector;

    reg  [7:0] data_in;
    reg        error_enable;
    wire [7:0] data_out;

    reg  [7:0] expected;

    error_injector dut (
        .data_in      (data_in),
        .error_enable (error_enable),
        .data_out     (data_out)
    );

    task check;
        input [7:0] d;
        input       e;
        begin
            data_in      = d;
            error_enable = e;
            #10;

            expected = d;
            if (e) expected[5] = ~d[5];

            if (data_out === expected)
                $display("PASS: data_in=%b err_en=%b data_out=%b", d, e, data_out);
            else
                $display("FAIL: data_in=%b err_en=%b data_out=%b expected=%b", d, e, data_out, expected);
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
