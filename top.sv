//`define SYNTHESIS	// conditional compilation flag for synthesis
//`define FWDALL		// conditional compilation flag to forward cells

//`define TxPorts 4  // set number of transmit ports
//`define RxPorts 4  // set number of receive ports


module top;

    parameter int NumRx = 4;
    parameter int NumTx = 4;

    logic rst, clk;

    // System Clock and Reset
    initial begin
    $dumpfile("dump.fsdb");
    $dumpvars;
        rst = 0; clk = 0;
        #5ns rst = 1;
        #5ns clk = 1;
        #5ns rst = 0; clk = 0;
        forever 
            #5ns clk = ~clk;
    end

    Utopia Rx[0:NumRx-1] ();	// NumRx x Level 1 Utopia Rx Interface
    Utopia Tx[0:NumTx-1] ();	// NumTx x Level 1 Utopia Tx Interface
    cpu_ifc mif(clk);	  // Intel-style Utopia parallel management interface
    squat #(NumRx, NumTx) squat(Rx, Tx, mif, rst, clk);	// DUT
    test  #(NumRx, NumTx) t1(Rx, Tx, mif, rst, clk);	// Test

endmodule : top


