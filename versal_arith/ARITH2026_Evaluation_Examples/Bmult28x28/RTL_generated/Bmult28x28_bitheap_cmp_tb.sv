`timescale 1ns / 1ps
    
module Bmult28x28_bitheap_cmp_tb ();
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
    logic [6  : 0] col10;
    logic [5  : 0] col11;
    logic [7  : 0] col12;
    logic [6  : 0] col13;
    logic [8  : 0] col14;
    logic [7  : 0] col15;
    logic [9  : 0] col16;
    logic [8  : 0] col17;
    logic [10 : 0] col18;
    logic [9  : 0] col19;
    logic [11 : 0] col20;
    logic [10 : 0] col21;
    logic [12 : 0] col22;
    logic [11 : 0] col23;
    logic [13 : 0] col24;
    logic [12 : 0] col25;
    logic [14 : 0] col26;
    logic [13 : 0] col27;
    logic [14 : 0] col28;
    logic [13 : 0] col29;
    logic [12 : 0] col30;
    logic [12 : 0] col31;
    logic [11 : 0] col32;
    logic [11 : 0] col33;
    logic [10 : 0] col34;
    logic [10 : 0] col35;
    logic [9  : 0] col36;
    logic [9  : 0] col37;
    logic [8  : 0] col38;
    logic [8  : 0] col39;
    logic [7  : 0] col40;
    logic [7  : 0] col41;
    logic [6  : 0] col42;
    logic [6  : 0] col43;
    logic [5  : 0] col44;
    logic [5  : 0] col45;
    logic [4  : 0] col46;
    logic [4  : 0] col47;
    logic [3  : 0] col48;
    logic [3  : 0] col49;
    logic [2  : 0] col50;
    logic [2  : 0] col51;
    logic [1  : 0] col52;
    logic [1  : 0] col53;
    logic          col54;
    logic          col55;
    logic [56 : 0] comp_out;
        
    // ============================== DUT and its port connections ==============================
    Bmult28x28_bitheap_cmp dut (
        .clk          (clk          ),
        .col0          (col0          ),
        .col1          (col1          ),
        .col2          (col2          ),
        .col3          (col3          ),
        .col4          (col4          ),
        .col5          (col5          ),
        .col6          (col6          ),
        .col7          (col7          ),
        .col8          (col8          ),
        .col9          (col9          ),
        .col10         (col10         ),
        .col11         (col11         ),
        .col12         (col12         ),
        .col13         (col13         ),
        .col14         (col14         ),
        .col15         (col15         ),
        .col16         (col16         ),
        .col17         (col17         ),
        .col18         (col18         ),
        .col19         (col19         ),
        .col20         (col20         ),
        .col21         (col21         ),
        .col22         (col22         ),
        .col23         (col23         ),
        .col24         (col24         ),
        .col25         (col25         ),
        .col26         (col26         ),
        .col27         (col27         ),
        .col28         (col28         ),
        .col29         (col29         ),
        .col30         (col30         ),
        .col31         (col31         ),
        .col32         (col32         ),
        .col33         (col33         ),
        .col34         (col34         ),
        .col35         (col35         ),
        .col36         (col36         ),
        .col37         (col37         ),
        .col38         (col38         ),
        .col39         (col39         ),
        .col40         (col40         ),
        .col41         (col41         ),
        .col42         (col42         ),
        .col43         (col43         ),
        .col44         (col44         ),
        .col45         (col45         ),
        .col46         (col46         ),
        .col47         (col47         ),
        .col48         (col48         ),
        .col49         (col49         ),
        .col50         (col50         ),
        .col51         (col51         ),
        .col52         (col52         ),
        .col53         (col53         ),
        .col54         (col54         ),
        .col55         (col55         ),
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
    logic [6  : 0] col10_ts [`TS_SIZE-1 : 0];
    logic [5  : 0] col11_ts [`TS_SIZE-1 : 0];
    logic [7  : 0] col12_ts [`TS_SIZE-1 : 0];
    logic [6  : 0] col13_ts [`TS_SIZE-1 : 0];
    logic [8  : 0] col14_ts [`TS_SIZE-1 : 0];
    logic [7  : 0] col15_ts [`TS_SIZE-1 : 0];
    logic [9  : 0] col16_ts [`TS_SIZE-1 : 0];
    logic [8  : 0] col17_ts [`TS_SIZE-1 : 0];
    logic [10 : 0] col18_ts [`TS_SIZE-1 : 0];
    logic [9  : 0] col19_ts [`TS_SIZE-1 : 0];
    logic [11 : 0] col20_ts [`TS_SIZE-1 : 0];
    logic [10 : 0] col21_ts [`TS_SIZE-1 : 0];
    logic [12 : 0] col22_ts [`TS_SIZE-1 : 0];
    logic [11 : 0] col23_ts [`TS_SIZE-1 : 0];
    logic [13 : 0] col24_ts [`TS_SIZE-1 : 0];
    logic [12 : 0] col25_ts [`TS_SIZE-1 : 0];
    logic [14 : 0] col26_ts [`TS_SIZE-1 : 0];
    logic [13 : 0] col27_ts [`TS_SIZE-1 : 0];
    logic [14 : 0] col28_ts [`TS_SIZE-1 : 0];
    logic [13 : 0] col29_ts [`TS_SIZE-1 : 0];
    logic [12 : 0] col30_ts [`TS_SIZE-1 : 0];
    logic [12 : 0] col31_ts [`TS_SIZE-1 : 0];
    logic [11 : 0] col32_ts [`TS_SIZE-1 : 0];
    logic [11 : 0] col33_ts [`TS_SIZE-1 : 0];
    logic [10 : 0] col34_ts [`TS_SIZE-1 : 0];
    logic [10 : 0] col35_ts [`TS_SIZE-1 : 0];
    logic [9  : 0] col36_ts [`TS_SIZE-1 : 0];
    logic [9  : 0] col37_ts [`TS_SIZE-1 : 0];
    logic [8  : 0] col38_ts [`TS_SIZE-1 : 0];
    logic [8  : 0] col39_ts [`TS_SIZE-1 : 0];
    logic [7  : 0] col40_ts [`TS_SIZE-1 : 0];
    logic [7  : 0] col41_ts [`TS_SIZE-1 : 0];
    logic [6  : 0] col42_ts [`TS_SIZE-1 : 0];
    logic [6  : 0] col43_ts [`TS_SIZE-1 : 0];
    logic [5  : 0] col44_ts [`TS_SIZE-1 : 0];
    logic [5  : 0] col45_ts [`TS_SIZE-1 : 0];
    logic [4  : 0] col46_ts [`TS_SIZE-1 : 0];
    logic [4  : 0] col47_ts [`TS_SIZE-1 : 0];
    logic [3  : 0] col48_ts [`TS_SIZE-1 : 0];
    logic [3  : 0] col49_ts [`TS_SIZE-1 : 0];
    logic [2  : 0] col50_ts [`TS_SIZE-1 : 0];
    logic [2  : 0] col51_ts [`TS_SIZE-1 : 0];
    logic [1  : 0] col52_ts [`TS_SIZE-1 : 0];
    logic [1  : 0] col53_ts [`TS_SIZE-1 : 0];
    logic          col54_ts [`TS_SIZE-1 : 0];
    logic          col55_ts [`TS_SIZE-1 : 0];
    logic [56 : 0] comp_out_ts [`TS_SIZE-1 : 0];
    
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
        $readmemh("../../../../../testvectors/col20.txt", col20_ts);
        $readmemh("../../../../../testvectors/col21.txt", col21_ts);
        $readmemh("../../../../../testvectors/col22.txt", col22_ts);
        $readmemh("../../../../../testvectors/col23.txt", col23_ts);
        $readmemh("../../../../../testvectors/col24.txt", col24_ts);
        $readmemh("../../../../../testvectors/col25.txt", col25_ts);
        $readmemh("../../../../../testvectors/col26.txt", col26_ts);
        $readmemh("../../../../../testvectors/col27.txt", col27_ts);
        $readmemh("../../../../../testvectors/col28.txt", col28_ts);
        $readmemh("../../../../../testvectors/col29.txt", col29_ts);
        $readmemh("../../../../../testvectors/col30.txt", col30_ts);
        $readmemh("../../../../../testvectors/col31.txt", col31_ts);
        $readmemh("../../../../../testvectors/col32.txt", col32_ts);
        $readmemh("../../../../../testvectors/col33.txt", col33_ts);
        $readmemh("../../../../../testvectors/col34.txt", col34_ts);
        $readmemh("../../../../../testvectors/col35.txt", col35_ts);
        $readmemh("../../../../../testvectors/col36.txt", col36_ts);
        $readmemh("../../../../../testvectors/col37.txt", col37_ts);
        $readmemh("../../../../../testvectors/col38.txt", col38_ts);
        $readmemh("../../../../../testvectors/col39.txt", col39_ts);
        $readmemh("../../../../../testvectors/col40.txt", col40_ts);
        $readmemh("../../../../../testvectors/col41.txt", col41_ts);
        $readmemh("../../../../../testvectors/col42.txt", col42_ts);
        $readmemh("../../../../../testvectors/col43.txt", col43_ts);
        $readmemh("../../../../../testvectors/col44.txt", col44_ts);
        $readmemh("../../../../../testvectors/col45.txt", col45_ts);
        $readmemh("../../../../../testvectors/col46.txt", col46_ts);
        $readmemh("../../../../../testvectors/col47.txt", col47_ts);
        $readmemh("../../../../../testvectors/col48.txt", col48_ts);
        $readmemh("../../../../../testvectors/col49.txt", col49_ts);
        $readmemh("../../../../../testvectors/col50.txt", col50_ts);
        $readmemh("../../../../../testvectors/col51.txt", col51_ts);
        $readmemh("../../../../../testvectors/col52.txt", col52_ts);
        $readmemh("../../../../../testvectors/col53.txt", col53_ts);
        $readmemh("../../../../../testvectors/col54.txt", col54_ts);
        $readmemh("../../../../../testvectors/col55.txt", col55_ts);
        $readmemh("../../../../../testvectors/comp_out.txt", comp_out_ts);
    end
    
    // ============================== provide test input vectors ==============================
    int i;
    initial begin
        #`INIT_RESET;
        #`CLK_HP;
        #1;
        for (i = 0; i < `TS_SIZE; i = i + 1) begin
            col0          = col0_ts[i];
            col1          = col1_ts[i];
            col2          = col2_ts[i];
            col3          = col3_ts[i];
            col4          = col4_ts[i];
            col5          = col5_ts[i];
            col6          = col6_ts[i];
            col7          = col7_ts[i];
            col8          = col8_ts[i];
            col9          = col9_ts[i];
            col10         = col10_ts[i];
            col11         = col11_ts[i];
            col12         = col12_ts[i];
            col13         = col13_ts[i];
            col14         = col14_ts[i];
            col15         = col15_ts[i];
            col16         = col16_ts[i];
            col17         = col17_ts[i];
            col18         = col18_ts[i];
            col19         = col19_ts[i];
            col20         = col20_ts[i];
            col21         = col21_ts[i];
            col22         = col22_ts[i];
            col23         = col23_ts[i];
            col24         = col24_ts[i];
            col25         = col25_ts[i];
            col26         = col26_ts[i];
            col27         = col27_ts[i];
            col28         = col28_ts[i];
            col29         = col29_ts[i];
            col30         = col30_ts[i];
            col31         = col31_ts[i];
            col32         = col32_ts[i];
            col33         = col33_ts[i];
            col34         = col34_ts[i];
            col35         = col35_ts[i];
            col36         = col36_ts[i];
            col37         = col37_ts[i];
            col38         = col38_ts[i];
            col39         = col39_ts[i];
            col40         = col40_ts[i];
            col41         = col41_ts[i];
            col42         = col42_ts[i];
            col43         = col43_ts[i];
            col44         = col44_ts[i];
            col45         = col45_ts[i];
            col46         = col46_ts[i];
            col47         = col47_ts[i];
            col48         = col48_ts[i];
            col49         = col49_ts[i];
            col50         = col50_ts[i];
            col51         = col51_ts[i];
            col52         = col52_ts[i];
            col53         = col53_ts[i];
            col54         = col54_ts[i];
            col55         = col55_ts[i];
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
            if (comp_out[55:0] == comp_out_ts[j][55:0]) begin
                $display("Testvector-%d CORRECT!", j);
                correct_cnt = correct_cnt + 1;
            end else begin
                $display("=================================================================================");
                $display("Testvector-%d WRONG", j);
                $display("module    output: %b", comp_out[55:0]);
                $display("reference output: %b", comp_out_ts[j][55:0]);
                $display("difference:       %b", comp_out_ts[j][55:0] - comp_out[55:0]);
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