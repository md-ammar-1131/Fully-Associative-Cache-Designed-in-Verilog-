module replacement_policy #(
    parameter CACHE_SIZE = 4
)(
    input wire clk,
    input wire reset,
    input wire [CACHE_SIZE-1:0] access_lines, 
    input wire update_policy,                 
    
    output reg [1:0] replace_index,  
    output reg replacement_ready
);

    reg [1:0] rr_pointer;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            rr_pointer <= 2'b00;
            replacement_ready <= 1'b1;
            replace_index <= 2'b00;  
        end else if (update_policy) begin
        
            rr_pointer <= rr_pointer + 1;
            replace_index <= rr_pointer + 1;  
        end else begin
            replace_index <= rr_pointer;  
        end
    end

endmodule