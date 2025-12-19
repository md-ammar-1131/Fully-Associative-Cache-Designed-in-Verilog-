`timescale 1ns/1ps

module testbench_working;
    reg clk, reset;
    reg [7:0] addr;
    reg [7:0] data_in;
    reg read, write;
    wire [7:0] data_out;
    wire hit, miss, ready;
    
    integer test_count;
    
    fully_associative_cache dut (
        .clk(clk),
        .reset(reset),
        .addr(addr),
        .data_in(data_in),
        .read(read),
        .write(write),
        .data_out(data_out),
        .hit(hit),
        .miss(miss),
        .ready(ready)
    );
    
    always #5 clk = ~clk;
    
    initial begin
       
        $dumpfile("cache_waves.vcd");
        $dumpvars(0, testbench_working);
        
        clk = 0;
        reset = 1;
        addr = 8'h00;
        data_in = 8'h00;
        read = 0;
        write = 0;
        test_count = 0;
        
        $display("==============================================");
        $display("        CACHE SIMULATION STARTING");
        $display("==============================================");
     
        #20 reset = 0;
        
        $display("[SYSTEM] Reset released at time %0t ns", $time);
        
        test_count = 1;
        $display("\n--- Test %0d: Write then Read (Basic Operation) ---", test_count);
       
        wait_for_ready();
        @(negedge clk);
        addr = 8'h10;
        data_in = 8'hAA;
        write = 1;
        $display("[CPU] WRITE Operation -> Address: 0x%02h, Data: 0x%02h", 8'h10, 8'hAA);
        wait_for_ready();
        @(negedge clk);
        write = 0;
        $display("[CPU] Write operation completed successfully");
        #20;
        
        wait_for_ready();
        @(negedge clk);
        addr = 8'h10;
        read = 1;
        $display("[CPU] READ Operation -> Address: 0x%02h", 8'h10);
        wait_for_ready();
        @(negedge clk);
        read = 0;
        if (hit) begin
            $display("[CACHE] *** HIT *** Data Retrieved: 0x%02h", data_out);
        end else if (miss) begin
            $display("[CACHE] *** MISS *** Data not in cache");
        end
        #50;
        
        test_count = 2;
        $display("\n--- Test %0d: Read Miss (Cache Empty) ---", test_count);
        
        wait_for_ready();
        @(negedge clk);
        addr = 8'h20;
        read = 1;
        $display("[CPU] READ Operation -> Address: 0x%02h", 8'h20);
        wait_for_ready();
        @(negedge clk);
        read = 0;
        if (hit) begin
            $display("[CACHE] *** HIT *** Data Retrieved: 0x%02h", data_out);
        end else if (miss) begin
            $display("[CACHE] *** MISS *** Data not in cache");
        end
        #50;
       
        test_count = 3;
        $display("\n--- Test %0d: Read Hit (After Miss) ---", test_count);
        
        wait_for_ready();
        @(negedge clk);
        addr = 8'h20;
        read = 1;
        $display("[CPU] READ Operation -> Address: 0x%02h", 8'h20);
        wait_for_ready();
        @(negedge clk);
        read = 0;
        if (hit) begin
            $display("[CACHE] *** HIT *** Data Retrieved: 0x%02h", data_out);
        end else if (miss) begin
            $display("[CACHE] *** MISS *** Data not in cache");
        end
        #50;
        
        test_count = 4;
        $display("\n--- Test %0d: Fill Cache (Multiple Writes) ---", test_count);
        
        wait_for_ready();
        @(negedge clk);
        addr = 8'h30;
        data_in = 8'h33;
        write = 1;
        $display("[CPU] WRITE Operation -> Address: 0x%02h, Data: 0x%02h", 8'h30, 8'h33);
        wait_for_ready();
        @(negedge clk);
        write = 0;
    
        wait_for_ready();
        @(negedge clk);
        addr = 8'h40;
        data_in = 8'h44;
        write = 1;
        $display("[CPU] WRITE Operation -> Address: 0x%02h, Data: 0x%02h", 8'h40, 8'h44);
        wait_for_ready();
        @(negedge clk);
        write = 0;
        
        wait_for_ready();
        @(negedge clk);
        addr = 8'h50;
        data_in = 8'h55;
        write = 1;
        $display("[CPU] WRITE Operation -> Address: 0x%02h, Data: 0x%02h", 8'h50, 8'h55);
        wait_for_ready();
        @(negedge clk);
        write = 0;
        #50;
    
        test_count = 5;
        $display("\n--- Test %0d: Verify All Cached Data ---", test_count);
        
        wait_for_ready();
        @(negedge clk);
        addr = 8'h10;
        read = 1;
        $display("[CPU] READ Operation -> Address: 0x%02h", 8'h10);
        wait_for_ready();
        @(negedge clk);
        read = 0;
        if (hit) begin
            $display("[CACHE] *** HIT *** Data Retrieved: 0x%02h", data_out);
        end else if (miss) begin
            $display("[CACHE] *** MISS *** Data not in cache");
        end
        
        wait_for_ready();
        @(negedge clk);
        addr = 8'h20;
        read = 1;
        $display("[CPU] READ Operation -> Address: 0x%02h", 8'h20);
        wait_for_ready();
        @(negedge clk);
        read = 0;
        if (hit) begin
            $display("[CACHE] *** HIT *** Data Retrieved: 0x%02h", data_out);
        end else if (miss) begin
            $display("[CACHE] *** MISS *** Data not in cache");
        end
        
        wait_for_ready();
        @(negedge clk);
        addr = 8'h30;
        read = 1;
        $display("[CPU] READ Operation -> Address: 0x%02h", 8'h30);
        wait_for_ready();
        @(negedge clk);
        read = 0;
        if (hit) begin
            $display("[CACHE] *** HIT *** Data Retrieved: 0x%02h", data_out);
        end else if (miss) begin
            $display("[CACHE] *** MISS *** Data not in cache");
        end
     
        wait_for_ready();
        @(negedge clk);
        addr = 8'h40;
        read = 1;
        $display("[CPU] READ Operation -> Address: 0x%02h", 8'h40);
        wait_for_ready();
        @(negedge clk);
        read = 0;
        if (hit) begin
            $display("[CACHE] *** HIT *** Data Retrieved: 0x%02h", data_out);
        end else if (miss) begin
            $display("[CACHE] *** MISS *** Data not in cache");
        end
        
        wait_for_ready();
        @(negedge clk);
        addr = 8'h50;
        read = 1;
        $display("[CPU] READ Operation -> Address: 0x%02h", 8'h50);
        wait_for_ready();
        @(negedge clk);
        read = 0;
        if (hit) begin
            $display("[CACHE] *** HIT *** Data Retrieved: 0x%02h", data_out);
        end else if (miss) begin
            $display("[CACHE] *** MISS *** Data not in cache");
        end
        #100;
        
        $display("\n==============================================");
        $display("      ALL TESTS COMPLETED SUCCESSFULLY");
        $display("        Simulation Time: %0t ns", $time);
        $display("==============================================");
        $finish;
    end
    
    task wait_for_ready;
        begin
            if (ready == 1'b0) begin
                $display("[SYSTEM] Cache busy... waiting for ready signal");
                @(posedge ready);
                $display("[SYSTEM] Cache ready for next operation");
            end
        end
    endtask
    
    always @(posedge clk) begin
        if (hit && read) begin
            $display("[CACHE] >>> HIT detected for address 0x%02h", addr);
        end
        if (miss && read) begin
            $display("[CACHE] >>> MISS detected for address 0x%02h", addr);
        end
    end
    
    always @(posedge hit) begin
        $display("[SIGNAL] HIT signal activated");
    end
    
    always @(posedge miss) begin
        $display("[SIGNAL] MISS signal activated");
    end
    
    initial begin
        #5000; 
        $display("==============================================");
        $display("            SIMULATION TIMEOUT!");
        $display("  Simulation ran for 5000ns without");
        $display("        completing all tests");
        $display("==============================================");
        $finish;
    end
    
endmodule