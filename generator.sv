package generator;

    //import definitions::*;
    import atm_cell::*;
    
    /////////////////////////////////////////////////////////////////////////////
    class UNI_generator;
    
        UNI_cell blueprint;	// Blueprint for generator
        mailbox  gen2drv;	// Mailbox to driver for cells
        event    drv2gen;	// Event from driver when done with cell
        int      nCells;	// Number of cells for this generator to create
        int	    PortID;	// Which Rx port are we generating?
       
        function new (
            input mailbox gen2drv,
    		input event drv2gen,
    		input int nCells,
    		input int PortID
        );
            this.gen2drv = gen2drv;
            this.drv2gen = drv2gen;
            this.nCells  = nCells;
            this.PortID  = PortID;
            blueprint = new();
        endfunction : new
    
        task run();
            UNI_cell c;
            repeat (nCells) begin
                assert(blueprint.randomize());
                $cast(c, blueprint.copy());
                c.display($sformatf("@%0t: Gen%0d: ", $time, PortID));
                gen2drv.put(c);
    	        @drv2gen;		// Wait for driver to finish with it
            end
        endtask : run
    
    endclass : UNI_generator
    
    
    
    /////////////////////////////////////////////////////////////////////////////
    class NNI_generator;
    
        NNI_cell blueprint;	// Blueprint for generator
        mailbox  gen2drv;	// Mailbox to driver for cells
        event    drv2gen;	// Event from driver when done with cell
        int      nCells;	// Number of cells for this generator to create
        int	    PortID;	// Which Rx port are we generating?
    
        function new (
            input mailbox gen2drv,
    		input event drv2gen,
    		input int nCells,
    		input int PortID
        );
            this.gen2drv = gen2drv;
            this.drv2gen = drv2gen;
            this.nCells  = nCells;
            this.PortID  = PortID;
            blueprint = new();
        endfunction : new
    
    
        task run();
            NNI_cell c;
            repeat (nCells) begin
    	        assert(blueprint.randomize());
    	        $cast(c, blueprint.copy());
    	        c.display($sformatf("Gen%0d: ", PortID));
    	        gen2drv.put(c);
    	        @drv2gen;		// Wait for driver to finish with it
            end
        endtask : run
    
    endclass : NNI_generator

endpackage

