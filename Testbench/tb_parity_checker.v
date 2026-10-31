`timescale 1ns/1ps

module tb_parity_checker;

    reg  [7:0] data_rx;
    reg        parity_rx;
    wire       error_flag;

    reg expected;

    parity_checker dut (
        .data_rx(data_rx),
        .parity_rx(parity_rx),
        .error_flag(error_flag)
    );

    task check;
        input [7:0] d;
        input p;
        input expected_value;

        begin
            data_rx = d;
            parity_rx = p;
            expected = expected_value;

            #10;

            if (error_flag === expected)
                $display("PASS: DATA=%b PARITY=%b ERROR=%b",
                         d, p, error_flag);
            else
                $display("FAIL: DATA=%b PARITY=%b ERROR=%b EXPECTED=%b",
                         d, p, error_flag, expected);
        end
    endtask

    initial begin

        // Test 1: No transmission error
        check(8'b10110010, 1'b0, 1'b0);

        // Test 2: One bit transmission error
        check(8'b10010010, 1'b0, 1'b1);

        // Test 3: No transmission error
        check(8'b11111111, 1'b0, 1'b0);

        // Test 4: One bit transmission error
        check(8'b11011111, 1'b0, 1'b1);

        // Test 5: Zero data
        check(8'b00000000, 1'b0, 1'b0);

        $display("-------------------------");
        $display("SIMULATION COMPLETED");

        $finish;
    end

endmodule
