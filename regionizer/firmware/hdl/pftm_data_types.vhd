library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_constants.all;

package pftm_data_types is
    subtype pt_t is signed(15 downto 0);
    subtype etaphi_t is signed(9 downto 0);
    subtype z0_t is signed(9 downto 0);

    type particleType is ( EmCalo, HadCalo, Track );

    type particle is record
        pt  : pt_t;
        eta : etaphi_t;
        phi : etaphi_t;
        pt2 : pt_t; --this is emPt for HadCalo objs, and ptErr for EmCalo and Track;
        ids : std_logic_vector(9 downto 0);-- this is 'isEM' for HadCalo, z0 for Track, nothing for EmCalo;
    end record;

    type particles is array(natural range <>) of particle;

    subtype word32 is std_logic_vector(31 downto 0);
    type words32 is array(natural range <>) of word32;
 
    function null_particle return particle;
    function shift_phi(constant p : particle; constant dphi : etaphi_t) return particle;
    function shift_eta(constant p : particle; constant deta : etaphi_t) return particle;

    function emPt(constant p : particle) return pt_t;
    function ptErr(constant p : particle) return pt_t;
    function z0(constant p : particle) return z0_t;
    function isEM(constant p : particle) return std_logic;

    function to_etaphi(constant ieta : integer) return etaphi_t;
    function to_pt(constant ipt : integer) return pt_t;
    function to_z0(constant iz0 : integer) return z0_t;
    function to_32b_hi(constant p : particle) return word32;
    function to_32b_lo(constant p : particle) return word32;
    function to_particle(constant hi : word32; constant lo : word32) return particle;
end;

package body pftm_data_types is

    function null_particle return particle is
    begin
        return (pt => (others=>'0'), eta => (others=>'0'), phi => (others=>'0'), pt2 => (others=>'0'), ids => (others=>'0'));
    end;

    function to_etaphi(constant ieta : integer) return etaphi_t is
    begin
        return to_signed(ieta, etaphi_t'length);
    end;

    function to_pt(constant ipt : integer) return pt_t is
    begin
        return to_signed(ipt, pt_t'length);
    end;
    
    function to_z0(constant iz0 : integer) return z0_t is
    begin
        return to_signed(iz0, z0_t'length);
    end;
    
    function to_32b_hi(constant p : particle) return word32 is
    variable ret : word32;
    begin
        ret(31 downto 30) := (others => '0');
        ret(29 downto 20) := p.ids;
        ret(19 downto 10) := std_logic_vector(p.phi);
        ret( 9 downto  0) := std_logic_vector(p.eta);
        return ret;
    end;

    function to_32b_lo(constant p : particle) return word32 is
    variable ret : word32;
    begin
        ret(31 downto 16) := std_logic_vector(p.pt2);
        ret(15 downto  0) := std_logic_vector(p.pt);
        return ret;
    end;

    function to_particle(constant hi : word32; constant lo : word32) return particle is
    begin
        return (pt => pt_t(lo(15 downto 0)), 
                eta => etaphi_t(hi(9 downto 0)), 
                phi => etaphi_t(hi(19 downto 10)),
                pt2 => pt_t(lo(31 downto 16)),
                ids => hi(29 downto 20));
    end;

    function shift_phi(constant p : particle; constant dphi : etaphi_t) return particle is
    variable ret : particle;
    begin
        ret := p;
        if p.pt > 0 then ret.phi := ret.phi + dphi; end if;
        return ret;
    end;

    function shift_eta(constant p : particle; constant deta : etaphi_t) return particle is
    variable ret : particle;
    begin
        ret := p;
        if p.pt > 0 then ret.eta := ret.eta + deta; end if;
        return ret;
    end;

    function emPt(constant p : particle) return pt_t is
    begin
        return p.pt2;
    end;

    function ptErr(constant p : particle) return pt_t is
    begin
        return p.pt2;
    end;

    function z0(constant p : particle) return z0_t is
    begin
        return z0_t(unsigned(p.ids));
    end;

    function isEM(constant p : particle) return std_logic is
    begin
        return p.ids(0);
    end;


end;
