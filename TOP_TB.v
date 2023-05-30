`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2023 09:20:40 AM
// Design Name: 
// Module Name: TOP_TB
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



module top_tb();
reg Hclk,Hresetn;
wire [1:0]Hready_out,Hwrite,Hready_in;
wire [31:0]Hr_data,Haddr,Hwdata,Paddr,Pwdata,Paddrout,Pwdataout,Pr_data;
wire [1:0]Hres,Htrans;
wire Penable,Pwrite,Pwriteout,Penableout;
wire [2:0]Psel,Pselout;
AHB_Master ahb(Hclk,Hresetn,Hready_out,Hr_data,Haddr,Hwdata,Hwrite,Hready_in,Htrans);
Bridge_Top bridge(Hclk,Hresetn,Hwrite,Hready_in,Htrans,Hwdata,Haddr,Pr_data,Penable,Pwrite,Hready_out,Psel,Hres,Paddr,Pwdata,Hr_data);
APB_Interface apb(Pwrite,Psel,Penable,Paddr,Pwdata,Pwriteout,Pselout,Penableout,Paddrout,Pwdataout,Pr_data);
initial
    begin
        Hclk=1'b0;
        forever #10 Hclk=~Hclk;
    end
task reset();
    begin
        @(negedge Hclk)
            Hresetn=1'b0;
        @(negedge Hclk)
            Hresetn=1'b1;
    end
endtask
initial
    begin
        reset;
        ahb.single_write();
        #500 $finish;
    end
endmodule
