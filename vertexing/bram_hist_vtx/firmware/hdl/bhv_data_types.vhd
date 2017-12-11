library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all; 

package bhv_data_types is
    constant BHV_NTRACKS : natural := N_IN_CLOCK;
    constant BHV_NSECTORS : natural := 2*N_SECTORS;

    constant BHV_NBINS : natural := 72;
    constant BHV_NHALFBINS : natural := BHV_NBINS/2;

    subtype ptsum_t is unsigned(8 downto 0);
    subtype twoptsums_t is unsigned(17 downto 0);
    subtype zbin_t is unsigned(6 downto 0); -- goes up to 128
    type zbin_vt is record
        bin   : zbin_t;
        valid : std_logic;
    end record;    

    type ptsum_arr_t is array (natural range <>) of ptsum_t; 
    type zbin_arr_t is array (natural range <>) of zbin_t; 

    subtype ptsum_wide_t is unsigned(13 downto 0); 
    type    ptsum_wide_arr_t is array(natural range <>) of ptsum_wide_t;

    constant BHV_MAXPT : unsigned(pt_t'length-3 downto 0) := to_unsigned(100, pt_t'length-2);

    function to_zbin(constant iz : natural) return zbin_t;

    function find_zbin(constant z0 : z0_t) return zbin_vt;
    function zbin_to_z0(constant iz : zbin_t) return z0_t;
    
    function to_ptsum(constant iz : natural) return ptsum_t;
    function to_ptsum(constant pt : pt_t) return ptsum_t;
    function trunc_add(constant pt1, pt2 : ptsum_t) return ptsum_t;

    function to_wide(constant ptsum : ptsum_t) return ptsum_wide_t;
    function to_wide(constant ptsums : ptsum_arr_t) return ptsum_wide_arr_t;
end;

package body bhv_data_types is
    function to_zbin(constant iz : natural) return zbin_t is
    begin
        return zbin_t(to_unsigned(iz, zbin_t'length));
    end;


    function find_zbin(constant z0 : z0_t) return zbin_vt is
        variable zshift : signed(zbin_t'length downto 0);
        variable ret : zbin_vt;
    begin
        -- int zbin = (z0 >> BNV_SHIFT) + BHV_NHALFBINS; 
        zshift := z0((zbin_t'length+2) downto 3) + to_signed(BHV_NHALFBINS, zbin_t'length+1);

        -- if (zbin < 0)  return zbin_t(0);
        -- if (zbin > BHV_NBINS-1) return zbin_t(0);
        -- return zbin_t(zbin);
        if (zshift(zbin_t'length) = '1') or (zshift > to_signed(BHV_NBINS-1, zbin_t'length+1)) then
            ret.valid := '0';
            ret.bin := (others => '0');
        else
            ret.valid := '1';
            ret.bin := zbin_t(zshift(zbin_t'length-1 downto 0));
        end if;

        return ret;
    end;

    function zbin_to_z0(constant iz : zbin_t) return z0_t is
        variable high : signed(zbin_t'length downto 0);
        variable ret : z0_t;
    begin
        --int z = int(iz) - BHV_NHALFBINS;
        --return z0_t((z << BNV_SHIFT) + ( 1 << (BNV_SHIFT-1) ));
        high(zbin_t'length-1 downto 0) := signed(iz(zbin_t'length-1 downto 0));
        high(zbin_t'length) := '0';
        high := high - to_signed(BHV_NHALFBINS, zbin_t'length+1);
        ret(2 downto 0) := (2=> '1', others=> '0');
        ret(zbin_t'length+2 downto 3) := high(zbin_t'length downto 0);
        return ret;
    end;

    
    function to_ptsum(constant iz : natural) return ptsum_t is
    begin
        return to_unsigned(iz, ptsum_t'length);
    end;

    function to_ptsum(constant pt : pt_t) return ptsum_t is
        variable ptshift : unsigned(pt_t'length-3 downto 0);
    begin
        assert pt(pt_t'length-1) /= '1' report "to_ptsum called with a negative number" severity failure;
        ptshift(pt_t'length-3 downto 0) := unsigned(pt(pt_t'length-2 downto 1));
        if ptshift > BHV_MAXPT then
            return ptsum_t(BHV_MAXPT(ptsum_t'length-1 downto 0));
        else
            return ptsum_t(ptshift(ptsum_t'length-1 downto 0));
        end if;
    end;

    function trunc_add(constant pt1, pt2 : ptsum_t) return ptsum_t is
        --variable pt1x, pt2x, truesum : unsigned(ptsum_t'length downto 0);
        variable truesum : unsigned(ptsum_t'length downto 0);
    begin
        --pt1x(ptsum_t'length-1 downto 0) := pt1;
        --pt2x(ptsum_t'length-1 downto 0) := pt2;
        --pt1x(ptsum_t'length) := '0';
        --pt2x(ptsum_t'length) := '0';
        --truesum := pt1x + pt2x;
        truesum := ( '0' & pt1) + pt2;
        if truesum(ptsum_t'length) /= '1' then
            return ptsum_t(truesum(ptsum_t'length-1 downto 0));
        else
            return (others => '1');
        end if;
    end;

    function to_wide(constant ptsum : ptsum_t) return ptsum_wide_t is
        variable ret : ptsum_wide_t := (others => '0');
    begin
        ret(ptsum_t'length-1 downto 0) := ptsum;
        return ret;
    end;

    function to_wide(constant ptsums : ptsum_arr_t) return ptsum_wide_arr_t is
        variable ret : ptsum_wide_arr_t(ptsums'length-1 downto 0);
    begin
        for i in ptsums'length-1 downto 0 loop
            ret(i) := to_wide(ptsums(i));
        end loop;
        return ret;
    end;

end;

