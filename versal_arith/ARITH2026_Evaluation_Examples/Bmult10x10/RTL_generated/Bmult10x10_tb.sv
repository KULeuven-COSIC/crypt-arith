`timescale 1ns / 1ps

module Bmult10x10_tb ();
    // ============================== parameters ==============================
    `define CLK_P         10
    `define CLK_HP        5
    `define TS_SIZE       1000
    `define INIT_RESET    200
    
    // ============================== clock ==============================
    logic clk;
    initial clk = 1'b0;
    always #`CLK_HP clk = ~clk;

    // ============================== in/out signals for DUT ==============================
    logic [9  : 0] A;
    logic [9  : 0] B;
    logic [19 : 0] P;
    logic [9  : 0] A_ts[`TS_SIZE-1 : 0];
    logic [9  : 0] B_ts[`TS_SIZE-1 : 0];
    logic [19 : 0] P_ts[`TS_SIZE-1 : 0];

    // ============================== read testvector values ==============================
    initial begin
        $readmemh("../../../../../testvectors/A.txt", A_ts);
        $readmemh("../../../../../testvectors/B.txt", B_ts);
        $readmemh("../../../../../testvectors/P.txt", P_ts);
    end
    
    // ============================== instantiate DUT and connect its ports ==============================
    Bmult10x10 DUT (
        .clk(clk),
        .A  (A  ),
        .B  (B  ),
        .P  (P  ));
    
    // ============================== provide test input vectors ==============================
    int i;
    initial begin
        #`INIT_RESET;
        #`CLK_HP;
        #1;
        for (i = 0; i < `TS_SIZE; i = i + 1) begin
            A = A_ts[i];
            B = B_ts[i];
            #`CLK_P;
        end
    end
    
    // ============================== check the correctness of output ==============================    
    int j;
    int correct_cnt;
    initial begin
        correct_cnt = 0;
        #`INIT_RESET;
        #`CLK_HP;
        #(`CLK_P*1);
        #1;
        for (j = 0; j < `TS_SIZE; j = j + 1) begin
            if (P == P_ts[j]) begin
                $display("Testvector-%d CORRECT!", j);
                correct_cnt = correct_cnt + 1;
            end else begin
                $display("=================================================================================");
                $display("Testvector-%d WRONG", j);
                $display("module    output: %b", P);
                $display("reference output: %b", P_ts[j]);
                $display("difference:       %b", P_ts[j] - P);
                $display("=================================================================================");
            end
            #`CLK_P;
        end
        if (correct_cnt == `TS_SIZE) begin
            $display("SUCCESS!");
            $display("PASS All %d Testvectors!", `TS_SIZE);
        end else begin
            $display("TO BE DEBUGGED...");
            $display("%d out of %d testvectors failed...", (`TS_SIZE-correct_cnt), `TS_SIZE);
        end
        $finish();
    end

endmodule
    