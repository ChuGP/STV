package com.github.davidmoten.geo;

import org.junit.Before;
import org.junit.Test;

import java.util.HashSet;
import java.util.Set;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class CoverageTest {
    Coverage gp;
    Set<String> hashes;
    @Before
    public void setUp() throws Exception {
        hashes = new HashSet<String>();
        hashes.add("test1");
        hashes.add("test2");
        hashes.add("test3");
        hashes.add("test4");
        gp = new Coverage(hashes,9);


    }

    @Test
    public void Coverage() {
        long temp_hash[] = {3,4,5};

        CoverageLongs temp = new CoverageLongs(temp_hash,2,1);
        Coverage test = new Coverage(temp);
        assertEquals(3,test.getHashLength(),0);
    }

    @Test
    public void getHashLength() {
        Set<String> temp = new HashSet<String>();
        Coverage test = new Coverage(temp,9);
        assertEquals(0,test.getHashLength(),0);

        assertEquals(5,gp.getHashLength(),0);
    }

    @Test
    public void getRatio(){
        assertEquals(9,gp.getRatio(),0);
    }
    @Test
    public void getHashes() {

        assertEquals(gp.getHashes(),gp.getHashes());
    }

    @Test
    public void toString_test() {

        assertEquals("Coverage [hashes=[test4, test2, test3, test1], ratio=9.0]",gp.toString());
    }

}