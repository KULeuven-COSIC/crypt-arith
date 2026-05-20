`timescale 1ns / 1ps
    
module Comp_single256_3_tb ();
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
    logic [255 : 0] in_col0;
    logic [8   : 0] comp_out;
        
    // ============================== DUT and its port connections ==============================
    Comp_single256_3 dut (
        .clk     (clk     ),
        .in_col0  (in_col0  ),
        .comp_out(comp_out));
    
    // ============================== testvectors ==============================
    logic [255 : 0] in_col0_ts [`TS_SIZE-1 : 0];
    logic [8   : 0] comp_out_ts [`TS_SIZE-1 : 0];
    
    // ============================== read testvector values ==============================
    initial begin
        $readmemh("../../../../../testvectors/in_col0.txt", in_col0_ts);
        $readmemh("../../../../../testvectors/comp_out.txt", comp_out_ts);
    end
    
    // ============================== provide test input vectors ==============================
    int i;
    initial begin
        #`INIT_RESET;
        #`CLK_HP;
        #1;
        for (i = 0; i < `TS_SIZE; i = i + 1) begin
            in_col0  = in_col0_ts[i];
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
        #(`CLK_P*3);
        #1;
        for (j = 0; j < `TS_SIZE; j = j + 1) begin
            if (comp_out[8:0] == comp_out_ts[j][8:0]) begin
                $display("Testvector-%d CORRECT!", j);
                correct_cnt = correct_cnt + 1;
            end else begin
                $display("=================================================================================");
                $display("Testvector-%d WRONG", j);
                $display("module    output: %b", comp_out[8:0]);
                $display("reference output: %b", comp_out_ts[j][8:0]);
                $display("difference:       %b", comp_out_ts[j][8:0] - comp_out[8:0]);
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