`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2023 03:53:26 PM
// Design Name: 
// Module Name: AHB_Master
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


module AHB_Master(Hclk,Hresetn,Hresp,Hrdata,Hwrite,Hready_in,Hready_out,Htrans,Hwdata,Haddr);

input Hclk,Hresetn,Hready_out;
input [1:0]Hresp;
input [31:0] Hrdata;
output reg [1:0] Hwrite,Hready_in;
output reg [1:0] Htrans;
output reg [31:0] Hwdata,Haddr;

reg [2:0] Hburst;
reg [2:0] Hsize;



task single_write();
    begin @(posedge Hclk);
        begin
            Hwrite=1'b1;
            Htrans=2'b10;
            Hsize=3'b000;
            Hburst=3'b000;
            Hready_in=1'b1;
            Haddr=32'h8000_0001;
        end
  
    @(posedge Hclk);
        begin
            Htrans=2'b00;
            Hwdata=32'h8000_5441;
        end 
    end
endtask


task single_read();
    begin @(posedge Hclk);
        begin
            Hwrite=0;
            Htrans=2'b00;
            Hsize=3'b000;
            Hburst=3'b000;
            Hready_in=1'b1;
            Haddr=32'h8000_0001;
        end
           
      
    @(posedge Hclk)
        begin
            Htrans=2'b00;
        end 
    end
endtask


endmodule
