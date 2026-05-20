`timescale 1ns / 1ps
    
module Comp_Mult16_3_tb ();
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
    logic          in_col0;
    logic [1  : 0] in_col1;
    logic [2  : 0] in_col2;
    logic [3  : 0] in_col3;
    logic [4  : 0] in_col4;
    logic [5  : 0] in_col5;
    logic [6  : 0] in_col6;
    logic [7  : 0] in_col7;
    logic [8  : 0] in_col8;
    logic [9  : 0] in_col9;
    logic [10 : 0] in_col10;
    logic [11 : 0] in_col11;
    logic [12 : 0] in_col12;
    logic [13 : 0] in_col13;
    logic [14 : 0] in_col14;
    logic [15 : 0] in_col15;
    logic [14 : 0] in_col16;
    logic [13 : 0] in_col17;
    logic [12 : 0] in_col18;
    logic [11 : 0] in_col19;
    logic [10 : 0] in_col20;
    logic [9  : 0] in_col21;
    logic [8  : 0] in_col22;
    logic [7  : 0] in_col23;
    logic [6  : 0] in_col24;
    logic [5  : 0] in_col25;
    logic [4  : 0] in_col26;
    logic [3  : 0] in_col27;
    logic [2  : 0] in_col28;
    logic [1  : 0] in_col29;
    logic          in_col30;
    logic [31 : 0] comp_out;
        
    // ============================== DUT and its port connections ==============================
    Comp_Mult16_3 dut (
        .clk         (clk         ),
        .in_col0      (in_col0      ),
        .in_col1      (in_col1      ),
        .in_col2      (in_col2      ),
        .in_col3      (in_col3      ),
        .in_col4      (in_col4      ),
        .in_col5      (in_col5      ),
        .in_col6      (in_col6      ),
        .in_col7      (in_col7      ),
        .in_col8      (in_col8      ),
        .in_col9      (in_col9      ),
        .in_col10     (in_col10     ),
        .in_col11     (in_col11     ),
        .in_col12     (in_col12     ),
        .in_col13     (in_col13     ),
        .in_col14     (in_col14     ),
        .in_col15     (in_col15     ),
        .in_col16     (in_col16     ),
        .in_col17     (in_col17     ),
        .in_col18     (in_col18     ),
        .in_col19     (in_col19     ),
        .in_col20     (in_col20     ),
        .in_col21     (in_col21     ),
        .in_col22     (in_col22     ),
        .in_col23     (in_col23     ),
        .in_col24     (in_col24     ),
        .in_col25     (in_col25     ),
        .in_col26     (in_col26     ),
        .in_col27     (in_col27     ),
        .in_col28     (in_col28     ),
        .in_col29     (in_col29     ),
        .in_col30     (in_col30     ),
        .comp_out(comp_out));
    
    // ============================== testvectors ==============================
    logic          in_col0_ts [`TS_SIZE-1 : 0];
    logic [1  : 0] in_col1_ts [`TS_SIZE-1 : 0];
    logic [2  : 0] in_col2_ts [`TS_SIZE-1 : 0];
    logic [3  : 0] in_col3_ts [`TS_SIZE-1 : 0];
    logic [4  : 0] in_col4_ts [`TS_SIZE-1 : 0];
    logic [5  : 0] in_col5_ts [`TS_SIZE-1 : 0];
    logic [6  : 0] in_col6_ts [`TS_SIZE-1 : 0];
    logic [7  : 0] in_col7_ts [`TS_SIZE-1 : 0];
    logic [8  : 0] in_col8_ts [`TS_SIZE-1 : 0];
    logic [9  : 0] in_col9_ts [`TS_SIZE-1 : 0];
    logic [10 : 0] in_col10_ts [`TS_SIZE-1 : 0];
    logic [11 : 0] in_col11_ts [`TS_SIZE-1 : 0];
    logic [12 : 0] in_col12_ts [`TS_SIZE-1 : 0];
    logic [13 : 0] in_col13_ts [`TS_SIZE-1 : 0];
    logic [14 : 0] in_col14_ts [`TS_SIZE-1 : 0];
    logic [15 : 0] in_col15_ts [`TS_SIZE-1 : 0];
    logic [14 : 0] in_col16_ts [`TS_SIZE-1 : 0];
    logic [13 : 0] in_col17_ts [`TS_SIZE-1 : 0];
    logic [12 : 0] in_col18_ts [`TS_SIZE-1 : 0];
    logic [11 : 0] in_col19_ts [`TS_SIZE-1 : 0];
    logic [10 : 0] in_col20_ts [`TS_SIZE-1 : 0];
    logic [9  : 0] in_col21_ts [`TS_SIZE-1 : 0];
    logic [8  : 0] in_col22_ts [`TS_SIZE-1 : 0];
    logic [7  : 0] in_col23_ts [`TS_SIZE-1 : 0];
    logic [6  : 0] in_col24_ts [`TS_SIZE-1 : 0];
    logic [5  : 0] in_col25_ts [`TS_SIZE-1 : 0];
    logic [4  : 0] in_col26_ts [`TS_SIZE-1 : 0];
    logic [3  : 0] in_col27_ts [`TS_SIZE-1 : 0];
    logic [2  : 0] in_col28_ts [`TS_SIZE-1 : 0];
    logic [1  : 0] in_col29_ts [`TS_SIZE-1 : 0];
    logic          in_col30_ts [`TS_SIZE-1 : 0];
    logic [31 : 0] comp_out_ts [`TS_SIZE-1 : 0];
    
    // ============================== read testvector values ==============================
    initial begin
        $readmemh("../../../../../testvectors/in_col0.txt", in_col0_ts);
        $readmemh("../../../../../testvectors/in_col1.txt", in_col1_ts);
        $readmemh("../../../../../testvectors/in_col2.txt", in_col2_ts);
        $readmemh("../../../../../testvectors/in_col3.txt", in_col3_ts);
        $readmemh("../../../../../testvectors/in_col4.txt", in_col4_ts);
        $readmemh("../../../../../testvectors/in_col5.txt", in_col5_ts);
        $readmemh("../../../../../testvectors/in_col6.txt", in_col6_ts);
        $readmemh("../../../../../testvectors/in_col7.txt", in_col7_ts);
        $readmemh("../../../../../testvectors/in_col8.txt", in_col8_ts);
        $readmemh("../../../../../testvectors/in_col9.txt", in_col9_ts);
        $readmemh("../../../../../testvectors/in_col10.txt", in_col10_ts);
        $readmemh("../../../../../testvectors/in_col11.txt", in_col11_ts);
        $readmemh("../../../../../testvectors/in_col12.txt", in_col12_ts);
        $readmemh("../../../../../testvectors/in_col13.txt", in_col13_ts);
        $readmemh("../../../../../testvectors/in_col14.txt", in_col14_ts);
        $readmemh("../../../../../testvectors/in_col15.txt", in_col15_ts);
        $readmemh("../../../../../testvectors/in_col16.txt", in_col16_ts);
        $readmemh("../../../../../testvectors/in_col17.txt", in_col17_ts);
        $readmemh("../../../../../testvectors/in_col18.txt", in_col18_ts);
        $readmemh("../../../../../testvectors/in_col19.txt", in_col19_ts);
        $readmemh("../../../../../testvectors/in_col20.txt", in_col20_ts);
        $readmemh("../../../../../testvectors/in_col21.txt", in_col21_ts);
        $readmemh("../../../../../testvectors/in_col22.txt", in_col22_ts);
        $readmemh("../../../../../testvectors/in_col23.txt", in_col23_ts);
        $readmemh("../../../../../testvectors/in_col24.txt", in_col24_ts);
        $readmemh("../../../../../testvectors/in_col25.txt", in_col25_ts);
        $readmemh("../../../../../testvectors/in_col26.txt", in_col26_ts);
        $readmemh("../../../../../testvectors/in_col27.txt", in_col27_ts);
        $readmemh("../../../../../testvectors/in_col28.txt", in_col28_ts);
        $readmemh("../../../../../testvectors/in_col29.txt", in_col29_ts);
        $readmemh("../../../../../testvectors/in_col30.txt", in_col30_ts);
        $readmemh("../../../../../testvectors/comp_out.txt", comp_out_ts);
    end
    
    // ============================== provide test input vectors ==============================
    int i;
    initial begin
        #`INIT_RESET;
        #`CLK_HP;
        #1;
        for (i = 0; i < `TS_SIZE; i = i + 1) begin
            in_col0      = in_col0_ts[i];
            in_col1      = in_col1_ts[i];
            in_col2      = in_col2_ts[i];
            in_col3      = in_col3_ts[i];
            in_col4      = in_col4_ts[i];
            in_col5      = in_col5_ts[i];
            in_col6      = in_col6_ts[i];
            in_col7      = in_col7_ts[i];
            in_col8      = in_col8_ts[i];
            in_col9      = in_col9_ts[i];
            in_col10     = in_col10_ts[i];
            in_col11     = in_col11_ts[i];
            in_col12     = in_col12_ts[i];
            in_col13     = in_col13_ts[i];
            in_col14     = in_col14_ts[i];
            in_col15     = in_col15_ts[i];
            in_col16     = in_col16_ts[i];
            in_col17     = in_col17_ts[i];
            in_col18     = in_col18_ts[i];
            in_col19     = in_col19_ts[i];
            in_col20     = in_col20_ts[i];
            in_col21     = in_col21_ts[i];
            in_col22     = in_col22_ts[i];
            in_col23     = in_col23_ts[i];
            in_col24     = in_col24_ts[i];
            in_col25     = in_col25_ts[i];
            in_col26     = in_col26_ts[i];
            in_col27     = in_col27_ts[i];
            in_col28     = in_col28_ts[i];
            in_col29     = in_col29_ts[i];
            in_col30     = in_col30_ts[i];
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
            if (comp_out[31:0] == comp_out_ts[j][31:0]) begin
                $display("Testvector-%d CORRECT!", j);
                correct_cnt = correct_cnt + 1;
            end else begin
                $display("=================================================================================");
                $display("Testvector-%d WRONG", j);
                $display("module    output: %b", comp_out[31:0]);
                $display("reference output: %b", comp_out_ts[j][31:0]);
                $display("difference:       %b", comp_out_ts[j][31:0] - comp_out[31:0]);
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