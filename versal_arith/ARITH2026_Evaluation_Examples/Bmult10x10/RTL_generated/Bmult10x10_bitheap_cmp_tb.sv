`timescale 1ns / 1ps
    
module Bmult10x10_bitheap_cmp_tb ();
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
    logic [1  : 0] col0;
    logic          col1;
    logic [2  : 0] col2;
    logic [1  : 0] col3;
    logic [3  : 0] col4;
    logic [2  : 0] col5;
    logic [4  : 0] col6;
    logic [3  : 0] col7;
    logic [5  : 0] col8;
    logic [4  : 0] col9;
    logic [5  : 0] col10;
    logic [4  : 0] col11;
    logic [3  : 0] col12;
    logic [3  : 0] col13;
    logic [2  : 0] col14;
    logic [2  : 0] col15;
    logic [1  : 0] col16;
    logic [1  : 0] col17;
    logic          col18;
    logic          col19;
    logic [20 : 0] comp_out;
        
    // ============================== DUT and its port connections ==============================
    Bmult10x10_bitheap_cmp dut (
        .clk         (clk         ),
        .col0         (col0         ),
        .col1         (col1         ),
        .col2         (col2         ),
        .col3         (col3         ),
        .col4         (col4         ),
        .col5         (col5         ),
        .col6         (col6         ),
        .col7         (col7         ),
        .col8         (col8         ),
        .col9         (col9         ),
        .col10        (col10        ),
        .col11        (col11        ),
        .col12        (col12        ),
        .col13        (col13        ),
        .col14        (col14        ),
        .col15        (col15        ),
        .col16        (col16        ),
        .col17        (col17        ),
        .col18        (col18        ),
        .col19        (col19        ),
        .comp_out(comp_out));
    
    // ============================== testvectors ==============================
    logic [1  : 0] col0_ts [`TS_SIZE-1 : 0];
    logic          col1_ts [`TS_SIZE-1 : 0];
    logic [2  : 0] col2_ts [`TS_SIZE-1 : 0];
    logic [1  : 0] col3_ts [`TS_SIZE-1 : 0];
    logic [3  : 0] col4_ts [`TS_SIZE-1 : 0];
    logic [2  : 0] col5_ts [`TS_SIZE-1 : 0];
    logic [4  : 0] col6_ts [`TS_SIZE-1 : 0];
    logic [3  : 0] col7_ts [`TS_SIZE-1 : 0];
    logic [5  : 0] col8_ts [`TS_SIZE-1 : 0];
    logic [4  : 0] col9_ts [`TS_SIZE-1 : 0];
    logic [5  : 0] col10_ts [`TS_SIZE-1 : 0];
    logic [4  : 0] col11_ts [`TS_SIZE-1 : 0];
    logic [3  : 0] col12_ts [`TS_SIZE-1 : 0];
    logic [3  : 0] col13_ts [`TS_SIZE-1 : 0];
    logic [2  : 0] col14_ts [`TS_SIZE-1 : 0];
    logic [2  : 0] col15_ts [`TS_SIZE-1 : 0];
    logic [1  : 0] col16_ts [`TS_SIZE-1 : 0];
    logic [1  : 0] col17_ts [`TS_SIZE-1 : 0];
    logic          col18_ts [`TS_SIZE-1 : 0];
    logic          col19_ts [`TS_SIZE-1 : 0];
    logic [20 : 0] comp_out_ts [`TS_SIZE-1 : 0];
    
    // ============================== read testvector values ==============================
    initial begin
        $readmemh("../../../../../testvectors/col0.txt", col0_ts);
        $readmemh("../../../../../testvectors/col1.txt", col1_ts);
        $readmemh("../../../../../testvectors/col2.txt", col2_ts);
        $readmemh("../../../../../testvectors/col3.txt", col3_ts);
        $readmemh("../../../../../testvectors/col4.txt", col4_ts);
        $readmemh("../../../../../testvectors/col5.txt", col5_ts);
        $readmemh("../../../../../testvectors/col6.txt", col6_ts);
        $readmemh("../../../../../testvectors/col7.txt", col7_ts);
        $readmemh("../../../../../testvectors/col8.txt", col8_ts);
        $readmemh("../../../../../testvectors/col9.txt", col9_ts);
        $readmemh("../../../../../testvectors/col10.txt", col10_ts);
        $readmemh("../../../../../testvectors/col11.txt", col11_ts);
        $readmemh("../../../../../testvectors/col12.txt", col12_ts);
        $readmemh("../../../../../testvectors/col13.txt", col13_ts);
        $readmemh("../../../../../testvectors/col14.txt", col14_ts);
        $readmemh("../../../../../testvectors/col15.txt", col15_ts);
        $readmemh("../../../../../testvectors/col16.txt", col16_ts);
        $readmemh("../../../../../testvectors/col17.txt", col17_ts);
        $readmemh("../../../../../testvectors/col18.txt", col18_ts);
        $readmemh("../../../../../testvectors/col19.txt", col19_ts);
        $readmemh("../../../../../testvectors/comp_out.txt", comp_out_ts);
    end
    
    // ============================== provide test input vectors ==============================
    int i;
    initial begin
        #`INIT_RESET;
        #`CLK_HP;
        #1;
        for (i = 0; i < `TS_SIZE; i = i + 1) begin
            col0         = col0_ts[i];
            col1         = col1_ts[i];
            col2         = col2_ts[i];
            col3         = col3_ts[i];
            col4         = col4_ts[i];
            col5         = col5_ts[i];
            col6         = col6_ts[i];
            col7         = col7_ts[i];
            col8         = col8_ts[i];
            col9         = col9_ts[i];
            col10        = col10_ts[i];
            col11        = col11_ts[i];
            col12        = col12_ts[i];
            col13        = col13_ts[i];
            col14        = col14_ts[i];
            col15        = col15_ts[i];
            col16        = col16_ts[i];
            col17        = col17_ts[i];
            col18        = col18_ts[i];
            col19        = col19_ts[i];
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
            if (comp_out[19:0] == comp_out_ts[j][19:0]) begin
                $display("Testvector-%d CORRECT!", j);
                correct_cnt = correct_cnt + 1;
            end else begin
                $display("=================================================================================");
                $display("Testvector-%d WRONG", j);
                $display("module    output: %b", comp_out[19:0]);
                $display("reference output: %b", comp_out_ts[j][19:0]);
                $display("difference:       %b", comp_out_ts[j][19:0] - comp_out[19:0]);
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