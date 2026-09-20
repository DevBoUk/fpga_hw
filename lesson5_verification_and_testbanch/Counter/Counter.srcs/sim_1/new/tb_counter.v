`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2026 06:27:23 PM
// Design Name: 
// Module Name: tb_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_counter;
    reg         clk;
    reg         rst;
    reg         load;
    reg  [3:0]  data_in;
    reg         en;
    reg         up_down;
    
    wire [3:0]    count;
    
    counter dut(.clk(clk), .rst(rst), .load(load), .data_in(data_in), .en(en), .up_down(up_down), .count(count));
   
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
    task automatic check_count;
    
        input [3:0]     count;
        input [3:0]     expected;
        input string    name;
        //check_count(count,expected, name);
            
        begin
            if (count===expected)
                $display("[%0t ns] - %s,  - PASS: count=%0d, expected=%0d", $time, name, count, expected);
            else
                $display("[%0t ns] - %s,  - FAIL: count=%0d, expected=%0d", $time, name, count, expected);
        end 
    endtask;
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //clock generator
    initial clk=0;
    always #5 clk=~clk;
    
    initial begin
        $display(" [%0t ns] BEFORE reset: counter = %b<-X state, count_reg has no value yet ", $time, count);
        clk=0;   rst=1; load=0; data_in = 4'd10; en=0; up_down=1;
        @(posedge clk); #1;
        rst=0;
        $display("[%0t ns] AFTER reset: count = %0d", $time, count);
        
 // 3. Check LOAD CMD
        load =1;
        @(posedge clk) #1;
        check_count(count, 4'd10, "p.3 - signal Load test"); // p.3 LOAD
 // 4. Up Counter Verify
        #1;     // delay 1ns for stabilize output valyue
        load =0;
        en=1;
        @(posedge clk) #1;
        @(posedge clk) #1;
        @(posedge clk) #1;
        check_count(count,  4'd13,   "p.4 - Up Counter Verify 1st stage");
       
        @(posedge clk) #1;
        @(posedge clk) #1;
        @(posedge clk) #1;
        check_count(count,  0,      "p.4 - Up Counter Verify 2nd stage");  
        #1     
//en=0 latch varifier
        en=0;
        @(posedge clk) #1;
        @(posedge clk) #1;
        
        check_count(count,  0,      "p.5 - en=0 latch output verifier"); 
        #1
  //6. DownCounter      
        en=1; up_down=0;
        @(posedge clk) #1;
        check_count(count,  15,      "p.6 - down counter verifier"); 
        #1
 // 7. Prority load vs en. Who is the boss???
  
        load=1; data_in=4'd5; en=1; up_down=1;
        @(posedge clk) #1;
        check_count(count,  5,      "p.7 - Prority load vs en. Who is the boss???");
  
 
        $finish;
   end  
endmodule
