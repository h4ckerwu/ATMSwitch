interface Utopia;
  parameter int IfWidth = 8;
  import definitions::*;

  logic [IfWidth-1:0] data;
  bit clk_in, clk_out;
  bit soc, en, clav, valid, ready, reset, selected;

  ATMCellType ATMcell;  // union of structures for ATM cells

  modport TopReceive (
    input  data, soc, clav, 
    output clk_in, reset, ready, clk_out, en, ATMcell, valid );

  modport TopTransmit (
    input  clav, 
    inout  selected,
    output clk_in, clk_out, ATMcell, data, soc, en, valid, reset, ready );

  modport CoreReceive (
    input  clk_in, data, soc, clav, ready, reset,
    output clk_out, en, ATMcell, valid );

  modport CoreTransmit (
    input  clk_in, clav, ATMcell, valid, reset,
    output clk_out, data, soc, en, ready );

   clocking cbr @(negedge clk_out);
      input clk_in, clk_out, ATMcell, valid, reset, en, ready;
      output data, soc, clav;
   endclocking : cbr
   modport TB_Rx (clocking cbr);

   clocking cbt @(negedge clk_out);
      input  clk_out, clk_in, ATMcell, soc, en, valid, reset, data, ready;
      output clav;
   endclocking : cbt
   modport TB_Tx (clocking cbt);

endinterface


