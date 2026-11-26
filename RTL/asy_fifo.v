module asy_fifo(input wclk,rclk,rst,wen,ren,
                input [7:0]din,
                output reg [7:0]dout,
                output empty,full);
reg [7:0]mem[7:0];
reg [3:0]wptr,rptr;
reg [3:0]w1,w2,r1,r2;
integer i;
always @(posedge wclk or posedge rst)
begin
if (rst)
begin
     wptr<=0;
     for(i=0;i<8;i=i+1)
     mem[i]<=0;
end
else if(wen && full==1'b0)
begin
     mem[wptr]<=din;
     wptr<=wptr+1'b1;
end
end
always @(posedge rclk or posedge rst)
begin
if (rst)
rptr<=1'b0;
else if(ren && empty==1'b0)
begin
     dout<=mem[rptr];
     rptr<=rptr+1'b1;
end
end
always @(posedge wclk or posedge rst)
begin
if (rst)
begin
     r1<=1'b0;
     r2<=1'b0;
end
else begin
          r1<=rptr;
          r2<=r1;
     end
end
always @(posedge rclk or posedge rst)
begin
if (rst)
begin
     w1<=1'b0;
     w2<=1'b0;
end
else begin
          w1<=wptr;
          w2<=w1;
end
end
assign full=((wptr[3]^r2[3]) && (wptr[2:0]==r2[2:0]));
assign empty=(w2 == rptr);
endmodule
