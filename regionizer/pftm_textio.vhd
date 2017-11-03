library std;
use std.textio.all;
use std.env.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

package pftm_textio is
    procedure read_particle( variable L: inout line; variable p : out particle );
    procedure write_particle(variable L: inout line; variable p : in  particle );

    procedure read_frame( file F: text; 
                          variable evt : inout natural; 
                          variable cnt : inout natural;
                          variable ps : out particles(N_SECTORS-1 downto 0) );
    procedure write_frame(file F: text; 
                          variable frame : in natural; 
                          variable ps    : in particles(N_OBJ-1 downto 0);
                          variable valid : in std_logic );
end;

package body pftm_textio is
    procedure read_particle( variable L: inout line; variable p : out particle ) is
        variable tmp : integer;
        variable b   : std_logic;
    begin
        read(L, tmp); p.pt := to_pt(tmp);
        read(L, tmp); p.eta := to_etaphi(tmp);
        read(L, tmp); p.phi := to_etaphi(tmp);
        read(L, tmp); p.emPt := to_pt(tmp);
        read(L, p.isEM);
    end procedure;

    procedure write_particle( variable L: inout line; variable p : in particle ) is
    begin
        write(L, to_integer(p.pt),  field => 4); 
        write(L, to_integer(p.eta), field => 5); 
        write(L, to_integer(p.phi), field => 5); 
        write(L, to_integer(p.emPt),  field => 4); 
        write(L, string'(" "));
        write(L, p.isEM);
    end procedure;

    procedure read_frame(file F: text; 
                         variable evt : inout natural; 
                         variable cnt : inout natural;
                         variable ps : out particles(N_SECTORS-1 downto 0) ) is
        variable L : line;
        variable id    : string(1 to 5);
        variable iframe: integer;
        variable colon : string(1 to 2);
    begin
        readline(F, L);
        --report "read line of length " & integer'image(L.all'length);
        if L.all'length = 0 or L.all(1 to 5) /= "Frame" then
            evt := 0; cnt := 0; ps := (others => null_particle);
        else
            read(L, id); read(L, iframe); read(L, colon);
            read(L, evt);
            read(L, cnt);
            --report "read frame " & integer'image(ifame) & ": event " & integer'image(evt) & ", counter " & integer'image(cnt);
            for i in 0 to N_SECTORS-1 loop
                read_particle(L, ps(i));
            end loop;
        end if;
    end procedure;

    procedure write_frame(file F: text; 
                          variable frame : in natural; 
                          variable ps    : in particles(N_OBJ-1 downto 0);
                          variable valid : in std_logic ) is
        variable L : line;
    begin
        write(L, string'("Frame ")); 
        write(L, frame, field => 4); 
        write(L, string'(" :"));  
        for i in 0 to N_OBJ-1 loop
            write(L, string'("       "));
            write_particle(L, ps(i));
        end loop;
        write(L, string'("       "));
        write(L, valid);
        writeline(F, L);
    end procedure;
end;
