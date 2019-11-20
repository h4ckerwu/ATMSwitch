interface LookupTable;

    import definitions::*;

    parameter int  Asize  = 8;
    parameter int  Arange = 1<<Asize;
    parameter type dType  = bit;

    dType Mem [0:Arange-1];

    // Function to perform write
    function void write (
        input [Asize-1:0] addr,
        input dType data 
    );
     
        Mem[addr] = data;
        //$display("@%0t: lut.write Mem[%0x]=%0x", $time, addr, Mem[addr]);
    endfunction

    // Function to perform read
    function dType read (input bit [Asize-1:0] addr);
        //$display("@%0t: lut.read Mem[%0x]=%0x", $time, addr, Mem[addr]);     
        return (Mem[addr]);
    endfunction
endinterface

