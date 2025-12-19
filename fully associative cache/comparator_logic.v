module comparator_logic #(
    parameter CACHE_SIZE = 4,
    parameter ADDR_WIDTH = 8
)(
    input wire [ADDR_WIDTH-1:0] address,
 
    input wire [ADDR_WIDTH-1:0] tag_out_0, tag_out_1, tag_out_2, tag_out_3,
    input wire valid_0, valid_1, valid_2, valid_3,
    
    output reg hit,
    output reg [CACHE_SIZE-1:0] hit_lines,
    output reg [1:0] hit_index  
);

    reg [CACHE_SIZE-1:0] match_lines;

    always @(*) begin
        match_lines = 4'b0000;
        hit = 1'b0;
        hit_index = 2'b00;
        
        if (valid_0 && (tag_out_0 == address)) begin
            match_lines[0] = 1'b1;
            hit_index = 2'b00;
        end
        if (valid_1 && (tag_out_1 == address)) begin
            match_lines[1] = 1'b1;
            hit_index = 2'b01;
        end
        if (valid_2 && (tag_out_2 == address)) begin
            match_lines[2] = 1'b1;
            hit_index = 2'b10;
        end
        if (valid_3 && (tag_out_3 == address)) begin
            match_lines[3] = 1'b1;
            hit_index = 2'b11;
        end
        
        hit_lines = match_lines;
        hit = |match_lines;  
    end

endmodule