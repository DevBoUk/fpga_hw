`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2026 10:25:27 PM
// Design Name: 
// Module Name: decoder
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


//module decoder #(parameter WIDTH = 8)(
//    input logic [$clog2(WIDTH)-1:0]     sel,
//    //input logic [7:0]                   dio,
    
//    output logic [WIDTH-1:0]            out
//);
    
//    always_comb begin
//            out = 8'h00;       // default output value
    
//        case(sel)
//            3'b00:              out[0] = 1;
//            3'b01:              out[1] = 1;
//            3'b10:              out[2] = 1;
//            3'b011:             out[3] = 1;
//        endcase
//    end
        
    //        default;
    //    endcase
    
//        for (int i =0; i < WIDTH; i++) begin
//            if(sel == i) begin  
//                out[i] = 1;
//            end          
//        end 
    
//    end 

module counter_led4bit(
    input logic             clk,
    input logic             rst,
    
    output logic [3:0]      led = 4'b0000
    );
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            led <= 4'b0000;
        end else begin
             led <= led + 1'b1;
             end
    end

endmodule

