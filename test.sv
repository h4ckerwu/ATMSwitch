program automatic test #(
    parameter int NumRx = 4, 
    parameter int NumTx = 4
) (
    Utopia.TB_Rx Rx[0:NumRx-1],
    Utopia.TB_Tx Tx[0:NumTx-1],
    cpu_ifc.Test mif,
    input logic rst, clk
);

    //import definitions::*;
    // Miscellaneous control interfaces
    logic Initialized;

    //initial begin
    //$display("Simulation was run with conditional compilation settings of:");
    //$display("`define TxPorts %0d", NumTx);
    //$display("`define RxPorts %0d", NumRX);
    //`ifdef FWDALL
    //  $display("`define FWDALL");
    //`endif
    //`ifdef SYNTHESIS
    //  $display("`define SYNTHESIS");
    //`endif
    //$display("");
    //end

    //`include "environment.sv"
    import environment::*;
    import unique_config::*;
    Environment env;

    // class Driver_cbs_drop extends Driver_cbs;
    //  virtual task pre_tx(input ATM_cell cell, ref bit drop);
    //     // Randomly drop 1 out of every 100 transactions
    //     drop = ($urandom_range(0,99) == 0);
    //   endtask
    // endclass

    class Config_10_cells extends Config;
       constraint ten_cells {nCells == 10; }

       function new(input int NumRx,NumTx);
          super.new(NumRx,NumTx);
       endfunction : new
    endclass : Config_10_cells


    initial begin
        env = new(Rx, Tx, NumRx, NumTx, mif);

        begin // Just simulate for 10 cells
            Config_10_cells c10 = new(NumRx,NumTx);
            env.cfg = c10;
        end

        env.gen_cfg();
        env.cfg.nCells = 100_000;
        $display("nCells = 100_000");
        env.build();

        //     begin             // Create error injection callback
        //       Driver_cbs_drop dcd = new();
        //       env.drv.cbs.push_back(dcd); // Put into driver's Q
        //     end
        env.run();
        env.wrap_up();
    end

endprogram // test



