module asy_fifo_tb();
reg wclk,rclk,rst,wen,ren;
reg [7:0]din;
wire [7:0]dout;
wire full,empty;
asy_fifo uut(.wclk(wclk),.rclk(rclk),.rst(rst),.wen(wen),.ren(ren),.din(din),.dout(dout),.empty(empty),.full(full));
always #5 wclk=~wclk;
always #10 rclk=~rclk;
initial begin
wclk=0;rclk=0;rst=1;wen=0;ren=0;din=8'd0;
#5 rst=0;wen=1;din=8'haa;
@(posedge wclk) din=8'hbb;
@(posedge wclk) din=8'hcc;
@(posedge wclk) din=8'hdd;
@(posedge wclk) din=8'hee;
@(posedge wclk) din=8'hff;
@(posedge wclk) din=8'h99;
@(posedge wclk) din=8'h88;
@(posedge rclk) wen=0;ren=1;
#200 $stop;
end
endmodule
