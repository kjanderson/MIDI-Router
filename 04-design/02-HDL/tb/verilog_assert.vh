`define ASSERT(signal, value) \
    if (signal != value) begin \
        $display("ASSERTION FAILED at %0t in %m: signal != value", $time); \
        $finish; \
    end

