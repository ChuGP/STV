package com.github.davidmoten.geo;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class CoverageLongsTest {
    CoverageLongs gp ;
    long[] hashes = { 5,6,7,8};
    @Before
    public void setUp() throws Exception {

        gp = new CoverageLongs(hashes,4,7);
    }

    @Test
    public void getHashes() {
        long[] ans = { 5,6,7,8};
        assertArrayEquals(ans,gp.getHashes());
    }

    @Test
    public void getHashLength() {
        assertEquals(5,gp.getHashLength(),0);
        CoverageLongs temp = new CoverageLongs(hashes,0,7);
        assertEquals(0,temp.getHashLength(),0);
//        CoverageLongs temp1 = new CoverageLongs(hashes,0,5);
    }

    @Test
    public void toString_test(){
        CoverageLongs temp = new CoverageLongs(hashes,0,7);
        temp.toString();
    }
}