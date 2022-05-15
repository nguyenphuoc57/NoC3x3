module VA_DoAn2 (data_flit_in,data_source_address_VC0,data_source_address_VC1,data_flit_out_VC0,data_flit_out_VC1,empty0,empty1,clk,error);
/////////Khai bao param bit 
///Type
//Header: 10 
//Body: 00
//Tail: 01
//Header+tail: 11
////////
parameter bit_of_flit = 32;
parameter bit_of_address = 4;
////////Input va Output
input [bit_of_flit - 1:0] data_flit_in;
input [bit_of_address - 1 :0] data_source_address_VC0,data_source_address_VC1;
input empty0,empty1,clk;
output reg [bit_of_flit - 1:0] data_flit_out_VC0, data_flit_out_VC1;
output reg error;
////Type
wire [1:0] typeFlit;
////Address of filt
wire[3:0] address_source;
assign address_source = data_flit_in[29:26];
assign typeFlit = data_flit_in[31:30];
/////////////
///Type
//Header: 10 
//Body: 00
//Tail: 01
//Header+tail: 11
////////////
reg [31:0] temp0;
reg [31:0] temp1;

///////////
always @(negedge clk) begin
//    if(data_flit_in != 32'b0) begin
      if(typeFlit == 2'b11 && data_flit_in[21] == 1'b1) begin
            if(empty0)
                data_flit_out_VC0 <= data_flit_in;
            else if(empty1)
                data_flit_out_VC1 <= data_flit_in;  
                  
      end
      else if (typeFlit == 2'b10 || typeFlit ==  2'b11)begin
	   // temp0<=data_flit_out_VC0;
		// temp1<=data_flit_out_VC1;
		//////////////////////////////////// 
		 if(empty0==1 && empty1==1) begin             
             if(data_flit_in==temp1 && data_flit_in==temp0) begin
                data_flit_out_VC0<=32'bx;
                 temp0<=data_flit_in;
                 temp1<=data_flit_in;
             end
		     else begin
		      data_flit_out_VC0<=data_flit_in;
			  temp0<=data_flit_in;
			  temp1<=data_flit_in;
			  data_flit_out_VC1<=32'bx;
		 end
		 end
		//////////////////////////////////
		 if(empty0==1 && empty1==0) begin
             if(data_flit_in==temp1)begin
                data_flit_out_VC0<=32'bx;
                 temp0<=data_flit_in;
                 temp1<=data_flit_in;
             end
             else begin
                  data_flit_out_VC0<=data_flit_in;
                  temp0<=data_flit_in;
                  temp1<=data_flit_in;
                  data_flit_out_VC1<=32'bx;
             end
          end
		 //////////////////////////////////// 
		 if(empty0==0 && empty1==1) begin
             if(data_flit_in==temp0)begin
                 data_flit_out_VC1<=32'bx;
                 temp0<=data_flit_in;
                 temp1<=data_flit_in;
             end
		 else begin
		         data_flit_out_VC1<=data_flit_in;
				 temp0<=data_flit_in;
			     temp1<=data_flit_in;
				data_flit_out_VC0<=32'bx;
		 end
		 end
		//////////////////////////////////
          if (empty0==0 && empty1==0)
		    error<=1;
	    /////////////////////////////////
		 if (data_flit_out_VC0==temp0)
		      data_flit_out_VC0<=32'bx;
		 if (data_flit_out_VC1==temp1)
		      data_flit_out_VC1<=32'bx;
	   //////////////////////////////////////
end
	  //////////////////////////////////
      else if (typeFlit ==2'b00 || typeFlit ==2'b01) begin

		  // temp0<=32'b0;
		   //temp1<=32'b0;
           if(data_source_address_VC0==address_source) begin
	              data_flit_out_VC0 <= data_flit_in;
				  data_flit_out_VC1 <= 32'bx;
	//			  error <= 1'b0;	      	  
	       end
           else if(data_source_address_VC1==address_source) begin
	              data_flit_out_VC1 <= data_flit_in;
				  data_flit_out_VC0 <= 32'bx;
	       end
	       else begin
	           data_flit_out_VC0 <= 32'bx;
			   data_flit_out_VC1 <= 32'bx;
	       end	       
	  end


end
 

endmodule